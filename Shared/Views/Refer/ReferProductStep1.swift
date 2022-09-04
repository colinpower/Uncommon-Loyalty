//
//  ReferProductStep1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI


//MARK: Set the possible values for Choose Contact / Enter manually
enum SelectedContactMethod: String {
    case selectFromContacts, enterManually, reset
//    var id: String {
//        return self.rawValue
//    }
}




struct ReferProductStep1: View {
    
    //Environment
    
    //ViewModels
    
    //State
    @State var nameForRecipientEnteredManually:String = ""

    @State var selectedContactMethod: SelectedContactMethod? = .reset
    
    
    //Binding
    @Binding var indexOfCurrentReferPage:Int
    @Binding var isShowingContactsList:Bool
    
    @Binding var selectedContact:[String]
    //Required variables
    
    var item: Items
    var promptForStep1:String
    var screenWidth:CGFloat
    var totalHeaderHeight:CGFloat
    
    @State var wasNextButton1Tapped:Bool = false
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: PROMPT (80)
            Text(promptForStep1)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Dark1"))
                .padding(.top, 30)
                .padding(.horizontal)
                .frame(height: 54, alignment: .leading)
            
            
            
            //MARK: 4 VIEWS FOR CONTACT METHODS (110 height)
            VStack(alignment: .center, spacing: 0) {
                
                //Empty... neither button selected, nothing posted to selectedContact or nameForRecipientEnteredManually
                if ((selectedContactMethod == .reset || selectedContactMethod == .selectFromContacts )
                    && selectedContact[0].isEmpty) {
                    
                        HStack {
                            
                            Button {
                                selectedContactMethod = .selectFromContacts
                                isShowingContactsList = true
                            } label: {
                                Text("Choose Contact")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 20)
                                    .frame(width: UIScreen.main.bounds.width * 2 / 3 - CGFloat(40), height: 60)
                                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("ReferPurple")))
                            }
                            
                            Spacer()
                            
                            Button {
                                selectedContactMethod = .enterManually
                            } label: {
                                Text("Enter manually")
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
                
                //Contact selected and being displayed (110 height: 30 up and down, 50 in the middle)
                else if (selectedContactMethod == .selectFromContacts && !selectedContact[0].isEmpty) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        //MARK: CONTACT CARD (60 total - 40 height, 10 padding above and below)
                        HStack(alignment: .center, spacing: 0) {
                            
                            //The Circle + Letter for each contact (40 height)
                            ZStack(alignment: .center) {
                                Circle().frame(width: 40, height: 40)
                                    .foregroundColor(.green)
                                Text(selectedContact[1].prefix(1))
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                            }
                                .padding(.trailing, 16)
                            
                            //The first + last names and the phone number (38 height)
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text(selectedContact[1] + " " + selectedContact[2])
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.bottom, 6)
                                Text(selectedContact[3])
                                    .foregroundColor(Color("Gray1"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                                withAnimation {
                                    selectedContact = ["", "", "", ""]
                                    selectedContactMethod = .reset
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
                
                //Manual entry selected, but nothing submitted yet (60 total - 40 height, 10 padding above and below)... 25 padding
                else if (selectedContactMethod == .enterManually && selectedContact[1].isEmpty) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            //The Icon for the submission form
                            Image(systemName: "person.fill.questionmark")
                                .foregroundColor(Color("Dark1"))
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.leading, 16)
                            TextField("Enter their name here...", text: $nameForRecipientEnteredManually)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .keyboardType(.alphabet)
                                .disableAutocorrection(true)
                                .frame(minWidth: screenWidth / 2, minHeight: 50, alignment: .center)
                                //.padding(.vertical, 20)
                                .padding(.horizontal)
                                
                                .onSubmit {
                                    
                                    selectedContact[1] = nameForRecipientEnteredManually
                                    //check if the code is valid
                                    
                                }
                                .submitLabel(.done)
                            
                            Button {
                                nameForRecipientEnteredManually = ""
                                selectedContact = ["", "", "", ""]
                                selectedContactMethod = .reset

                            } label: {
                                Image(systemName: "arrow.uturn.left")
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
                
                //Manual entry selected and submitted (60 total - 40 height, 10 padding above and below)... 25 padding
                else if (selectedContactMethod == .enterManually && !selectedContact[1].isEmpty) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        //MARK: CONTACT CARD (60 total - 40 height, 10 padding above and below)
                        HStack(alignment: .center, spacing: 0) {
                            
                            //The Circle + Letter for each contact (40 height)
                            ZStack(alignment: .center) {
                                Circle().frame(width: 40, height: 40)
                                    .foregroundColor(Color("ReferPurple"))
                                Text(selectedContact[1].prefix(1))
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                            }
                                .padding(.trailing, 16)
                            
                            //The first + last names and the phone number (38 height)
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text(selectedContact[1])
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.bottom, 3)
                                Text("Entered manually")
                                    .foregroundColor(Color("Gray1"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                                withAnimation {
                                    selectedContact = ["", "", "", ""]
                                    selectedContactMethod = .reset
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
                //.background(.blue)
            
            
            
            
            
            //MARK: BUTTONS (48)
            HStack(alignment: .center) {
                
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
                            .foregroundColor(selectedContact[1].isEmpty ? Color("Background") : .white)
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(selectedContact[1].isEmpty ? Color("Background") : .white)
                    }
                    .frame(width: 96, height: 48)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(selectedContact[1].isEmpty ? Color("Background") : Color("ReferPurple")))
                }.disabled(selectedContact[1].isEmpty)
                
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
        .sheet(isPresented: $isShowingContactsList) {
            isShowingContactsList = false
        } content: {
            ContactsView(isShowingContactsList: $isShowingContactsList, selectedContact: $selectedContact)
        }
        
        
    }
}

