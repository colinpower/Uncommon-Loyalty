//
//  CreateDiscountScreen.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 2/7/22.
//
//note.. need to move NavigationView into the Home view instead of in the tabview.. this way the popup screen won't revert back to the home view
//https://developer.apple.com/forums/thread/695596



import SwiftUI

struct CreateDiscountScreen: View {
    
    
    
    
    @StateObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @StateObject var discountCodesViewModel = DiscountCodesViewModel()
    
    @State var rewardsUsed: Double = 0
    
    @Binding var showSheet:Bool
    
    var email:String
    var userID:String
    
    var companyID: String
    var companyName: String
    var currentPointsBalance: Int
    
    @State var didUserPressRedeemButton:Bool = false
    
    
    var body: some View {
        
        if didUserPressRedeemButton {
            //show the view to pick a card
            VStack (alignment: .center) {
                Spacer()
                //MARK: Header //36
                Text("Last step".uppercased())
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                    .padding(.bottom, 32)
                
                Text("How would you like to receive your reward?")
                    .font(.system(size: 20, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width / 4 * 3)
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom, 60)
                
                VStack(alignment: .center, spacing: 0) {
                    //MARK: Options
                    Divider()
                    
                    Button {
                        discountCodesViewModel.addCode(companyID: companyID, companyName: companyName, dollars: Int(rewardsUsed)/10, domain: "athleisure-la.myshopify.com", email: email, firstNameID: "COLIN1", pointsSpent: Int(rewardsUsed), usageLimit: 1, userID: userID)
                        rewardsProgramViewModel.updateLoyaltyPointsForReason(userID: userID, companyID: companyID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                        showSheet = false
                    } label: {
                        HStack {
                            Text("Add to my Personal Card")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                                .padding(.vertical, 18)
                                
                            Spacer()
                            Text("+ $\(rewardsUsed/10, specifier: "%.0f")")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .padding(.vertical, 18)
                        }.padding(.horizontal, 40)
                    }
                    
                    Divider()
                    
                    Button {
                        discountCodesViewModel.addCode(companyID: companyID, companyName: companyName, dollars: Int(rewardsUsed)/10, domain: "athleisure-la.myshopify.com", email: email, firstNameID: "COLIN1", pointsSpent: Int(rewardsUsed), usageLimit: 1, userID: userID)
                        rewardsProgramViewModel.updateLoyaltyPointsForReason(userID: userID, companyID: companyID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                        showSheet = false
                    } label: {
                        
                        HStack {
                            Text("Create a single-use discount card")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                                .padding(.vertical, 18)
                                
                            Spacer()
                            Text("$\(rewardsUsed/10, specifier: "%.0f")")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Dark1"))
                                .padding(.vertical, 18)
                        }.padding(.horizontal, 40)
                    }
                    
                    Divider()
                        .padding(.bottom, 32)
                }
                
                Spacer()
                
                //MARK: Cancel Button
                Button {
                    didUserPressRedeemButton = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Cancel")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                    }
                    
                }
                .padding(.bottom, 60)
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 12 * 7)
            
            
            
        } else {
            VStack (alignment: .center) {
                Spacer()
                //MARK: Header //36
                VStack(alignment: .center) {
                    Text("Redeem Points")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(String(currentPointsBalance-Int(rewardsUsed)) + " POINTS AVAILABLE")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                }.frame(height: 36, alignment: .center)
                
                //MARK: Amount //112
                Text("$\(rewardsUsed/10, specifier: "%.0f")")
                    .font(.system(size: 80, weight: .semibold, design: .rounded))
                    .foregroundColor(currentPointsBalance == 0 ? Color.gray : Color.green)
                    .padding(.vertical, 40)
                
                
                //MARK: SLIDER
                if currentPointsBalance > 50 {
                    Slider(
                    value: $rewardsUsed,
                    in: 0...Double(currentPointsBalance),
                    step: 50,
                    onEditingChanged: { (_) in
                        // nil here
                    },
                    minimumValueLabel: Text(""),
                    maximumValueLabel: Text(""),
                    label: {
                        Text("")
                    }).padding(.all, 16)
                        .padding(.bottom, 32)
                } else {
                    Slider(
                    value: $rewardsUsed,
                    in: 0...Double(100),
                    step: 50,
                    onEditingChanged: { (_) in
                        // nil here
                    },
                    minimumValueLabel: Text(""),
                    maximumValueLabel: Text(""),
                    label: {
                        Text("")
                    }).padding(.all, 16).disabled(true)
                        .padding(.bottom, 32)
                }
                
                //MARK: Convert Points Button
                Button {
                    
                    withAnimation(.easeInOut(duration: 0.2).repeatCount(1, autoreverses: false)) {
                            didUserPressRedeemButton = true
                        }
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Redeem")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(.white))
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 24).fill(currentPointsBalance == 0 ? Color.gray : Color.green))
                    .padding(.horizontal, 24)
                }.disabled(rewardsUsed==0)
                    .padding(.bottom, 60)
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 12 * 7)
        }
        
        
        
    }
}



