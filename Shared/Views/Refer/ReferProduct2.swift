//
//  ReferProduct2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/20/22.
//

import SwiftUI

struct ReferProduct2: View {
    
    //@Binding var isShowingReferExperience:Bool
    @Binding var activeReviewOrReferSheet: ActiveReviewOrReferSheet?
    
    var itemObject: Items
    
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
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: "CUSTOMIZE-ME", recipientFirstName: "Your Friend's", recipientLastName: "Name")
                .frame(alignment: .center)
                .padding(.vertical)
            
            
            //MARK: PROMPT (80)
            Text("Choose a color for this card")
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
                    ReferProduct3(activeReviewOrReferSheet: $activeReviewOrReferSheet, itemObject: itemObject, designSelection: $designSelection, selectedOption: selectedOption)
                } label: {
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                }
            }
            
            
            
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}



struct ColorOptionForReferral: View {
    
    
    
    @Binding var designSelection: [Any]
    
    @Binding var selectedOption: Int
    
    var designSelectionVar: [Any]
    
    var currentOptionNumber: Int
    
    var overrideForeground:Bool = false
    
    
    
    var body: some View {
        
        let cardBackgroundColor = designSelectionVar[0] as! Color
        let cardTextColor = designSelectionVar[1] as! Color
        let cardType = designSelectionVar[2] as! String
        let cardTitle = designSelectionVar[3] as! String

        
        Button {
            designSelection = designSelectionVar
            selectedOption = currentOptionNumber
            
        } label: {
            
            VStack(alignment: .center, spacing: 6) {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(cardBackgroundColor)
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width / 3 * 5 / 8 )
                    .background(RoundedRectangle(cornerRadius: 9)
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(selectedOption == currentOptionNumber ? cardBackgroundColor : Color.clear)
                        .frame(width: UIScreen.main.bounds.width/3 + 10, height: UIScreen.main.bounds.width / 3 * 5 / 8 + 10))
                if currentOptionNumber == 0 || currentOptionNumber == 1 {
                    Text(cardTitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(cardTextColor)
                } else if currentOptionNumber == 6 {
                    Text("Engraved " + cardTitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.gray)
                } else {
                    Text(cardTitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(cardBackgroundColor == Color.white ? cardTextColor : cardBackgroundColor)
                }
                
            }
        }
    }
}






