//
//  JoinLoyaltyProgram4.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/13/22.
//

import SwiftUI

struct JoinLoyaltyProgram4: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var rewardsProgramViewModel = RewardsProgramViewModel()
    
    var screenWidth = UIScreen.main.bounds.width
    
    var company: Companies
    
    @Binding var isAddLoyaltyProgramCarouselActive: Bool
    
    var userID:String
    var email:String
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            GeometryReader { geometry in
                VStack {
                    
                    CardForLoyaltyProgram(cardColor: Color.white, textColor: Color.white, companyName: company.companyName, currentDiscountAmount: "$0", currentDiscountCode: "YOUR CODE", userFirstName: "", userLastName: "", userCurrentTier: "Member", discountCardDescription: "PERSONAL DISCOUNT CARD")
                    
                }.frame(width: geometry.size.width, height: geometry.size.width / 1.6)
            }.padding()
            .frame(width: screenWidth, height: screenWidth/1.6)
            
            //MARK: PROMPT (80)
            Text("Customize your membership card")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.top)
            
            
            Spacer()
            
            Button {
                
//                rewardsProgramViewModel.addLoyaltyProgram(companyID: company.companyID, companyName: company.companyName, currentPointsBalance: 0, email: email, lifetimePoints: 0, referralCode: "YOURCODE", status: "Member", userID: userID)
                
                
                isAddLoyaltyProgramCarouselActive = false
                //write to the database
            } label: {
                HStack {
                    Spacer()
                    Text("Finish")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                    Spacer()
                }.clipShape(Capsule())
                 .background(Capsule().foregroundColor(Color("ReferPurple")))
                 .padding(.horizontal)
                 .padding(.horizontal)
                 .padding(.bottom, 60)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
