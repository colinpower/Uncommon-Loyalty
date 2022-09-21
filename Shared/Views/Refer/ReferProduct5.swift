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
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @Binding var selectedColor: Color
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
    
    
    var customReferralCardForPreview: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                
                RoundedRectangle(cornerRadius: 11).foregroundColor(Color.red)
                
            }.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width, alignment: .center)
            

            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            CardForLoyaltyProgram(cardColor: selectedColor, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: userSuggestedCode.isEmpty ? "YOUR-CODE" : userSuggestedCode, userFirstName: selectedContact[1], userLastName: selectedContact[2], userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                .frame(alignment: .center)
        }
        
    }
    
    var combinedCardForReferralForPreview: some View {
        
        CombinedCardForReferral(recommendedItemImageString: "redshorts", recommendedItemName: "Red Shorts", cardColor: selectedColor, textColor: selectedTextColor, companyImage: "AthleisureLA-Icon-Teal", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
            .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
        
    }
    
    
    
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            
            //customReferralCardForPreview
            
            ZStack(alignment: .center) {
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
                    
                combinedCardForReferralForPreview
                    .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
                
            }.frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width * 12 / 10)
            
            Spacer()
            
            //MARK: BUTTON TO SEND VIA IMESSAGE OR MORE CHANNELS
            //Check if there is a phone number available.. if so, then try to send via imessage
            VStack(alignment: .center, spacing: 0) {

                //MARK: IMESSAGE BUTTON
                Button(action: {
                    
                    //isShowingMessages = true
                    customReferralCardSnapshot = combinedCardForReferralForPreview.snapshot()
                    self.activeSheetiMessage = .iMessageShareSheet
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isEitherShareButtonTapped = true
                    }
                    
                }) {
                    HStack (alignment: .center) {
                        
                        Spacer()
                        
                        Text("Send to \(selectedContact[1]) via iMessage")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)

                        Image(systemName: "arrow.up.forward")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.white)

                        Spacer()
                        
                    }
                    .padding(.vertical, 20)
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.green))
                    .padding(.horizontal).padding(.horizontal)
                    
                }.sheet(item: $activeSheetiMessage) { [customReferralCardSnapshot] sheet in
                    
                    switch sheet {
                    case .iMessageShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customReferralCardSnapshot {
                            
                            MessageView(recipient: selectedContact[3], photo: unwrappedImage)
                            
                            //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }

                

                //MARK: SHARE BUTTON
                Button {
                    
                    customReferralCardSnapshot = combinedCardForReferralForPreview.snapshot()
                    self.activeSheetShare = .generalShareSheet
                    
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

                    }.padding(.vertical)
                        .padding(.top)
                }
                .sheet(item: $activeSheetShare) { [customReferralCardSnapshot] sheet2 in
                
                    switch sheet2 {
                    case .generalShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customReferralCardSnapshot {
                            ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }

            }
            
            
            Spacer()
            
            
            if isEitherShareButtonTapped {
                
                Button {
                    isShowingReferExperience.toggle()
                } label: {
                    BottomCapsuleButton(buttonText: "Done", color: Color("ReferPurple"))
                }
                
            } else {
                
                BottomCapsuleButton(buttonText: "Done", color: Color("Gray2"))
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        

        
    }
}




//Source: https://stackoverflow.com/questions/65660858/mfmessagecomposeviewcontroller-swiftui-buggy-behavior
//Another: https://www.twilio.com/blog/2018/07/sending-text-messages-from-your-ios-app-in-swift-using-mfmessagecomposeviewcontroller.html
//Another: https://stackoverflow.com/questions/39745761/sending-photo-using-mfmessagecomposeviewcontroller-is-disabled-in-ios10
//Notes on this one: https://developer.apple.com/documentation/messageui/mfmessagecomposeviewcontroller
struct MessageView: UIViewControllerRepresentable {
    
    var recipient: String
    
    let photo: UIImage
    
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
            vc.body = "Enter your text here"
        
        
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
        let controller = UIHostingController(rootView: self)
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





