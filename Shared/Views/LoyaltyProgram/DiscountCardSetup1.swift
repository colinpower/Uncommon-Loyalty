//
//  DiscountCardSetup1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/3/22.
//

import SwiftUI

struct DiscountCardSetup1: View {
    
    var rewardsProgram: RewardsProgram
    
    @Binding var activeLoyaltySheet:ActiveLoyaltySheet?
    
    @State var designSelection: [Any] = [Color.white, Color.white, "engraved", "White"]    //cardColor, textColor, type (engraved or normal), title
    
    @State var selectedOption: Int = -1
    
    var options: [[Any]] = [
        [Color("ReviewTealImage"), Color("Yoga"), "normal", "Robin"],
        [Color("ThemeLight"), Color("ThemeAction"), "normal", "Uncommon"],
        [Color.green, Color.white, "normal", "Green"],
        [Color.yellow, Color.gray, "normal", "Yellow"],
        [Color.blue, Color.white, "normal", "Blue"],
        [Color("Gold1"), Color.white, "engraved", "Gold"],
        [Color.white, Color.white, "engraved", "White"],
        [Color("CardTeal"), Color.white, "engraved", "Teal"]
    ]
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
                DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: rewardsProgram.card.companyName, discountAmount: "$0", discountCode: "CUSTOMIZE-ME", recipientFirstName: rewardsProgram.owner.firstName, recipientLastName: rewardsProgram.owner.lastName)
                    .frame(alignment: .center)
                    .padding(.vertical)
                
                //MARK: PROMPT (80)
                Text("Choose a color for your personal discount card")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                    .padding(.vertical)
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 16) {
                        
                        ForEach(0..<8) { i in
                            
                            ColorOptionForReferral(designSelection: $designSelection, selectedOption: $selectedOption, designSelectionVar: options[i], currentOptionNumber: i)
                        }
                        
                    }.offset(x: 20)
                        .padding(.trailing, 40)
                        .frame(height: UIScreen.main.bounds.width / 3)
                        .background(Rectangle().foregroundColor(Color("Background")))
                }
                
                
                
                Spacer()
                
                if selectedOption == -1 {
                    
                    BottomCapsuleButton(buttonText: "Continue", color: Color("Gray3"))
                    
                } else {
                    
                    NavigationLink {
                        DiscountCardSetup2(rewardsProgram: rewardsProgram, activeLoyaltySheet: $activeLoyaltySheet, designSelection: $designSelection, selectedOption: selectedOption)
                        
                        //(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, designSelection: $designSelection, selectedOption: selectedOption)
                    } label: {
                        BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                    }
                }
                
                
                
                
            }.edgesIgnoringSafeArea(.bottom)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
