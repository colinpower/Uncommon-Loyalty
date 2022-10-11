//
//  FREGetName.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/5/22.
//

import SwiftUI

//
//struct TextFieldNameModifier: ViewModifier {
//    @Binding var value: String
//    @Binding var first: String
//    @Binding var last: String
//
//    func body(content: Content) -> some View {
//        content.onReceive(value.publisher.collect()) {
//
//            firstLastFormatter(first: $first, last: $last, arr: value.components(separatedBy: " "))
//
//            value = value
//
//            }
//    }
//}
//
//func firstLastFormatter(first: Binding<String>, last: Binding<String>, arr: [String]) {
//
//
//
//
//}

//
//extension View {
//    func formatNames(value: Binding<String>, first: Binding<String>, last: Binding<String>) -> some View {
//        self.modifier(TextFieldNameModifier(value: value, first: first, last: last))
//    }
//}




struct FREGetName: View {
    
    @ObservedObject var usersViewModel = UsersViewModel()
    
    var email:String
    var userID:String
    
    @State var nameEntry: String = ""
    
    @Binding var hasEnteredNameAndPhone:Bool
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("What's your name?")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("Step 1 of 2. Setup is fast!")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                }
                .padding(.horizontal)
                
                Spacer()
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        if (nameEntry.count > 0) {
                            
                            Text("FIRST")
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                            
                            let firstNameVar = nameEntry.components(separatedBy: " ")[0]
                            Text(firstNameVar)
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 40))
                                .fontWeight(.semibold)
                        } else {
                            
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width / 2, alignment: .center)
                    VStack(alignment: .leading, spacing: 6) {
                        
                        if (nameEntry.contains(" ")) {
                            
                            Text("LAST")
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                            
                            let lastNameVar = nameEntry.components(separatedBy: " ")[1]
                            Text(lastNameVar)
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 40))
                                .fontWeight(.semibold)
                        } else {
                            
                        }
                    }.frame(width: UIScreen.main.bounds.width / 2, alignment: .center)
                }
                
                
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Spacer()
                    
                    TextField("Enter your first and last names", text: $nameEntry)
                        //.formatNames(value: $nameEntry, first: $firstNameEntry, last: $lastNameEntry)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("ThemePrimary"))
                        .padding(.horizontal)
                        .padding(.leading, 4)
                        .frame(width: UIScreen.main.bounds.width - 72 - 60, height: 60, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .submitLabel(.done)
                        .onSubmit {
                            
                            hideKeyboard()
                            
                        }
                        .padding(.trailing, 12)
                    
                        NavigationLink {

                            if (nameEntry.count > 0 && nameEntry.contains(" ")) {
                                let firstNameEntry = nameEntry.components(separatedBy: " ")[0]
                                let lastNameEntry = nameEntry.components(separatedBy: " ")[1]
                                FREValidatePhone(userID: userID, firstName: firstNameEntry, lastName: lastNameEntry, hasEnteredNameAndPhone: $hasEnteredNameAndPhone)
                                
                            } else {
                                
                            }
                            
                            
                            
                        } label: {
                            
                            Image(systemName: "arrow.right")
                                .font(Font.system(size: 36, weight: .semibold))
                                .foregroundColor((nameEntry.components(separatedBy: " ").count < 2) ? Color.gray : Color.white)
                            
                        }
                        .onTapGesture {
                            
                            if (nameEntry.count > 0 && nameEntry.contains(" ")) {
                                let firstNameEntry = nameEntry.components(separatedBy: " ")[0]
                                let lastNameEntry = nameEntry.components(separatedBy: " ")[1]
                                usersViewModel.updateUserID(email: email, firstName: firstNameEntry, lastName: lastNameEntry, phone: "", userID: userID)
                                
                            } else {
                                
                            }
                            
                            
                            
                        }
                        .disabled(nameEntry.components(separatedBy: " ").count < 2)
                    
                    Spacer()

                        
                }
                .padding(.horizontal, 20)
                .padding(.leading, 40)
                .frame(width: UIScreen.main.bounds.width-60, height: 60, alignment: .center)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal)
            .edgesIgnoringSafeArea(.all)
            .background(Color("bg"))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
}
