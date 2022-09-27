//
//  ReferProductPage3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//
//import Foundation
import SwiftUI
import UIKit
import MessageUI
//import MobileCoreServices


//TRY COMBINING THESE ENUMS
//This has a way you could do it I think
//https://developer.apple.com/documentation/swiftui/view/sheet(item:ondismiss:content:)

//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheetENUM: String, Identifiable { // <--- note that it's now Identifiable
    case generalShareSheet
    var id: String {
        return self.rawValue
    }
}

//MARK: HACK necessary to pass the correct image to the share sheet
enum ActiveSheet2ENUM: String, Identifiable { // <--- note that it's now Identifiable
    case iMessageShareSheet
    var id: String {
        return self.rawValue
    }
}



struct ReferProductPage3: View {
    
    //State
    @State private var customCardViewSnapshot: UIImage? = nil
    @State var activeSheet: ActiveSheetENUM? = nil
    @State var activeSheet2: ActiveSheet2ENUM? = nil
    
    //Binding
    @Binding var userSuggestedCode:String
    
    //Required variables
    var cardWidth:CGFloat
    
    /// The delegate required by `MFMessageComposeViewController`
    //private let messageComposeDelegate = MessageDelegate()
    
    @State private var isShowingMessages = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    

    //MARK: USER-CREATED CARD ON THE TOP
    var customCardView: some View {
    
        HStack {
            
            Spacer()
            
            ZStack(alignment: .topLeading) {
                
                Rectangle().foregroundColor(.green)
                    .frame(width: cardWidth, height: cardWidth * 5 / 8)
                
                VStack {
                    
                    HStack {
                        Text("Athleisure LA")
                        Spacer()
                        Text("20% Discount")
                    }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text(userSuggestedCode)
                            .font(.system(size: 60, weight: .semibold))
                        Spacer()
                    }.frame(height: cardWidth * 5 / 16) //i.e. 1/2 of the card in terms of height)
                    
                    HStack {
                        Text("colinjpower1@gmail.com")
                        Spacer()
                        Text("Expires in 30 days (Oct 3)")
                    }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                    
                }.frame(width: cardWidth, height: cardWidth * 5 / 8)
            }
            Spacer()
        }.padding(.bottom, 40)
        
    }
    
    var body: some View {
        VStack {
        
            VStack {
                           
                customCardView
                
                
                Button(action: {
                    //isShowingMessages = true
                    customCardViewSnapshot = customCardView.snapshot()
                    self.activeSheet2 = .iMessageShareSheet
                    
                }) {
                    Text("Send message")
                }.sheet(item: $activeSheet2) { [customCardViewSnapshot] sheet in
                    
                    switch sheet {
                    case .iMessageShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customCardViewSnapshot {
                            
                            MessageView(recipient: "+15555555555", photo: unwrappedImage, messageToRecipient: "asldkfasldf")
                            
                            //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }
                
                
                
//                .sheet(isPresented: $isShowingMessages) {
//                    MessageView(recipient: "+15555555555")
//                        .ignoresSafeArea()
//                }
                
                

                
                
                
                
                
                
                Button {
                    
                    customCardViewSnapshot = customCardView.snapshot()
                    self.activeSheet = .generalShareSheet
                    
                } label: {
                    Text("SEND TO YOUR FRIENDS")
                }
                
            }
            .sheet(item: $activeSheet) { [customCardViewSnapshot] sheet2 in
                
                switch sheet2 {
                case .generalShareSheet:
                    
                    //confirm that you've been able to convert the card into an image
                    if let unwrappedImage = customCardViewSnapshot {
                        ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                           //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                    }
                }
            }
            
            Spacer()
        }
    }
}

////Source: https://stackoverflow.com/questions/65660858/mfmessagecomposeviewcontroller-swiftui-buggy-behavior
////Another: https://www.twilio.com/blog/2018/07/sending-text-messages-from-your-ios-app-in-swift-using-mfmessagecomposeviewcontroller.html
////Another: https://stackoverflow.com/questions/39745761/sending-photo-using-mfmessagecomposeviewcontroller-is-disabled-in-ios10
////Notes on this one: https://developer.apple.com/documentation/messageui/mfmessagecomposeviewcontroller
//struct MessageView: UIViewControllerRepresentable {
//
//    var recipient: String
//
//    let photo: UIImage
//
//    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
//        var completion: () -> Void
//        init(completion: @escaping ()->Void) {
//            self.completion = completion
//        }
//
//        // delegate method
//        func messageComposeViewController(_ controller: MFMessageComposeViewController,
//                                   didFinishWith result: MessageComposeResult) {
//            controller.dismiss(animated: true, completion: nil)
//            completion()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator() {} // not using completion handler
//    }
//
//    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
//        let vc = MFMessageComposeViewController()
//
//        //If you can send text, add the text
//        if MFMessageComposeViewController.canSendText() {
//
//            vc.recipients = [recipient]
//            vc.body = "Enter your text here"
//
//
//            //If you can send attachments, then add the attachment
//            if MFMessageComposeViewController.canSendAttachments() {
//
//                let dataImage = photo.pngData()
//
//                //If there's an issue with the image, just skip it and show the VC
//                guard dataImage != nil else {
//                    vc.messageComposeDelegate = context.coordinator
//                    return vc
//                }
//
//                //Add the attachment
//                vc.addAttachmentData(dataImage!, typeIdentifier: "img/png", filename: "ImageData.png")
//            }
//        }
//
//        //return the VC
//        vc.messageComposeDelegate = context.coordinator
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
//
//    typealias UIViewControllerType = MFMessageComposeViewController
//}







//extension View {
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//
//        let targetSize = controller.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
//}









////MARK: creating a VC to show the share sheet
//
////Notes on this one: https://stackoverflow.com/questions/71712428/swiftui-how-to-snapshot-a-view-then-share
//struct ReferralShareSheet: UIViewControllerRepresentable {
//    //@Binding var isShareSheetActive: Bool
//
//    //let photo: UIImage
//
//    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
//
//    let activityItems: [Any]
//    let applicationActivities: [UIActivity]? = nil
//    let excludedActivityTypes: [UIActivity.ActivityType]? = nil     //[.postToFacebook]
//    let callback: Callback? = nil
//
//    func makeUIViewController(context: Context) -> UIViewController {
//
//        let controller = UIActivityViewController(
//            activityItems: activityItems,
//            applicationActivities: applicationActivities)
//
//        controller.excludedActivityTypes = excludedActivityTypes
//        controller.completionWithItemsHandler = callback
//
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {  }
//
//}




//MARK: UNUSED BUT USEFUL FUNCTIONS
//save card to photos
//Button("Save to image") {
//    let image = customCardView.snapshot()
//
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//}
