//
//  ReferAFriend.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/30/22.
//

import SwiftUI

struct ReferAFriend: View {
    
    var companyID: String
    var companyName: String
    var referralCode: String = "COLIN-REFERRAL-05"
    
    @Binding var isReferCompanyActive: Bool
    
    @State private var copyText:String = "Copy"
    @State private var copyColor:Color = Color.blue
    
    
    
    var body: some View {
        VStack (alignment: .leading) {
            
            SheetHeader(title: "Refer A Friend", isActive: $isReferCompanyActive)
                .padding(.bottom)
                .padding(.bottom)
            
            
            HStack {
                Image("ReferralGoldGift")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 89, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.trailing, 12)
                Text("2000 points for you, $10 discount for a friend")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            .padding(.bottom, 8)
            Text("You'll both get rewarded when your friend spends $50 using your discount code at " + companyName + ".")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.6))
                .padding(.bottom, 36)
            Text("Share your code")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.bottom, 12)
            HStack {
                Text(referralCode)
                    .font(.body)
                    .frame(maxWidth: 250)
                    .lineLimit(1)
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color.black.opacity(0.3)))
                    .padding(.trailing, 12)
                Spacer()
                Text(copyText)
                    .font(.body)
                    .fontWeight(.medium)
                    .frame(minWidth: 60, maxWidth: 60)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                        .fill(copyColor))
                    .onTapGesture(count: 1) {
                        copyText = "Copied"
                        copyColor = Color.green
                        UIPasteboard.general.string = referralCode
                    }
                
            }

            Spacer()
        }.padding(.horizontal)
        .ignoresSafeArea()
        
        
    }
}

struct ReferAFriend_Previews: PreviewProvider {
    static var previews: some View {
        ReferAFriend(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", isReferCompanyActive: .constant(true))
    }
}
