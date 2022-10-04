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
    
    @Binding var showSheet:Bool
    
    var rewardsProgram: RewardsProgram
    
    @StateObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @StateObject var discountCodesViewModel = DiscountCodesViewModel()
    
    @State var rewardsUsed: Double = 0
    
    
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
                    
                    //Add to personal card
                    Button {
                        
                        let discountID = UUID().uuidString
  
                        //This should be UPDATING the card, not adding to it
//                        discountCodesViewModel.addCode(color: 2, companyID: rewardsProgram.companyID, companyName: rewardsProgram.companyName, discountCode: "COLIN123", cardType: "PERSONAL-CARD-PERMANENT", discountID: discountID, domain: rewardsProgram.domain, firstName: "Colin", lastName: "Power", phone: "", email: rewardsProgram.email, expirationTimestamp: -1, minimumSpendRequired: -1, rewardAmount: Int(rewardsUsed)/10, rewardType: "DOLLARS", usageLimit: 1, pointsSpent: Int(rewardsUsed), userID: rewardsProgram.userID)

                        rewardsProgramViewModel.updateLoyaltyPointsForReason(loyaltyProgramID: rewardsProgram.ids.rewardsProgramID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                        
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
                    
                    //Create on-off card
                    Button {
                        
                        let discountID = UUID().uuidString
                        let discountCode = rewardsProgram.owner.email.prefix(5) + "-" + randomString(of: 5)
                        
                        discountCodesViewModel.addCode(color: 2, companyID: rewardsProgram.ids.companyID, companyName: rewardsProgram.card.companyName, discountCode: discountCode, cardType: "PERSONAL-CARD-SINGLE-USE", discountID: discountID, domain: rewardsProgram.ids.domain, firstName: rewardsProgram.owner.firstName, lastName: rewardsProgram.owner.lastName, phone: rewardsProgram.owner.phone, email: rewardsProgram.owner.email, expirationTimestamp: -1, minimumSpendRequired: -1, rewardAmount: Int(rewardsUsed)/10, rewardType: "DOLLARS", usageLimit: 1, pointsSpent: Int(rewardsUsed), userID: rewardsProgram.ids.userID)

                        rewardsProgramViewModel.updateLoyaltyPointsForReason(loyaltyProgramID: rewardsProgram.ids.rewardsProgramID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                        
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
            
            
            
        }
        
        else {
            VStack (alignment: .center) {
                Spacer()
                //MARK: Header //36
                VStack(alignment: .center) {
                    Text("Redeem Points")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(String(rewardsProgram.status.currentPointsBalance-Int(rewardsUsed)) + " POINTS AVAILABLE")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                }.frame(height: 36, alignment: .center)
                
                //MARK: Amount //112
                Text("$\(rewardsUsed/10, specifier: "%.0f")")
                    .font(.system(size: 80, weight: .semibold, design: .rounded))
                    .foregroundColor(rewardsProgram.status.currentPointsBalance == 0 ? Color.gray : Color.green)
                    .padding(.vertical, 40)
                
                
                //MARK: SLIDER
                if rewardsProgram.status.currentPointsBalance > 50 {
                    Slider(
                    value: $rewardsUsed,
                    in: 0...Double(rewardsProgram.status.currentPointsBalance),
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
                    .background(RoundedRectangle(cornerRadius: 24).fill(rewardsProgram.status.currentPointsBalance == 0 ? Color.gray : Color.green))
                    .padding(.horizontal, 24)
                }.disabled(rewardsUsed==0)
                    .padding(.bottom, 60)
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 12 * 7)
        }
    }
}



