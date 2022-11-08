//
//  DiscountCardsHorizontalTabView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/3/22.
//

import SwiftUI


struct DiscountCardsHorizontalTabView: View {
    
    var activeDiscountCodes: [DiscountCodes]

    @Binding var activeLoyaltySheet: ActiveLoyaltySheet?
    
    
    var body: some View {
        
        TabView {
            
            ForEach(activeDiscountCodes) { discountcode in

                
                let currentLink = "https://" + discountcode.ids.domain + "/discount/" + discountcode.card.discountCode
                
                VStack(alignment: .center, spacing: 0) {
                    Button {
                        
                        self.activeLoyaltySheet = .viewCards
                        
                    } label: {
                        CardForLoyaltyProgram(cardColor: cardColorOptions[discountcode.card.color][0] as! Color, textColor: Color.white, companyImage: discountcode.card.companyName, companyName: discountcode.card.companyName, currentDiscountAmount: "$" + String(discountcode.reward.rewardAmount), currentDiscountCode: discountcode.card.discountCode, userFirstName: discountcode.owner.firstName, userLastName: discountcode.owner.lastName, userCurrentTier: "", discountCardDescription: "Default Card")
                            .frame(alignment: .center)
                            .padding(.top, 5)
                    }
                    
                    HStack {
                        Spacer()
                        Link(destination: URL(string: currentLink)!) {
                            HStack(alignment: .center, spacing: 6) {
                                Text("Shop using this discount code")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color("ThemeAction"))
                                    .padding(.vertical)
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color("ThemeAction"))
                                    .padding(.vertical)
                            }
                        }
                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color.white))
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.vertical)
                    Spacer()
                }

            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))

    }
    
}
