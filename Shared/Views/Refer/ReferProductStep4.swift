//
//  ReferProductStep4.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
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



struct ReferProductStep4: View {
    
    
    @State private var customReferralCardSnapshot: UIImage? = nil
    @State var activeSheetiMessage: ActiveSheetiMessage? = nil
    @State var activeSheetShare: ActiveSheetShare? = nil
    
    @State private var isShowingMessages = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    
    
    //Environment
    
    //ViewModels
    
    //State
    @State var nameForRecipientEnteredManually:String = ""
    
    //var customReferralCard:View
    
    //Binding
    @Binding var userSelectedColor:Color
    @Binding var selectedContact:[String]
    @Binding var indexOfCurrentReferPage:Int
    
    @Binding var userAcceptedCode:String
    
    @Binding var isShowingReferExperience:Bool
    
    
    
    //Required variables
    
    var item: Items
    var promptForStep4:String
    var screenWidth:CGFloat
    var totalHeaderHeight:CGFloat
    
    @State var wasPreviewButtonTapped:Bool = false
    
    
    @Binding var imageString:String
    
    
    var customReferralCardForPreview: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Image(imageString)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)
                    VStack {
                        Text(selectedContact[1])
                        Text(selectedContact[3])
                        Text(userAcceptedCode)
                    }.frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                }

            }
            .frame(maxWidth: screenWidth, maxHeight: UIScreen.main.bounds.width / 1.6)
            .padding(.horizontal)
            Spacer()
        }.frame(width: screenWidth, height: UIScreen.main.bounds.width / 1.6)
           
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                //MARK: PROMPT (80)
                Text(promptForStep4 + " to " + selectedContact[1] + "!")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .padding(.top, 30)
                    .padding(.horizontal)
                    .frame(height: 54, alignment: .leading)
        
        
            
                Button(action: {
                    //isShowingMessages = true
                    customReferralCardSnapshot = customReferralCardForPreview.snapshot()
                    self.activeSheetiMessage = .iMessageShareSheet
                    
                }) {
                    Text("Send message")
                }.sheet(item: $activeSheetiMessage) { [customReferralCardSnapshot] sheet in
                    
                    switch sheet {
                    case .iMessageShareSheet:
                        
                        //confirm that you've been able to convert the card into an image
                        if let unwrappedImage = customReferralCardSnapshot {
                            
                            MessageView(recipient: "+15555555555", photo: unwrappedImage)
                            
                            //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                               //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                        }
                    }
                }
                
                
                Button {
                    
                    customReferralCardSnapshot = customReferralCardForPreview.snapshot()
                    self.activeSheetShare = .generalShareSheet
                    
                } label: {
                    Text("SEND TO YOUR FRIENDS")
                }
                
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
            
        Spacer()
            
            
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .frame(width: screenWidth, height: UIScreen.main.bounds.height-totalHeaderHeight)
        .onAppear {
            print("We're on page \(indexOfCurrentReferPage)")
            //print(reviewQuestionForThisPage)
        
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




//MARK: BUTTON TO SEND VIA IMESSAGE OR MORE CHANNELS
//Check if there is a phone number available.. if so, then try to send via imessage
//            HStack {
//
//                Button {
//
//                    //trigger imessage
//
//                } label: {
//                    HStack (alignment: .center, spacing: 6) {
//
//                        Text("iMessage Autofill")
//                            .font(.system(size: 18, weight: .medium))
//                            .foregroundColor(.white)
//
//                        Image(systemName: "arrow.right")
//                            .font(.system(size: 18, weight: .medium))
//                            .foregroundColor(Color.white)
//
//                    }
//                    .padding(.vertical, 20)
//                    .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
//                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.green))
//                }
//
//                Spacer()
//
//                Button {
//
//                    //more share options
//
//                } label: {
//                    VStack(alignment: .center, spacing: 3) {
//                        Image(systemName: "square.and.arrow.up")
//                            .font(.system(size: 27, weight: .regular))
//                            .foregroundColor(Color.blue)
//                        Text("More options")
//                            .font(.system(size: 14, weight: .regular))
//                            .foregroundColor(Color.blue)
//
//                    }.padding(.vertical, 2)
//                    .frame(width: UIScreen.main.bounds.width / 3 - CGFloat(20), height: 60)
//                }
//
//            }
//            .padding(.horizontal)
//            .padding(.top, 25)
//            .padding(.bottom, 25)
//            .frame(width: UIScreen.main.bounds.width, height: 110)
//
//            Spacer()
//
//            HStack {
//                Spacer()
//                Button {
//
//                    isShowingReferExperience.toggle()
//
//                } label: {
//                    Text("Done")
//                        .font(.system(size: 18, weight: .medium))
//                        .foregroundColor(.white)
//                        .padding(.vertical, 20)
//                        .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
//                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.green))
//                }
//                Spacer()
//            }
//
//            Spacer()
//
