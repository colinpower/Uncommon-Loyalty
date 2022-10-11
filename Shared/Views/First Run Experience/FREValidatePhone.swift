//
//  FREValidatePhone.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/5/22.
//

import SwiftUI


struct TextFieldPhoneNumberModifer: ViewModifier {
    @Binding var value: String

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                
                if value.count == 1 {
                    if String($0) != "(" {
                        value = "(" + String($0)
                    }
                } else if value.count == 5 {
                    if String($0[$0.index($0.startIndex, offsetBy: 4)]) != ")" {
                        value = String($0.prefix(4)) + ")" + String($0[$0.index($0.startIndex, offsetBy: 4)])
                    }
                } else if value.count == 6 {
                    if String($0[$0.index($0.startIndex, offsetBy: 5)]) != " " {
                        value = String($0.prefix(5)) + " " + String($0[$0.index($0.startIndex, offsetBy: 5)])
                    }
                } else if value.count == 10 {
                    if String($0[$0.index($0.startIndex, offsetBy: 9)]) != "-" {
                        value = String($0.prefix(9)) + "-" + String($0[$0.index($0.startIndex, offsetBy: 9)])
                    }
                }
            }
    }
}

extension View {
    func formatPhoneNumber(value: Binding<String>) -> some View {
        self.modifier(TextFieldPhoneNumberModifer(value: value))
    }
}





struct FREValidatePhone: View {
    
    @ObservedObject var usersViewModel = UsersViewModel()
    
    var userID:String
    var firstName: String
    var lastName: String
    
    @Binding var hasEnteredNameAndPhone:Bool
    
    @State var hasRequestedVerificationCode:Bool = false
    @State var hasSubmittedVerificationCode:Bool = false
    
    @State var phoneNumber:String = ""
    @State var formattedPhoneNumber:String = ""             //value = String($0.prefix(length)).replacingOccurrences(of: " ", with: "-")
    @State var verificationCodeSubmission:String = ""
    
