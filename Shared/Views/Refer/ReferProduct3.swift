//
//  ReferProduct3.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/20/22.
//

import SwiftUI

struct ReferProduct3: View {
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @Binding var selectedColor: Color
    
    @State var isShowingContactsList:Bool = false
    
    @State var selectedContact:[String] = ["", "First", "Last", ""]
    
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            CardForLoyaltyProgram(cardColor: selectedColor, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "YOUR-CODE", userFirstName: selectedContact[1], userLastName: selectedContact[2], userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                .frame(alignment: .center)
                .padding(.vertical)
            
            //MARK: PROMPT (80)
            Text("Choose a friend to receive this card")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.bottom)
                .padding(.bottom)
            
            
            
            Button {
                
                isShowingContactsList = true
                
            } label: {
                
                HStack {
                    Spacer()
                    Text(selectedContact[1] == "First" ? "Choose from contacts" : "Selected \(selectedContact[1]) \(selectedContact[2])")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                    Spacer()
                }.clipShape(RoundedRectangle(cornerRadius: 11))
                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(selectedContact[1] == "First" ? Color("ReferPurple") : Color("MediumPurple")))
                 .padding(.horizontal)
                 .padding(.horizontal)
                
            }
            
            
            
            
            
            
            Spacer()
            
            if selectedContact[1] == "First" {
                
                BottomCapsuleButton(buttonText: "Next", color: Color("Gray2"))
                
            } else {
                
                NavigationLink {
                    ReferProduct4(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, selectedColor: $selectedColor, selectedContact: $selectedContact)
                } label: {
                    
                    BottomCapsuleButton(buttonText: "Next", color: Color("ReferPurple"))
                    
                }
            }
            
            
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingContactsList) {
            isShowingContactsList = false
        } content: {
            ContactsView(isShowingContactsList: $isShowingContactsList, selectedContact: $selectedContact)
        }
        
        
    }
}
