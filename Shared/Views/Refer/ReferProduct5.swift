//
//  ReferProduct5.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/21/22.
//

import SwiftUI
import UIKit
import MessageUI



//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheetiMessage: String, Identifiable { // <--- note that it's now Identifiable
    case iMessageShareSheet
    var id: String {
        return self.rawValue
    }
}

//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheetShare: String, Identifiable { // <--- note that it's now Identifiable
    case generalShareSheet
    var id: String {
        return self.rawValue
    }
}



struct ReferProduct5: View {
    
    @ObservedObject var referralsViewModel = ReferralsViewModel()
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    @ObservedObject var companiesViewModel = CompaniesViewModel()
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @Binding var designSelection: [Any]
    
    var selectedOption: Int
    
    var selectedTextColor: Color = Color.white
        
    @Binding var selectedContact:[String]
    
    @Binding var userSuggestedCode:String
    
    
    
    @State private var customReferralCardSnapshot: UIImage? = nil
    @State var activeSheetiMessage: ActiveSheetiMessage? = nil
    @State var activeSheetShare: ActiveSheetShare? = nil
    
    @State private var isShowingMessages = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    @State var isEitherShareButtonTapped:Bool = false
    
    @State var wasPreviewButtonTapped:Bool = false
    
    @State var messageToRecipient:String = ""
    
    @State var finalMessage:String = ""
    
    
    //Use this variable to create an image
    var discountCardForReferralForPreview: some View {
        
        DiscountCardForReferralImageCreation(designSelection: designSelection, companyImage: "AthleisureLA-Icon-Teal", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
        
    }
    
    
    
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            
            DiscountCardForReferral(designSelection: designSelection, companyImage: "AthleisureLA-Icon-Teal", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                .padding(.bottom)
                .padding(.bottom)
            
            VStack (alignment: .center, spacing: 0) {
                Text("Add a personal note about this referral")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom, 10)
                
                Text("Tell \(selectedContact[1]) about the \(itemObject.order.title)!")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("Dark2"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                TextEditor(text: $messageToRecipient)
                    .frame(height: 80)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                
            }.padding(.horizontal)
            .frame(maxHeight: UIScreen.main.bounds.width / 3 * 2)
            
            
            
            //MARK: BUTTON TO SEND VIA IMESSAGE OR MORE CHANNELS
            //Check if there is a phone number available.. if so, then try to send via imessage
            VStack(alignment: .center, spacing: 0) {

                //MARK: IMESSAGE BUTTON
                Button(action: {
                    
                    //isShowingMessages = true
                    customReferralCardSnapshot = discountCardForReferralForPreview.snapshot()
                    self.activeSheetiMessage = .iMessageShareSheet
                    
                    let handle1 = companiesViewModel.snapshotOfCompanyProduct.first?.handle ?? ""
                    let customURLforSite = "https://" + itemObject.order.domain + "/products/" + handle1
                    
                    finalMessage = customURLforSite
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isEitherShareButtonTapped = true
                    }
                    
                }) {
                    HStack (alignment: .center) {
                        
                        Spacer()
                        
                        Text("Open iMessage")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)

                        Image(systemName: "arrow.up.forward")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.white)

                        Spacer()
                        
                    }
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.green))
                    .padding(.horizontal).padding(.horizontal)
                    .padding(.bottom)
                    
                }.sheet(item: $activeSheetiMessage) { [customReferralCardSnapshot] sheet in
                    
                    switch sheet {
                    case .iMessageShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customReferralCardSnapshot {
                            
                            MessageView(recipient: selectedContact[3], photo: unwrappedImage, messageToRecipient: finalMessage)
                            
                            //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }

                

                //MARK: SHARE BUTTON
                Button {
                    
                    customReferralCardSnapshot = discountCardForReferralForPreview.snapshot()
                    self.activeSheetShare = .generalShareSheet
                    
                    
                    let handle1 = companiesViewModel.snapshotOfCompanyProduct.first?.handle ?? ""
                    let customURLforSite = "https://" + itemObject.order.domain + "/products/" + handle1
                    
                    finalMessage = customURLforSite
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isEitherShareButtonTapped = true
                    }
                    
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.blue)
                        Text("More sharing options")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.blue)

                    }.padding(.bottom)
                        .padding(.vertical)
                }
                .sheet(item: $activeSheetShare) { [customReferralCardSnapshot] sheet2 in
                
                    switch sheet2 {
                    case .generalShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customReferralCardSnapshot {
                            ReferralShareSheet(activityItems: [finalMessage, unwrappedImage])
                            //ReferralShareSheet(activityItems: [messageToRecipient, unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }

            }
            .padding(.top)
            .padding(.vertical)
            .padding(.vertical)
            
            
            Spacer()
            
            
            if isEitherShareButtonTapped {
                
                Button {
                    
                    let newTotalReferrals = itemObject.referrals.count + 1
                    
                    let referralID = itemObject.ids.userID + "-" + itemObject.ids.itemID + String(newTotalReferrals) + "-" + itemsViewModel.randomString(of: 2)
                    
                    //move this step to when you click the button on Page 4 (i.e. after the discount code is created!)
                    referralsViewModel.addReferral(color: selectedOption, companyName: itemObject.order.companyName, customMessage: messageToRecipient, discountCode: userSuggestedCode, itemTitle: itemObject.order.title, companyID: itemObject.ids.companyID, itemID: itemObject.ids.itemID, referralID: referralID, userID: itemObject.ids.userID, email: itemObject.order.email, rewardAmount: itemObject.referrals.rewardAmount, rewardType: itemObject.referrals.rewardType, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2], recipientPhone: selectedContact[3], offerRewardAmount: 20)
                    
                    var newReferralIDsArray:[String] = []
                    
                    if itemObject.ids.referralIDs.isEmpty {
                        
                        newReferralIDsArray.append(referralID)
                        
                        itemsViewModel.updateItemForReferral(itemID: itemObject.ids.itemID, newReferralIDsArray: newReferralIDsArray)
                        
                    } else {
                        
                        for referralIDItem in itemObject.ids.referralIDs {
                            
                            newReferralIDsArray.append(referralIDItem)
                            
                        }
                        
                        newReferralIDsArray.append(referralID)
                        
                        itemsViewModel.updateItemForReferral(itemID: itemObject.ids.itemID, newReferralIDsArray: newReferralIDsArray)
                        
                    }
                    
                    isShowingReferExperience.toggle()
                    
                } label: {
                    BottomCapsuleButton(buttonText: "Done", color: Color("ReferPurple"))
                }
                
            } else {
                
                BottomCapsuleButton(buttonText: "Done", color: Color("Gray3"))
                
            }
        }
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
            self.companiesViewModel.getSnapshotOfCompanyProduct(companyID: itemObject.ids.companyID, productID: String(itemObject.ids.shopifyProductID))
            
            self.messageToRecipient = "Hi! Here's a $20 discount code for Athleisure LA! One of my favorites is the \(itemObject.order.title) (I gave it 5 stars). Check it out!"
            
        }
        .onDisappear {
            
            print("THIS VIEW IS DISAPPEARING!!!!!")
            
            
        }
        

        
    }
}




