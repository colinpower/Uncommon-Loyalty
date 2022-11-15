//
//  ReferProduct0.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 11/15/22.
//

import SwiftUI

struct ReferProduct0: View {
    
    @Binding var activeReviewOrReferSheet: ActiveReviewOrReferSheet?
    
    var itemObject: Items
    var productRewards: CompanyProduct
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
                DiscountCardForReferral(designSelection: [Color.white, Color.white, "engraved", "White"], companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: "CUSTOMIZE-ME", recipientFirstName: "Your Friend's", recipientLastName: "Name")
                    .frame(alignment: .center)
                    .padding(.vertical)
                    .padding(.top)
                
                //MARK: PROMPT (80)
                Text("Customize your friend's $20 gift!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .frame(alignment: .leading)
                    .padding()
                
                Text("Offer for your friend: $20!!")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("Dark2"))
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom).padding(.bottom)
                
                
                
                Label {
                    Text("Takes 30 seconds")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "clock")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink {
                    ReferProduct1(activeReviewOrReferSheet: $activeReviewOrReferSheet, itemObject: itemObject)
                } label: {
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
