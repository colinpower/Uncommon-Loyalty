//
//  AddLoyaltyProgramCarousel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct AddLoyaltyProgramCarousel: View {
    
    
    //State
    @State var indexOfCurrentAddLoyaltyProgramPage:Int = 0
    
    
    @Binding var isAddLoyaltyProgramCarouselActive:Bool
    
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    
    var totalHeaderHeight:CGFloat = UIScreen.main.bounds.height - 104
        
    var body: some View {
        
        VStack(spacing: 0) {
            
            //MARK: The VStack containing the entire ADD LOYALTY PROGRAM flow
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: HEADER (84 height)
                VStack(alignment: .center, spacing: 0) {
                    
                    //The top bar
                    HStack(alignment: .center) {
                        
                        Label {
                            Text("Step \(indexOfCurrentAddLoyaltyProgramPage+1)")
                                .font(.system(size: 23, weight: .semibold))
                                .foregroundColor(Color("Dark1"))
                        } icon: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(Color("ReferPurple"))
                        }
                        
                        Spacer()
                        
                        Button {
                            isAddLoyaltyProgramCarouselActive.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("Dark1"))
                                .frame(width: 24, height: 24)
                        }
                        
                    }.padding(.horizontal)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    .frame(maxWidth: screenWidth, maxHeight: 104)


                }
                .frame(width: screenWidth, height: 104)
                
                


                
                //MARK: CONTENT & HORIZONTAL SCROLLVIEW
                Color.clear.overlay(
                    HStack(spacing: 0) {
                        
                        AddLoyaltyProgramStep1(indexOfCurrentAddLoyaltyProgramPage: $indexOfCurrentAddLoyaltyProgramPage, screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                        AddLoyaltyProgramStep2(indexOfCurrentAddLoyaltyProgramPage: $indexOfCurrentAddLoyaltyProgramPage, screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                        AddLoyaltyProgramStep3(indexOfCurrentAddLoyaltyProgramPage: $indexOfCurrentAddLoyaltyProgramPage, screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                        
                    } , alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - 104)
                .offset(x: -1 * CGFloat(indexOfCurrentAddLoyaltyProgramPage) * screenWidth)
                
            }
            .ignoresSafeArea()
            .background(Color("Background"))
//            .onAppear {
//                self.rewardsProgramViewModel.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM")
//            }
            
        }
        
    }
}
