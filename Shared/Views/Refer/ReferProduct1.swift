//
//  ReferProduct1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/20/22.
//

import SwiftUI

struct ReferProduct1: View {
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
                CardForLoyaltyProgram(cardColor: Color.white, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "YOUR-CODE", userFirstName: "First", userLastName: "Last", userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                    .frame(alignment: .center)
                    .padding(.vertical)
                    .padding(.top)
                
                //MARK: PROMPT (80)
                Text("This is your blank referral card")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                
                Text("You can customize this card, then send it to your friend. Let's make it special!")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                    .padding(.bottom)
                
                Label {
                    Text("30 seconds")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink {
                    ReferProduct2(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject)
                } label: {
                    BottomCapsuleButton(buttonText: "Next", color: Color("ReferPurple"))
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct ReferProduct1_Previews: PreviewProvider {
//    static var previews: some View {
//        ReferProduct1()
//    }
//}
