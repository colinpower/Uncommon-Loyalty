//
//  ReferProductStep2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI


//MARK: Method of creating the discount code
enum SelectedDiscountCreationMethod: String {
    case custom, random, reset
}



struct ReferProductStep2: View {
    
    //Environment
    
    //ViewModels
    
    //State

    @State var selectedDiscountCreationMethod: SelectedDiscountCreationMethod? = .reset
    
    
    @State var userSuggestedCode:String = ""
    @Binding var userAcceptedCode:String
    
    
    //Binding
    @Binding var indexOfCurrentReferPage:Int
    
    @Binding var selectedContact:[String]
    
    //Required variables
    
    var item: Items
    var promptForStep2:String
    var screenWidth:CGFloat
    var totalHeaderHeight:CGFloat
    
    @State var wasNextButton2Tapped:Bool = false
    @State var wasBackButton2Tapped:Bool = false
    
    
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
            //MARK: PROMPT (80)
            Text(promptForStep2 + selectedContact[1])
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 30)
                .padding(.horizontal)
                .frame(height: 54, alignment: .leading)
            
            //MARK: 4 VIEWS FOR CODE CREATION METHODS (110 height)
            VStack(alignment: .center, spacing: 0) {
            
                //Empty... neither button selected, nothing posted to selectedContact or nameForRecipientEnteredManually
                if (selectedDiscountCreationMethod == .reset)  {
                    
                        HStack {
                            
                            Button {
                                selectedDiscountCreationMethod = .custom
                            } label: {
                                Text("Make a custom code")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 20)
                                    .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("ReferPurple")))
                            }
                            
                            Spacer()
                            
                            Button {
                                userAcceptedCode = "SDF1443"
                                selectedDiscountCreationMethod = .random
                            } label: {
                                Text("Go Random")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.vertical, 20)
                                    .frame(width: UIScreen.main.bounds.width / 3 - CGFloat(20), height: 60)

                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 25)
                        .padding(.bottom, 25)
                        .frame(width: UIScreen.main.bounds.width, height: 110)
                }
            
                //Selected RANDOM and being displayed (110 height: 30 up and down, 50 in the middle)
                else if (selectedDiscountCreationMethod == .random ) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        //MARK: CONTACT CARD (60 total - 40 height, 10 padding above and below)
                        HStack(alignment: .center, spacing: 0) {
                            
                            //The Icon for a discount code (40 height)
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.green)
                                .padding(.trailing, 16)
                            
                            //The first + last names and the phone number (38 height)
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text(userAcceptedCode)
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.bottom, 3)
                                Text("Generated randomly")
                                    .foregroundColor(Color("Gray1"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                                withAnimation {
                                    userAcceptedCode = ""
                                    selectedDiscountCreationMethod = .reset
                                }
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            }
                                                        
                        }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0))

                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 110)
                    
                    
                }
                
                //Selected CUSTOM but nothing submitted yet (60 total - 40 height, 10 padding above and below)... 25 padding
                else if (selectedDiscountCreationMethod == .custom && userAcceptedCode.isEmpty) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            //The Icon for the submission form
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(Color("Dark1"))
//                                .font(.system(size: 18, weight: .semibold))
                            TextField("Like... \(selectedContact[1])-U-NEED-THIS", text: $userSuggestedCode)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .keyboardType(.alphabet)
                                .disableAutocorrection(true)
                                .frame(minWidth: screenWidth / 2, minHeight: 50, alignment: .center)
                                //.padding(.vertical, 20)
                                .padding(.horizontal)
                                
                                .onSubmit {
                                    
                                    //check if the code is valid
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        userAcceptedCode = userSuggestedCode

                                    }
                                    
                                }
                                .submitLabel(.search)
                            
                            Button {
                                //check if the code is valid
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    userAcceptedCode = userSuggestedCode
                                }
                            } label: {
                                //The Icon for the submission form
                                Image(systemName: "arrow.right.square.fill")
                                    .foregroundColor(Color("ReferPurple"))
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.horizontal)
                            }
                            
                            
                            Button {
                                userAcceptedCode = ""
                                userSuggestedCode = ""
                                selectedDiscountCreationMethod = .reset

                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 18, weight: .semibold))
                            }
                                                        
                        }
                            .padding(.horizontal)
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0))
                            .padding(.vertical, 25)
                        
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 110)
                    
                }
                
                //Selected CUSTOM AND SUBMITTED (60 total - 40 height, 10 padding above and below)... 25 padding
                else if (selectedDiscountCreationMethod == .custom && !userAcceptedCode.isEmpty) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        //MARK: CONTACT CARD (60 total - 40 height, 10 padding above and below)
                        HStack(alignment: .center, spacing: 0) {
                            
                            
                            //The Icon for a discount code (40 height)
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.green)
                                .padding(.trailing, 16)
                            
                            //The first + last names and the phone number (38 height)
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text(userAcceptedCode)
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.bottom, 3)
                                Text("Claimed custom code")
                                    .foregroundColor(Color("Gray1"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                                withAnimation {
                                    userAcceptedCode = ""
                                    userSuggestedCode = ""
                                    selectedDiscountCreationMethod = .reset
                                }
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            }
                                                        
                        }
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0))

                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 110)
                }
                
            }.frame(height: 110)

            
            //MARK: BUTTONS
            HStack(alignment: .center) {
                
                //MARK: BACK BUTTON
                
                Button {

                    //zoom to the prior question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentReferPage -= 1
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
                
                //MARK: OK / PREVIEW BUTTON
                Button {
                    //zoom to the next question
                    withAnimation(.linear(duration: 0.15)) {
                        indexOfCurrentReferPage += 1
                    }
                } label: {
                    HStack (alignment: .center, spacing: 2) {
                        Text("OK")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(userAcceptedCode.isEmpty ? Color("Background") : .white)
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(userAcceptedCode.isEmpty ? Color("Background") : .white)
                    }
                    .frame(width: 96, height: 48)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(userAcceptedCode.isEmpty ? Color("Background") : Color("ReferPurple")))
                }.disabled(userAcceptedCode.isEmpty)
                
                
            }
            .padding(.horizontal)
            .frame(height: 48, alignment: .center)

            
            Spacer()
            
            
            
            
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        .frame(width: screenWidth, height: UIScreen.main.bounds.height-totalHeaderHeight)
        .onAppear {
            print("We're on page \(indexOfCurrentReferPage)")
            //print(reviewQuestionForThisPage)
        }
        
    }
}

