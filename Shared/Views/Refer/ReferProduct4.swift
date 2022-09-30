//
//  ReferProduct4.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/21/22.
//

import SwiftUI

struct ReferProduct4: View {
    
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @Binding var designSelection: [Any]
    
    var selectedOption: Int
        
    @Binding var selectedContact:[String]
        
    @State var isCodeAvailable:Bool = false
    
    @State var userSuggestedCode:String = ""
    
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            
            DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode.isEmpty ? "CUSTOM-CODE" : userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
                .frame(alignment: .center)
                .padding(.vertical)
            
            
            //MARK: PROMPT (80)
            Text("Make a custom discount code for \(selectedContact[1])!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding()
                .padding(.bottom)
                .padding(.bottom)
            
            
            HStack(alignment: .center, spacing: 0) {
                
                TextField("Enter a custom code here (make a fun one!)", text: $userSuggestedCode)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .frame(minWidth: UIScreen.main.bounds.width / 2, minHeight: 50, alignment: .center)
                    .padding(.horizontal)
                    
                    .onSubmit {
                        
                        //check if the code is valid
                        hideKeyboard()

                    }
                    .submitLabel(.done)
                
                if isCodeAvailable {
                    
                    Text("Available")
                        .foregroundColor(Color.green)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.trailing)
                }
                
                
                Button {

                    isCodeAvailable = false
                    userSuggestedCode = ""
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("Dark1"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                
                
            }.padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0))
            .padding(.horizontal)
            
            
            
            
            if userSuggestedCode.isEmpty || isCodeAvailable {
                
                //nothing... empty view
                
            } else {
                
                Button {
                    
                    hideKeyboard()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isCodeAvailable = true
                        
                    }
                    
                } label: {
                    
                    HStack {
                        Spacer()
                        Text("Check availability")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.vertical)
                            .padding(.vertical)
                        Spacer()
                    }
                }
                
            }
            
            
            
            
            Spacer()
            
            if !isCodeAvailable {
                
                BottomCapsuleButton(buttonText: "Continue", color: Color("Gray3"))
                
            } else {
                
                NavigationLink {
                    ReferProduct5(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, designSelection: $designSelection, selectedOption: selectedOption, selectedContact: $selectedContact, userSuggestedCode: $userSuggestedCode)
                } label: {
                    
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                    
                }
            }
            
            
            
        }.edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
