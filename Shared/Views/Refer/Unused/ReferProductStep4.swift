//
//  ReferProductStep4.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI
import UIKit
import MessageUI


//
////MARK: HACK necessary to pass the correct image to the share sheet
//enum ActiveSheetiMessage: String, Identifiable { // <--- note that it's now Identifiable
//    case iMessageShareSheet
//    var id: String {
//        return self.rawValue
//    }
//}
//
////MARK: HACK necessary to pass the correct image to the share sheet
//enum ActiveSheetShare: String, Identifiable { // <--- note that it's now Identifiable
//    case generalShareSheet
//    var id: String {
//        return self.rawValue
//    }
//}



struct ReferProductStep4: View {
    
    
    @State private var customReferralCardSnapshot: UIImage? = nil
    @State var activeSheetiMessage: ActiveSheetiMessage? = nil
    @State var activeSheetShare: ActiveSheetShare? = nil
    
    @State private var isShowingMessages = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    @State var isEitherShareButtonTapped:Bool = false
    
    
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
        
        
        VStack(alignment: .center) {
            Spacer()
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                        .foregroundColor(userSelectedColor)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)
                        
//                    userSelectedColor.frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
//                        .clipped()
//                        .cornerRadius(8)
                    VStack(spacing:0) {
                        HStack (alignment: .center) {
                        
                        Image("Athleisure LA")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .cornerRadius(8)
                        
                        Text("ATHLEISURE LA")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("20%")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                    }.padding(.top, 15)
                
                    Spacer()
                
                    HStack {
                        Spacer()
                        Text(userAcceptedCode.uppercased())
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.frame(width: screenWidth * 2 / 3, height: 40)
                
                    Spacer()
                
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(selectedContact[1].uppercased() + " " + selectedContact[2].uppercased())
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            Text(selectedContact[3])
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.bottom,5)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                }
                
            }
            .frame(maxWidth: screenWidth, maxHeight: UIScreen.main.bounds.width / 1.6)
            
            .padding(.horizontal)
            
            Spacer()
        }.frame(width: screenWidth, height: UIScreen.main.bounds.width / 1.6)
        
        
        
        
        
//        VStack(alignment: .center, spacing: 0) {
//            Spacer()
//            GeometryReader { geometry in
//                ZStack(alignment: .center) {
//                    Image(imageString)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
//                        .clipped()
//                        .cornerRadius(8)
//                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)
//                    VStack {
//                        Text(selectedContact[1])
//                        Text(selectedContact[3])
//                        Text(userAcceptedCode)
//                    }.frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
//                }
//
//            }
//            .frame(maxWidth: screenWidth, maxHeight: UIScreen.main.bounds.width / 1.6)
//            .padding(.horizontal)
//            Spacer()
//        }.frame(width: screenWidth, height: UIScreen.main.bounds.width / 1.6)
//
//
        
        
        
        
        
        
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
                //MARK: PROMPT (80)
                Text(promptForStep4 + " to " + selectedContact[1] + "!")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .padding(.top, 30)
                    .padding(.horizontal)
                    .frame(height: 54, alignment: .leading)
        
                //MARK: BUTTON TO SEND VIA IMESSAGE OR MORE CHANNELS
                //Check if there is a phone number available.. if so, then try to send via imessage
                HStack {
    
                    
                    //MARK: IMESSAGE BUTTON
                    Button(action: {
                        
                        //isShowingMessages = true
                        customReferralCardSnapshot = customReferralCardForPreview.snapshot()
                        self.activeSheetiMessage = .iMessageShareSheet
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isEitherShareButtonTapped = true
                        }
                        
                    }) {
                        HStack (alignment: .center, spacing: 6) {
    
                            Text("Send via iMessage")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
    
                            Image(systemName: "arrow.up.forward")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.white)
    
                        }
                        .padding(.vertical, 20)
                        .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.green))
                        
                    }.sheet(item: $activeSheetiMessage) { [customReferralCardSnapshot] sheet in
                        
                        switch sheet {
                        case .iMessageShareSheet:
                            
                            //confirm that you've been able to convert the card into an image
                            if let unwrappedImage = customReferralCardSnapshot {
                                
                                MessageView(recipient: selectedContact[3], photo: unwrappedImage, messageToRecipient: "alsdkfjsald")
                                
                                //ReferralShareSheet(activityItems: ["Hey, I created a discount code for you!", unwrappedImage])
                                                   //activityItems: ["Hey, I created a discount code for you!", customCardViewSnapshot as Any ]
                            }
                        }
                    }
    
                    Spacer()
    
                    //MARK: SHARE BUTTON
                    Button {
                        
                        customReferralCardSnapshot = customReferralCardForPreview.snapshot()
                        self.activeSheetShare = .generalShareSheet
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isEitherShareButtonTapped = true
                        }
                        
                    } label: {
                        VStack(alignment: .center, spacing: 3) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 27, weight: .regular))
                                .foregroundColor(Color.blue)
                            Text("More options")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color.blue)
    
                        }.padding(.vertical, 2)
                        .frame(width: UIScreen.main.bounds.width / 3 - CGFloat(20), height: 60)
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
                .padding(.horizontal)
                .padding(.top, 25)
                .padding(.bottom, 25)
                .frame(width: UIScreen.main.bounds.width, height: 110)
    
                Spacer()
    
                Button {

                    isShowingReferExperience.toggle()

                } label: {
                    HStack {
                        Spacer()
                        Text("Done")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(isEitherShareButtonTapped ? Color.green : .gray))
                        Spacer()
                    }.padding(.horizontal)
                }.disabled(!isEitherShareButtonTapped)
                .padding(.bottom, 60)

            
            
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