//Source: https://stackoverflow.com/questions/65660858/mfmessagecomposeviewcontroller-swiftui-buggy-behavior
//Another: https://www.twilio.com/blog/2018/07/sending-text-messages-from-your-ios-app-in-swift-using-mfmessagecomposeviewcontroller.html
//Another: https://stackoverflow.com/questions/39745761/sending-photo-using-mfmessagecomposeviewcontroller-is-disabled-in-ios10
//Notes on this one: https://developer.apple.com/documentation/messageui/mfmessagecomposeviewcontroller
struct MessageView: UIViewControllerRepresentable {
    
    var recipient: String
    
    let photo: UIImage
    
    var messageToRecipient: String
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var completion: () -> Void
        init(completion: @escaping ()->Void) {
            self.completion = completion
        }
        
        // delegate method
        func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                   didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator() {} // not using completion handler
    }
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        
        //If you can send text, add the text
        if MFMessageComposeViewController.canSendText() {
            
            vc.recipients = [recipient]
            vc.body = messageToRecipient
                
            //If you can send attachments, then add the attachment
            if MFMessageComposeViewController.canSendAttachments() {
                
                let dataImage = photo.pngData()
                
                //If there's an issue with the image, just skip it and show the VC
                guard dataImage != nil else {
                    vc.messageComposeDelegate = context.coordinator
                    return vc
                }
                
                //Add the attachment
                vc.addAttachmentData(dataImage!, typeIdentifier: "img/png", filename: "ImageData.png")
            }
        }

        //return the VC
        vc.messageComposeDelegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
    
    typealias UIViewControllerType = MFMessageComposeViewController
}



extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}




//MARK: creating a VC to show the share sheet

//Notes on this one: https://stackoverflow.com/questions/71712428/swiftui-how-to-snapshot-a-view-then-share
struct ReferralShareSheet: UIViewControllerRepresentable {
    //@Binding var isShareSheetActive: Bool
    
    //let photo: UIImage
    
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil     //[.postToFacebook]
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIViewController {

        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {  }
    
}





