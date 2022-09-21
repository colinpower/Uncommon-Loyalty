//
//  ReferProduct2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/20/22.
//

import SwiftUI

struct ReferProduct2: View {
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @State var selectedColor: Color = Color.white
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            CardForLoyaltyProgram(cardColor: selectedColor, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "YOUR-CODE", userFirstName: "First", userLastName: "Last", userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                .frame(alignment: .center)
                .padding(.vertical)
            
            //MARK: PROMPT (80)
            Text("Choose a color for this card")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.bottom)
                .padding(.bottom)
            
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 16) {
                    
                    Button {
                        selectedColor = Color.black
                    } label: {
                        ColorOptionForReferral(colorForOption: Color.black)
                    }
                    
                    Button {
                        selectedColor = Color.green
                    } label: {
                        ColorOptionForReferral(colorForOption: Color.green)
                    }
                    
                    Button {
                        selectedColor = Color.yellow
                    } label: {
                        ColorOptionForReferral(colorForOption: Color.yellow)
                    }
                    
                    Button {
                        selectedColor = Color("ReferPurple")
                    } label: {
                        ColorOptionForReferral(colorForOption: Color("ReferPurple"))
                    }
                    
                    Button {
                        selectedColor = Color("Gold1")
                    } label: {
                        ColorOptionForReferral(colorForOption: Color("Gold1"))
                    }
                        
                }.offset(x: 20)
                .padding(.trailing, 40)
            }
            

            
            Spacer()
            
            NavigationLink {
                ReferProduct3(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, selectedColor: $selectedColor)
            } label: {
                BottomCapsuleButton(buttonText: "Next", color: Color("ReferPurple"))
            }
        }.edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}



struct ColorOptionForReferral: View {
    
    var colorForOption: Color
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(colorForOption)
            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width / 3 * 5 / 8 )
        
    }
}






