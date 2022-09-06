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
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var rewardsProgramViewModelVar = RewardsProgramViewModel()
    var discountCodesViewModelVar = DiscountCodesViewModel()
    
    
    @State var rewardsUsed: Double = 0
    
    //@Binding var isCreateDiscountScreenActive: Bool
    
    @Binding var showSheet:Bool
    
    var companyID: String
    var companyName: String
    var currentPointsBalance: Int
    
    @State var userSelectedPersonalCard:Bool = true
    
    
    var body: some View {
        VStack (alignment: .center) {
            
            //MARK: Header
            //MARK: HEADER (104 height)
            VStack(alignment: .center, spacing: 0) {
                
                //The top bar
                HStack(alignment: .center) {
                    
                    Label {
                        Text("Redeem Points")
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                    } icon: {
                        Image(systemName: "dollarsign.square.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("Gold1"))
                    }
                    
                    Spacer()
                    
                }.padding(.horizontal)
                .padding(.top, 32)
                .padding(.bottom, 20)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 76)
            }
            
            
            //MARK: LOYALTY CARD SWITCHER
            if userSelectedPersonalCard {
                //Default card
                CardForLoyaltyProgram(cardColor: Color("Gold1"), textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$" + String(Int(rewardsUsed/10)), currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                    .frame(alignment: .center)
                    .padding(.bottom)
            } else {
                //New card
                CardForLoyaltyProgram(cardColor: Color.black, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$" + String(Int(rewardsUsed/10)), currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "New Card")
                    .frame(alignment: .center)
                    .padding(.bottom)
            }
            
            Button {
                userSelectedPersonalCard.toggle()
            } label: {
                Text("Use personal card?")
            }
            
            VStack(alignment: .center) {
                Text("Convert Points")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                Text(String(currentPointsBalance-Int(rewardsUsed)) + " POINTS AVAILABLE")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            //MARK: Amount
            Text("$\(rewardsUsed/10, specifier: "%.0f")")
                .font(.system(size: 100))
                .foregroundColor(currentPointsBalance == 0 ? Color.gray : Color.green)
                .padding(.bottom, 12)
            Spacer()
            
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
                }).padding()
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
                }).padding().disabled(true)
            }
            Spacer()
            
            //MARK: Convert Points Button
            Button {   
                discountCodesViewModelVar.addCode(companyID: companyID, companyName: companyName, dollars: Int(rewardsUsed)/10, domain: "athleisure-la.myshopify.com", email: viewModel.email!, firstNameID: "COLIN1", pointsSpent: Int(rewardsUsed), usageLimit: 1, userID: viewModel.userID!)
                rewardsProgramViewModelVar.updateLoyaltyPointsForReason(userID: viewModel.userID!, companyID: companyID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                showSheet = false
            } label: {
                HStack {
                    Spacer()
                    Text("Convert points")
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.vertical, 12)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 24).fill(currentPointsBalance == 0 ? Color.gray : Color.blue))
                .padding(.horizontal, 24)
            }
                .disabled(rewardsUsed==0)
            
        }
            .ignoresSafeArea()
            .background(Color("Background"))
    }
}
