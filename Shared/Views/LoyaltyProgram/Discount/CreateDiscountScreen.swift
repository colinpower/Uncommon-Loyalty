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
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    
    
    @State var rewardsUsed: Double = 0
    
    @Binding var isCreateDiscountScreenActive: Bool
    
    var companyID: String
    var companyName: String
    var currentPointsBalance: Int
    
    
    
    var body: some View {
        VStack (alignment: .center) {
            
            //MARK: Header
            SheetHeader(title: "Redeem", isActive: $isCreateDiscountScreenActive)
            Spacer()
            
            //MARK: Description
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
            if currentPointsBalance > 0 {
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
                viewModel2.addCode(companyID: companyID, companyName: companyName, dollars: Int(rewardsUsed)/10, domain: "athleisure-la.myshopify.com", email: viewModel.email!, firstNameID: "COLIN1", pointsSpent: Int(rewardsUsed), usageLimit: 1, userID: viewModel.userID!)
                viewModel1.updateLoyaltyPointsForReason(userID: viewModel.userID!, companyID: companyID, changeInPoints: Int(rewardsUsed) * -1, reason: "CreatedDiscount")
                isCreateDiscountScreenActive.toggle()
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
            
        }.navigationTitle("").navigationBarHidden(true)
            .ignoresSafeArea().padding(.horizontal).padding(.bottom)
    }
}

struct CreateDiscountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateDiscountScreen(isCreateDiscountScreenActive: .constant(true), companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", currentPointsBalance: 100)
    }
}
