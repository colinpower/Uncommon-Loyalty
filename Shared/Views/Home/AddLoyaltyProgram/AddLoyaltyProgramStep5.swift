//
//  AddLoyaltyProgramStep5.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct AddLoyaltyProgramStep5: View {
    @Binding var indexOfCurrentAddLoyaltyProgramPage: Int
    var screenWidth: CGFloat
    
    var totalHeaderHeight: CGFloat
    
    @Binding var isAddLoyaltyProgramCarouselActive:Bool
    
    
    var body: some View {
        VStack {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            GeometryReader { geometry in
                
                ZStack(alignment: .center) {
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.blue)
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            Image("Athleisure LA")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.trailing, 6)
                            Text("Athleisure LA")
                                .font(.system(size: 24))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                            Spacer()
                            Text("20%")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .frame(height: 40)
                        .padding([.top, .horizontal])
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("XXXXXXXX")
                                .font(.system(size: 60, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                        }.frame(width: geometry.size.width, height: 60, alignment: .center)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("colin".uppercased())
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                                
                                Text("Member".uppercased() + " since 2022")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(.gray)
                            }.frame(height: 38)
                            
                            Spacer()
                            
                            Text("Personal".uppercased())
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .frame(height: 38)
                        .padding([.bottom, .horizontal])

                    }
                    
                    
                }
              
                .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
            }.padding()
            .frame(width: screenWidth, height: screenWidth/1.6)
            
            
            
            //MARK: PROMPT (80)
            Text("Hi, we're Athleisure LA!")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 30)
                .padding(.horizontal)
                .frame(height: 54, alignment: .leading)
            
            
            
            //MARK: BUTTONS (48)
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                
                Button {

                    //zoom to the prior question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentAddLoyaltyProgramPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 48)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("ReferPurple")))
                }
                
                Spacer()
                
                //MARK: FINISH BUTTON
                Button {
                    
                    //zoom to the next question
                    isAddLoyaltyProgramCarouselActive = false
                    
                } label: {
                    HStack (alignment: .center, spacing: 2) {
                        Text("Finish")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 180, height: 48)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("ReferPurple")))
                }
                
                
            }
            .padding(.horizontal)
            .frame(height: 48, alignment: .center)

            
            
            Spacer()
        
            
        }
        .frame(width: screenWidth, height: totalHeaderHeight)
        
    }
}