    @State var verificationID = UUID().uuidString
    
    
    var body: some View {
        
    
        
        VStack(alignment: .leading, spacing: 0) {
            
            if (!hasRequestedVerificationCode) {
                
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Add your phone number")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("We'll use it to find items that you've purchased. We will never call, text, or share your number.")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 18, weight: .regular))
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Spacer()
                    
                    Text("+1")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.vertical, 18)
                        .padding(.trailing, 6)
                    
                    TextField("Enter your phone number", text: $formattedPhoneNumber)
                        .formatPhoneNumber(value: $formattedPhoneNumber)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("ThemePrimary"))
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width / 5 * 3, height: 60, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        .submitLabel(.send)
                        .onSubmit {
                            
                            hideKeyboard()
                            
                            verificationID = UUID().uuidString
                            
                            phoneNumber = "+1" + formattedPhoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
                            
                            usersViewModel.requestVerificationCode(phone: phoneNumber, codeExpiresInSeconds: 180, userID: userID, verificationID: verificationID)
                            
                            usersViewModel.listenForPhoneVerification(userID: userID, verificationID: verificationID)
                            
                            hasRequestedVerificationCode = true
                            
                        }.padding(.trailing, 12)
                 
                    Button {
                        
                        verificationID = UUID().uuidString
                        
                        phoneNumber = "+1" + formattedPhoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
                        
                        usersViewModel.requestVerificationCode(phone: phoneNumber, codeExpiresInSeconds: 180, userID: userID, verificationID: verificationID)
                        
                        usersViewModel.listenForPhoneVerification(userID: userID, verificationID: verificationID)
                        
                        hasRequestedVerificationCode = true
                        
                    } label: {
                        
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 36, weight: .semibold))
                            .foregroundColor((formattedPhoneNumber.count == 14) ? Color.white : Color.gray)
                        
                    }
                    
                    Spacer()
                    
                }.frame(alignment: .center)
                .padding(.horizontal)
                
                Spacer()
                Spacer()
                Spacer()
                
            }
            else if (hasRequestedVerificationCode && !hasSubmittedVerificationCode) {
                
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("We just texted you")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("You provided the number \(phoneNumber).")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 18, weight: .regular))
                }
                .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                HStack (alignment: .center, spacing: 16) {
                  
                    TextField("Enter code", text: $verificationCodeSubmission)
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width / 2, height: 60, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .keyboardType(.numberPad)
                        .submitLabel(.send)
                        .onSubmit {
                            
                            hideKeyboard()
                            
                            usersViewModel.submitVerificationCode(code: verificationCodeSubmission, userID: userID, verificationID: verificationID)
                            
                            hasSubmittedVerificationCode = true
                            
                        }
                
                    Button {
                        
                        usersViewModel.submitVerificationCode(code: verificationCodeSubmission, userID: userID, verificationID: verificationID)
                        
                        hasSubmittedVerificationCode = true
                        
                    } label: {
                        
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 40, weight: .bold))
                            .foregroundColor((verificationCodeSubmission.count == 4) ? Color.white : Color.gray)
                        
                    }
                
                
                
                }.padding(.horizontal)
                
                Spacer()
                Spacer()
                
                
            }
            else {
                
                if(usersViewModel.oneVerificationResult.isEmpty) {
                    
                    //haven't gotten the result back yet
                    Spacer()
                    Text("Checking code")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .font(.system(size: 15))
                    
                    Spacer()
                    Spacer()
                    
                    
                } else {
                    
                    if let isPhoneVerified = usersViewModel.oneVerificationResult.first?.isVerified {
                        
                        if(isPhoneVerified) {
                            
                            //haven't gotten the result back yet
                            Spacer()
                            Text("Verified")
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .padding(.horizontal)
                            Spacer()
                            
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                .font(.system(size: 15))
                            
                            
                            Spacer()
                            
                            Button {
                            
                                hasEnteredNameAndPhone = true
                            
                            } label: {
                                
                                HStack(alignment: .center, spacing: 10) {
                                    
                                    Spacer()
                                    Text("Let's go!")
                                        .font(Font.system(size: 40, weight: .semibold))
                                        .foregroundColor(Color.white)
                                    
                                    Image(systemName: "arrow.right")
                                        .font(Font.system(size: 40, weight: .bold))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                    
                                }.padding(.horizontal)
                                .frame(height: 40)
                            }
                            
                            Spacer()
                            
                            
                            
                        } else {
                            
                            //haven't gotten the result back yet
                            Spacer()
                            Text("Incorrect code")
                                .foregroundColor(Color("ThemeLight"))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .padding(.horizontal)
                            Spacer()
                            
                            
                            Button {
                                
                                hasRequestedVerificationCode = false
                                hasSubmittedVerificationCode = false
                                
                                phoneNumber = ""
                                formattedPhoneNumber = ""
                                verificationCodeSubmission = ""
                                
                                verificationID = UUID().uuidString
                                
                            } label: {
                                
                                HStack(alignment: .center, spacing: 10) {
                                    
                                    Spacer()
                                    Text("Retry")
                                        .font(Font.system(size: 40, weight: .semibold))
                                        .foregroundColor(Color.white)
                                    
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(Font.system(size: 40, weight: .bold))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                    
                                }.padding(.horizontal)
                                .frame(height: 40)
                                
                            }
                            
                            Spacer()
                            Spacer()
                        

                        }
                    } else {
                        
                        //haven't gotten the result back yet
                        Spacer()
                        Text("Error")
                            .foregroundColor(Color("ThemeLight"))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                            .padding(.horizontal)
                        Spacer()
                        
                        
                        Button {
                            
                            hasRequestedVerificationCode = false
                            hasSubmittedVerificationCode = false
                            
                            phoneNumber = ""
                            formattedPhoneNumber = ""
                            verificationCodeSubmission = ""
                            
                            verificationID = UUID().uuidString
                            
                        } label: {
                            
                            HStack(alignment: .center, spacing: 10) {
                                
                                Spacer()
                                Text("Retry")
                                    .font(Font.system(size: 40, weight: .semibold))
                                    .foregroundColor(Color.white)
                                
                                Image(systemName: "arrow.counterclockwise")
                                    .font(Font.system(size: 40, weight: .bold))
                                    .foregroundColor(Color.white)
                                Spacer()
                                
                            }.padding(.horizontal)
                            .frame(height: 40)
                            
                        }
                        
                        Spacer()
                        Spacer()

                    }
                    
                }
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .edgesIgnoringSafeArea(.all)
        .background(Color("bg"))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
            usersViewModel.listenForPhoneVerification(userID: userID, verificationID: verificationID)
            
        }
    }
}
