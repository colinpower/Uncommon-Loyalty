//
//  AddLoyaltyProgramStep5.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI

struct AddLoyaltyProgramStep5: View {
    @Binding var indexOfCurrentAddLoyaltyProgramPage: Int
    var screenWidth: CGFloat
    
    var totalHeaderHeight: CGFloat
    
    @Binding var isAddLoyaltyProgramCarouselActive:Bool
    
    
    @State var cardColorVar: Color = Color("CardTeal")
    @State var companyImageVar: String = "Athleisure LA"
    @State var currentDiscountCode: String = ""
    
    var colorOptions:[Color] = [Color("CardTeal"), Color.red, Color("Gold1"), Color.blue, Color.yellow]
    
    var body: some View {
        VStack {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            GeometryReader { geometry in
                
                CardForLoyaltyProgram(cardColor: cardColorVar, textColor: Color.white, companyImage: companyImageVar, companyName: "Athleisure LA", currentDiscountAmount: "$0", currentDiscountCode: currentDiscountCode, userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "PERSONAL DISCOUNT CARD")
                
                .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
            }.padding()
            .frame(width: screenWidth, height: screenWidth/1.6)
            
            
            
            //MARK: 1 VIEWS FOR COLOR CHOICE (110 height)
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Select a color for your personal card")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.horizontal)
                
                //Empty... neither button selected, nothing posted to selectedContact or nameForRecipientEnteredManually
                    
                HStack(alignment: .center, spacing: 20 ) {

                    Button {
                        cardColorVar = colorOptions[0]
                        companyImageVar = "AthleisureLA-Icon-Teal"
                    } label: {
                        if cardColorVar == colorOptions[0] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[0])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[0])
                        }
                    }
                    
                    Button {
                        cardColorVar = colorOptions[1]
                    } label: {
                        
                        if cardColorVar == colorOptions[1] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[1])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[1])
                        }
                        
                    }
                    
                    Button {
                        cardColorVar = colorOptions[2]
                        companyImageVar = "AthleisureLA-Icon-Gold"
                    } label: {
                        
                        if cardColorVar == colorOptions[2] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[2])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[2])
                        }
                    }
                    
                    Button {
                        cardColorVar = colorOptions[3]
                    } label: {
                        
                        if cardColorVar == colorOptions[3] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[3])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[3])
                        }
                    }
                    
                    Button {
                        cardColorVar = colorOptions[4]
                    } label: {
                        
                        if cardColorVar == colorOptions[4] {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[4])
                        } else {
                            Image(systemName: "circle")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(colorOptions[4])
                        }
                    }
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 35)
                .padding(.bottom, 35)
                .frame(width: UIScreen.main.bounds.width, height: 110)
                
                
            }.frame(width: screenWidth, height: 110).padding(.vertical).padding(.vertical)
            
            //MARK: TEXT ENTRY FOR YOUR PERSONAL CODE
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Choose your personal discount code")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.horizontal)
                
                
                HStack(alignment: .center, spacing: 0) {
                    TextField("Enter whatever personal code you'd like", text: $currentDiscountCode)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .frame(minWidth: screenWidth / 2, minHeight: 50, alignment: .center)
                    //.padding(.vertical, 20)
                        .padding(.horizontal)
                    
                        .onSubmit {
                            
                            //check if the code is valid
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                currentDiscountCode = currentDiscountCode
                            }
                            
                        }
                        .submitLabel(.search)
                
                    Button {
                        currentDiscountCode = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
                .padding(.horizontal)
                .frame(width: screenWidth, height: 60)
                    .background(.white)
                
            }
            
            
            Spacer()
            
            
            //MARK: BUTTONS (48)
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                
                Button {

                    //zoom to the prior question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentAddLoyaltyProgramPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 48)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("ReferPurple")))
                }
                
                Spacer()
                
                //MARK: FINISH BUTTON
                Button {
                    
                    //zoom to the next question
                    isAddLoyaltyProgramCarouselActive = false
                    
                } label: {
                    HStack (alignment: .center, spacing: 2) {
                        Text("Finish")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 180, height: 48)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("ReferPurple")))
                }
                
                
            }
            .padding(.horizontal)
            .frame(height: 48, alignment: .center)
            .padding(.bottom).padding(.bottom)
            
        
            
        }
        .frame(width: screenWidth, height: totalHeaderHeight)
        
    }
}
