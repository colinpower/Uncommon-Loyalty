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
    
    @Binding var designSelection: [Any]
    
    @State var isShowingContactsList:Bool = false
    
    @State var selectedContact:[String] = ["", "First", "Last", ""]
    
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: "CUSTOM-CODE", recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
                .frame(alignment: .center)
                .padding(.vertical)
            
            
            //MARK: PROMPT (80)
            Text("Who would you like to refer?")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.vertical)
                .padding(.bottom)
            
            
            
            Button {
                
                isShowingContactsList = true
                
            } label: {
                
                if selectedContact[1] == "First" {
                    
                    HStack {
                        Spacer()
                        Text("Choose from contacts")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.vertical, 16)
                        Spacer()
                    }.clipShape(RoundedRectangle(cornerRadius: 11))
                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color("ReferPurple")))
                     .padding(.horizontal)
                     .padding(.horizontal)
                    
                } else {
                    
                    HStack {
                        Spacer()
                        Text("Selected \(selectedContact[1]) \(selectedContact[2])")
                            .foregroundColor(Color("ReferPurple"))
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.vertical, 16)
                        Spacer()
                    }.clipShape(RoundedRectangle(cornerRadius: 11))
                        .background(RoundedRectangle(cornerRadius: 11).strokeBorder(lineWidth: 4).foregroundColor(Color("ReferPurple")))
                     .padding(.horizontal)
                     .padding(.horizontal)
                }
            }
            
            
            
            
            
            
            Spacer()
            
            if selectedContact[1] == "First" {
                
                BottomCapsuleButton(buttonText: "Continue", color: Color("Gray3"))
                
            } else {
                
                NavigationLink {
                    ReferProduct4(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, designSelection: $designSelection, selectedContact: $selectedContact)
                } label: {
                    
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                    
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
