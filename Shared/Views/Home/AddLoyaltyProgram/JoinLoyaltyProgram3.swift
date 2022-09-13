//
//  JoinLoyaltyProgram3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/13/22.
//

import SwiftUI

struct JoinLoyaltyProgram3: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
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
            Text("Your membership card")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.top)
            
            Text("This is your \(company.companyName) membership card.\n\nPersonalize your card with a custom discount code, only usable by you!\n\nWhen you redeem rewards for discounts, you can spend these discounts using your custom discount code. Just enter the code at checkout.")
                .font(.system(size: 18, weight: .medium))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding()
            
            Spacer()
            
            NavigationLink {
                JoinLoyaltyProgram4(company: company, isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive, userID: userID, email: email)
            } label: {
                HStack {
                    Spacer()
                    Text("Customize")
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
