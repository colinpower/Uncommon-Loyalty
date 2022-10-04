//
//  TabViewForReferralsYouveReceived.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/8/22.
//

import SwiftUI

struct TabViewForReferralsYouveReceived: View {
    
    var discountCodes: [DiscountCodes]
    
//    @Binding var isReferralCardSelected: Bool
//    
//    @Binding var referralCardSelected:DiscountCodes?
//    
//    var home_Animation: Namespace.ID
    
    var body: some View {
        
        if discountCodes.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .center, spacing: 0) {
                TabView {
                    ForEach(discountCodes) { discountCode in
                        VStack(alignment: .center, spacing:0) {
                            HStack(spacing:0) {
                                Text("Active".uppercased())
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.green)
                                    .kerning(1.1)
                                Spacer()
                            }.padding(.horizontal)
                                .padding(.vertical, 10)
                            
                            ReferralYouveReceived(discountCode: discountCode)
                        //isReferralCardSelected: $isReferralCardSelected, referralCardSelected: $referralCardSelected, home_Animation: home_Animation)
                        }
                    }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6 + 124)
            .background(.white)
        }
    }
    
}

struct ReferralYouveReceived: View {
    
//    @Binding var isReferralCardSelected:Bool
//
//    @Binding var referralCardSelected:DiscountCodes?
    
    var discountCode:DiscountCodes
    
    var body: some View {
        
        //MARK: NEW SECTION CARD
        VStack(alignment: .center, spacing: 0) {
                
            //MARK: NEW SECTION CONTENT
            VStack (alignment: .leading, spacing: 0) {
                //Header for card
                Text("From Catherine Lombardo")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                NavigationLink {
                    Text(discountCode.ids.graphQLID)
                } label: {
                    CardForLoyaltyProgram(cardColor: Color.blue, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Silver", discountCardDescription: "Personal Card")
                }

     
            }.padding(.bottom, 40)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6 + 66)
        }
    }
}

