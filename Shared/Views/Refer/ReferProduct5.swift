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
    
    
    
    @Binding var activeReviewOrReferSheet: ActiveReviewOrReferSheet?
    
    var itemObject: Items
    
    var designSelection: [Any]
    
    var selectedOption: Int
    
    var selectedTextColor: Color = Color.white
        
    @Binding var selectedContact:[String]
    
    var userSuggestedCode:String
    
    var createdReferralID:String
    
    
    @State private var customReferralCardSnapshot: UIImage? = nil
    @State var activeSheetiMessage: ActiveSheetiMessage? = nil
    @State var activeSheetShare: ActiveSheetShare? = nil
    
    @State private var isShowingMessages = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    @State var isEitherShareButtonTapped:Bool = false
    
    @State var wasPreviewButtonTapped:Bool = false
    
    @State var messageToRecipient:String = ""
    
    @State var finalMessage:String = ""
    
    @State var designSelectionForPreview:[Any] = []
    
    @State var customURLforSite = ""
    
    
    //Use this variable to create an image
    var discountCardForReferralForPreview: some View {
        
        DiscountCardForReferralImageCreation(designSelection1: designSelectionForPreview, companyImage: "AthleisureLA-Icon-Teal", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
        
    }
    
    
    
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            
            DiscountCardForReferral(designSelection: designSelection, companyImage: "AthleisureLA-Icon-Teal", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                .padding(.bottom)
                .padding(.bottom)
            
            GeometryReader { geo in
                
                VStack (alignment: .leading, spacing: 0) {
                    
                    Text("Add a personal message")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 10)
                        .padding(.bottom)
                    
                    TextEditor(text: $messageToRecipient)
                        .frame(width: geo.size.width, height: 120)
                        .shadow(radius: 2)
                        .padding(.bottom, 6)
                    
                    Group {
                        Text("We'll include this link:\n")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color("Gray1")) +
                        Text(customURLforSite)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("Gray1"))
                        
                    }.multilineTextAlignment(.leading)
                    .padding(.bottom)
                    
                }
            }.padding(.horizontal)
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width * 4 / 5)
            
            //MARK: BUTTON TO SEND VIA IMESSAGE OR MORE CHANNELS
            //Check if there is a phone number available.. if so, then try to send via imessage
            HStack(alignment: .center, spacing: 0) {

                //MARK: IMESSAGE BUTTON
                Button(action: {
                    
                    //isShowingMessages = true
                    customReferralCardSnapshot = discountCardForReferralForPreview.snapshot()
                    self.activeSheetiMessage = .iMessageShareSheet
                    
                    finalMessage = messageToRecipient + " " + customURLforSite
                    
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
                    .frame(width: UIScreen.main.bounds.width * 3 / 5 - 25)
                    
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

                Spacer()
                
                //MARK: SHARE BUTTON
                Button {
                    
                    customReferralCardSnapshot = discountCardForReferralForPreview.snapshot()
                    self.activeSheetShare = .generalShareSheet
                    
                    finalMessage = messageToRecipient + " " + customURLforSite
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isEitherShareButtonTapped = true
                    }
                    
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.blue)
                        Text("Share")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color.blue)
                        Spacer()
                    }.padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width * 2 / 5 - 25)
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
            .padding()
            .padding(.top)
            .padding(.vertical)
            
            
            Spacer()
            
            
            if isEitherShareButtonTapped {
                
                Button {
                    
                    let newTotalReferrals = itemObject.referrals.count + 1
                    
                    //move this step to when you click the button on Page 4 (i.e. after the discount code is created!)
                    
                    //CHANGE THIS CALL TO JUST UPDATE THE REFERRAL TO SAY ACTIVE RATHER THAN "CREATED"
                    
                    referralsViewModel.updateReferralWithCustomMessage(referralID: createdReferralID, customMessage: messageToRecipient, handle: itemObject.order.handle)
                    
                    var newReferralIDsArray:[String] = []
                    
                    if itemObject.ids.referralIDs.isEmpty {
                        
                        newReferralIDsArray = [createdReferralID]
                        
                        itemsViewModel.updateItemForReferral(itemID: itemObject.ids.itemID, newReferralIDsArray: newReferralIDsArray)
                        
                    } else {
                        
                        for referralIDItem in itemObject.ids.referralIDs {
                            
                            newReferralIDsArray.append(referralIDItem)
                            
                        }
                        
                        newReferralIDsArray.append(createdReferralID)
                        
                        itemsViewModel.updateItemForReferral(itemID: itemObject.ids.itemID, newReferralIDsArray: newReferralIDsArray)
                        
                    }
                    
                    activeReviewOrReferSheet = nil
                    
                } label: {
                    BottomCapsuleButton(buttonText: "Done", color: Color("ReferPurple"))
                }
                
            } else {
                
                BottomCapsuleButton(buttonText: "Done", color: Color.white)
                
            }
        }
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
            self.designSelectionForPreview = designSelection
            
            self.companiesViewModel.getSnapshotOfCompanyProduct(companyID: itemObject.ids.companyID, productID: String(itemObject.ids.shopifyProductID))
            
            self.messageToRecipient = "Hey, here's a $20 discount for \(itemObject.order.companyName)! Just use the code that I made you, or use this link.\n\nI gave the \(itemObject.order.title) 5 stars!"
            
            self.customURLforSite = "https://" + itemObject.order.domain + "/discount/" + userSuggestedCode + "?redirect=/products/" + itemObject.order.handle
            
            
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





