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
    
    @State private var copyText:String = "Copy"
    @State private var copyColor:Color = Color.blue
    
    
    
    var body: some View {
        VStack (alignment: .leading) {
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
                    }
                
            }
            .padding(.bottom, 24)
//            Text("More ways to share")
//                .font(.title3)
//                .fontWeight(.medium)
//                .padding(.bottom, 12)
//            HStack {
//                VStack {
//                    Image(systemName: "message.circle.fill")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 60, height: 60, alignment: .center)
//                        .clipped()
//                        .cornerRadius(10)
//                        .foregroundColor(.green)
//                    Text("iMessage")
//                }
//                .frame(width: 80, height: 80, alignment: .center)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 5)
//                    .stroke(.black.opacity(0.3)))
//                Spacer()
//                VStack {
//                    Image(systemName: "envelope.circle.fill")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 60, height: 60, alignment: .center)
//                        .clipped()
//                        .cornerRadius(10)
//                        .foregroundColor(.cyan)
//                    Text("Email")
//                }.frame(width: 80, height: 80, alignment: .center)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 5)
//                    .stroke(.black.opacity(0.3)))
//                Spacer()
//                VStack {
//                    Image(systemName: "square.and.arrow.up.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 60, height: 60, alignment: .center)
//                        .clipped()
//                        .cornerRadius(10)
//                        .foregroundColor(.indigo)
//                    Text("Share")
//                }.frame(width: 80, height: 80, alignment: .center)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 5)
//                    .stroke(.black.opacity(0.3)))
//            }
//            .padding(.bottom, 24)

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
        .navigationBarTitle("Refer", displayMode: .inline)
    }
}

struct ReferAFriend_Previews: PreviewProvider {
    static var previews: some View {
        ReferAFriend(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA")
    }
}
