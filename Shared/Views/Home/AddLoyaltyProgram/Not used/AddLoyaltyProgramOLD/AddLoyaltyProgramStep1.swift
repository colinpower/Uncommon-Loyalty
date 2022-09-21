////
////  AddLoyaltyProgramPage1.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 9/6/22.
////
//
//import SwiftUI
//
//struct AddLoyaltyProgramStep1: View {
//    
//    
//    @Binding var indexOfCurrentAddLoyaltyProgramPage: Int
//    var screenWidth: CGFloat
//    
//    var totalHeaderHeight: CGFloat
//    
//    var body: some View {
//        VStack {
//            
//            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
//            GeometryReader { geometry in
//                VStack {
//                    
//                    Image("BlueGoldenRatio")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
//                    
//                }.frame(width: geometry.size.width, height: geometry.size.width / 1.6)
//            }.padding()
//            .frame(width: screenWidth, height: screenWidth/1.6)
//                
//            
//            
//            
//            
//            
//            //MARK: PROMPT (80)
//            Text("Hi, we're Athleisure LA!")
//                .font(.system(size: 24, weight: .bold))
//                .multilineTextAlignment(.leading)
//                .foregroundColor(Color("Dark1"))
//                .padding(.top, 30)
//                .padding(.horizontal)
//                .frame(height: 54, alignment: .leading)
//            
//            
//            
//            //MARK: BUTTONS (48)
//            HStack(alignment: .center) {
//                
//                Spacer()
//                
//                //MARK: OK / PREVIEW BUTTON
//                Button {
//                    
//                    //zoom to the next question
//                    withAnimation(.linear(duration: 0.15)) {
//                        indexOfCurrentAddLoyaltyProgramPage += 1
//                    }
//                } label: {
//                    HStack (alignment: .center, spacing: 2) {
//                        Text("OK")
//                            .font(.system(size: 20, weight: .semibold))
//                            .foregroundColor(.white)
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 18, weight: .semibold))
//                            .foregroundColor(.white)
//                    }
//                    .frame(width: 96, height: 48)
//                    .background(RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(Color("ReferPurple")))
//                }
//                
//            }
//            .padding(.horizontal)
//            .frame(height: 48, alignment: .center)
//            
//            Spacer()
//            
//            
//            
//            
//        }
//        .frame(width: screenWidth, height: totalHeaderHeight)
//    }
//}
