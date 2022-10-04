//
//  DiscountCardDetailView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/3/22.
//

import SwiftUI

struct DiscountCardsDetailView: View {
    
    var activeDiscountCodes: [DiscountCodes]
    
    @State var copyCodeText:String = "Copy code"
    
    var body: some View {
                
        TabView {
            
            ForEach(activeDiscountCodes) { discountcode in
                
                VStack(alignment: .center, spacing: 0) {
                    CardForLoyaltyProgram(cardColor: cardColorOptions[discountcode.card.color][0] as! Color, textColor: Color.white, companyImage: discountcode.card.companyName, companyName: discountcode.card.companyName, currentDiscountAmount: "$" + String(discountcode.reward.rewardAmount), currentDiscountCode: discountcode.card.discountCode, userFirstName: discountcode.owner.firstName, userLastName: discountcode.owner.lastName, userCurrentTier: "", discountCardDescription: "Default Card")
                        .frame(alignment: .center)
                        .padding(.vertical)
                        .padding(.bottom)
                    
                    let currentLink = "https://" + discountcode.ids.domain + "/discount/" + discountcode.card.discountCode
                    
                    HStack(spacing: 12) {
                        Button {
                            UIPasteboard.general.string = discountcode.card.discountCode
                            
                            copyCodeText = "Copied"
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                
                                copyCodeText = "Copy code"
                                
                            }
                            
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text(copyCodeText).font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                Spacer()
                            }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color.white))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0)
                            .padding(.vertical)
                        }
                        
                        HStack {
                            Spacer()
                            Link("Shop with code", destination: URL(string: currentLink)!)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.vertical)
                            Spacer()
                        }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color.white))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0)
                            .padding(.vertical)
                        
                    }.padding(.horizontal)
                    
                    Spacer()
                }

            }.padding(.vertical, 5)
            .padding(.bottom, 40)
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))

    }
}
