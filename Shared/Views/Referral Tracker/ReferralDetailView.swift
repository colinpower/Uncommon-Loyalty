//
//  ReferralDetailView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import SwiftUI

struct ReferralDetailView: View {
    
    var referral: Referrals
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //DESIGN SELECTION IS A WEIRD [[ANY]] ARRAY
            
            DiscountCardForReferral(designSelection: [Color.white, Color.white, "engraved", "White"], companyImage: "Athleisure LA", companyName: String(referral.companyID.prefix(15)), discountAmount: "$" + String(referral.referralDiscountAmount), discountCode: String(referral.referralCode.prefix(10)), recipientFirstName: String(referral.userSendingReferralEmail.prefix(10)), recipientLastName: String(referral.associatedOrderID.prefix(10)))
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
            
            ReferralTrackingCardProgressBar(status: referral.status)
                .padding(.top, 16)
                .frame(height: 66)
                .clipShape(RoundedRectangle(cornerRadius: 11))
                .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                .padding(.horizontal)
                .padding(.vertical, 8)
                .padding(.bottom)
                .padding(.bottom)
            
            
            Text("Send again via iMessage")
            
            Spacer()
            
        }
        
        
        
    }
}
