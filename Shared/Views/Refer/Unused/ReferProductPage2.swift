//
//  ReferProductPage2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import Foundation
import SwiftUI
import UIKit
import MobileCoreServices

struct ReferProductPage2: View {
    

    @State var selectedContact:[String] = ["", "", "", ""]  // ID, first name, last name, phone number
    
    
    @State var chosenCodeCreationMethod:Int = 0
    
    @State var userSuggestedCode:String = ""
    
    @State var isShowingContactsList:Bool = false
    
    var cardWidth:CGFloat = UIScreen.main.bounds.width - 40
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: USER-CREATED CARD ON THE TOP
            HStack {
                
                Spacer()
                
                ZStack(alignment: .topLeading) {
                    
                    Rectangle().foregroundColor(.green)
                        .frame(width: cardWidth, height: cardWidth * 5 / 8)
                    
                    VStack {
                        
                        HStack {
                            Text("Athleisure LA")
                            Spacer()
                            Text("20% Discount")
                        }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text(userSuggestedCode)
                                .font(.system(size: 60, weight: .semibold))
                            Spacer()
                        }.frame(height: cardWidth * 5 / 16) //i.e. 1/2 of the card in terms of height)
                        
                        HStack {
                            Text("colinjpower1@gmail.com")
                            Spacer()
                            Text("Expires in 30 days (Oct 3)")
                        }.frame(height: cardWidth * 5 / 32) //i.e. 1/4 of the card in terms of height
                        
                    }.frame(width: cardWidth, height: cardWidth * 5 / 8)
                }
                Spacer()
            }.padding(.bottom, 40)
            
            
            Button {
                isShowingContactsList.toggle()
            } label: {
                Text("SHOW CONTACTS")
            }
            .sheet(isPresented: $isShowingContactsList) {
                isShowingContactsList = false
            } content: {
                ContactsView(isShowingContactsList: $isShowingContactsList, selectedContact: $selectedContact)
            }

            Text("Create your discount code!!!").padding(.bottom)
            
            HStack(spacing: 48) {
                
                Button {
                    if chosenCodeCreationMethod != 1 {
                        withAnimation {
                            chosenCodeCreationMethod = 1
                        }
                    } else {
                        chosenCodeCreationMethod = 0
                    }
                } label: {
                    Text("Custom")
                        .foregroundColor(chosenCodeCreationMethod == 1 ? .blue : .black)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder().foregroundColor(chosenCodeCreationMethod == 1 ? .blue : .black))
                }
                
                Button {
                    if chosenCodeCreationMethod != 2 {
                        chosenCodeCreationMethod = 2
                        
                        userSuggestedCode = "CS023v4"
                        
                    } else {
                        chosenCodeCreationMethod = 0
                    }
                } label: {
                    Text("Random")
                        .foregroundColor(chosenCodeCreationMethod == 2 ? .blue : .black)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder().foregroundColor(chosenCodeCreationMethod == 2 ? .blue : .black))
                }
                
            }
            
            if chosenCodeCreationMethod == 1 {
                HStack {
                    TextField("Write here...", text: $userSuggestedCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 20)
                        .padding(.horizontal)
                        .frame(height: 80, alignment: .center)
                        .onSubmit {
                            //need to query the DB and see if the code is available
                        }
                    Spacer(minLength: 10)
                    Button {
                        //submit to backend to see if user is able to get a referral
                    } label: {
                        Text("Submit")
                    }
                }
                
            }
            
            Spacer()
            
            NavigationLink {
                ReferProductPage3(userSuggestedCode: $userSuggestedCode, cardWidth: cardWidth)
            } label: {
                HStack {
                    Spacer()
                    Text("Preview your referral")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                    Spacer()
                }.background(RoundedRectangle(cornerRadius: 36).fill(Color("ReferPurple")))
                 .padding(.horizontal)
                 .padding(.horizontal)
            }
            .padding(.bottom)
            .padding(.bottom)
            
            
            
        }
    }
}

struct ReferProductPage2_Previews: PreviewProvider {
    static var previews: some View {
        ReferProductPage2()
    }
}





