//
//  ViewAllReferrals.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/22/22.
//

import SwiftUI

struct ViewAllReferrals: View {
    var body: some View {
        
        ScrollView(.vertical) {
            
            VStack(alignment: .center, spacing: 0) {
                
                ReferralSent(recipient: "Catherine", amount: "$20", stateOfReferral: "Sent")
                    .padding(.vertical)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                    .padding()
                    .padding(.horizontal, 8)
                
                ReferralSent(recipient: "James", amount: "$10", stateOfReferral: "Sent")
                    .padding(.vertical)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                    .padding()
                    .padding(.horizontal, 8)
                
                ReferralCompleted(recipient: "Kath", amount: "$5", stateOfReferral: "Sent")
                    .padding(.vertical)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                    .padding()
                    .padding(.horizontal, 8)
                
                
                ReferralUsed(recipient: "Michael", amount: "$15", stateOfReferral: "Used")
                    .padding(.vertical)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                    .padding()
                    .padding(.horizontal, 8)
                
                
                ReferralExpired(recipient: "Katie", amount: "$50", stateOfReferral: "Sent")
                    .padding(.vertical)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: 5, y: 4))
                    .padding()
                    .padding(.horizontal, 8)
                
                
                
                
                
                
                
            }
        }

    }
}



struct ReferralSent: View {
    
    var recipient: String
    var amount: String
    var stateOfReferral: String
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                Image("redshorts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.vertical)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Discount sent to " + recipient)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.top, 12)
                    
                    Text(amount + " towards first purchase")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Gray2"))

                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("Gray2"))
                    .padding(.trailing, 8)
                
            }.frame(height: 64)
            
            Divider().padding(.vertical, 2)
            
            VStack(alignment: .center) {
                //progress bar
                ZStack(alignment: .leading) {
                    
                    Capsule().foregroundColor(Color("Gray3"))
                        .frame(width: UIScreen.main.bounds.width - 80, height: 8)
                    
                    Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                        .frame(width: 60, height: 8)
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                HStack(alignment: .center, spacing: 0) {
                    Text("Sent")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                    Spacer()
                    
                    Text("Used")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(Color("Gray2"))
                    
                    Spacer()
                    
                    Text("Not returned")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(Color("Gray2"))
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.bottom, 12)
                
            }.frame(width: UIScreen.main.bounds.width - 80)
            
        }.frame(height: 118)
        
    }
}

struct ReferralUsed: View {
    
    var recipient: String
    var amount: String
    var stateOfReferral: String
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                Image("redshorts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.vertical)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Discount sent to " + recipient)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.top, 12)
                    
                    Text(amount + " towards first purchase")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Gray2"))

                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("Gray2"))
                    .padding(.trailing, 8)
                
            }.frame(height: 64)
            
            Divider().padding(.vertical, 2)
            
            VStack(alignment: .center) {
                //progress bar
                ZStack(alignment: .leading) {
                    
                    Capsule().foregroundColor(Color("Gray3"))
                        .frame(width: UIScreen.main.bounds.width - 80, height: 8)
                    
                    Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 8)
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                HStack(alignment: .center, spacing: 0) {
                    Text("Sent")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                    Spacer()
                    
                    Text("Used")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                    Spacer()
                    
                    Text("Not returned")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(Color("Gray2"))
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.bottom, 12)
                
            }.frame(width: UIScreen.main.bounds.width - 80)
            
        }.frame(height: 118)
        
    }
}

struct ReferralCompleted: View {
    
    var recipient: String
    var amount: String
    var stateOfReferral: String
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                Image("redshorts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.vertical)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Discount sent to " + recipient)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.top, 12)
                    
                    Text(amount + " towards first purchase")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Gray2"))

                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("Gray2"))
                    .padding(.trailing, 8)
                
            }.frame(height: 64)
            
            Divider().padding(.vertical, 2)
            
            VStack(alignment: .center) {
                //progress bar
                
                Capsule().foregroundColor(Color("ReviewComplementaryGreen"))
                    .frame(width: UIScreen.main.bounds.width - 80, height: 8)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Spacer()
                    
                    Spacer()
                    
                    Text("Complete")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("ReviewComplementaryGreen"))
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.bottom, 12)
                
            }.frame(width: UIScreen.main.bounds.width - 80)
            
        }.frame(height: 118)
        
    }
}

struct ReferralExpired: View {
    
    var recipient: String
    var amount: String
    var stateOfReferral: String
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                Image("redshorts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.vertical)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Discount sent to " + recipient)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.top, 12)
                    
                    Text(amount + " towards first purchase")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("Gray2"))

                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("Gray2"))
                    .padding(.trailing, 8)
                
            }.frame(height: 64)
            
            Divider().padding(.vertical, 2)
            
            VStack(alignment: .center) {
                //progress bar
                
                Capsule().foregroundColor(Color.red)
                    .frame(width: UIScreen.main.bounds.width - 80, height: 8)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Spacer()
                    
                    Spacer()
                    
                    Text("Expired")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.red)
                    
                }.frame(width: UIScreen.main.bounds.width - 80)
                    .padding(.bottom, 12)
                
            }.frame(width: UIScreen.main.bounds.width - 80)
            
        }.frame(height: 118)
        
    }
}
