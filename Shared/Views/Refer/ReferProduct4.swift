//
//  ReferProduct4.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/21/22.
//

import SwiftUI


struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length)).replacingOccurrences(of: " ", with: "-")
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}





struct ReferProduct4: View {
    
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    @Binding var designSelection: [Any]
    
    var selectedOption: Int
        
    @Binding var selectedContact:[String]
        
    @State var isCodeAvailable:Bool = false
    
    @State var userSuggestedCode:String = ""
    
    
    @ObservedObject var referralsViewModel = ReferralsViewModel()
    
    @State var referralID = UUID().uuidString
    
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            
            DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode.isEmpty ? "CUSTOMIZE-ME" : userSuggestedCode, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2])
                .frame(alignment: .center)
                .padding(.vertical)
            
            
            //MARK: PROMPT (80)
            Text("Make a custom discount code for \(selectedContact[1])")
                .multilineTextAlignment(.leading)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .frame(alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            if userSuggestedCode.isEmpty {
                Text("\(selectedContact[1]) will enter this code at checkout.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                    .padding()
                    .padding(.bottom)
            } else {
                Group {
                    Text("\(selectedContact[1]) will enter ")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("Gray1")) +
                    Text(userSuggestedCode)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("Dark2")) +
                    Text(" at checkout.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                }
                .multilineTextAlignment(.leading)
                .padding()
                .padding(.bottom)
            }

            
            HStack(alignment: .center, spacing: 0) {
                
                TextField("Enter a code here (ex. \("UR-WELCOME!"))", text: $userSuggestedCode)
                    .limitInputLength(value: $userSuggestedCode, length: 12)
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
                
                
                if referralsViewModel.oneReferral.first?.status.status == "PENDING" {
                    
                    Text("Creating")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.trailing)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                        .font(.system(size: 16))
                    
                } else if referralsViewModel.oneReferral.first?.status.status == "CREATED" {
                    
                    Text("Created")
                        .foregroundColor(Color.green)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.trailing)
                    
                    
                } else if (referralsViewModel.oneReferral.first?.status.status == "UNAVAILABLE" && userSuggestedCode != "") {
                    
                    Text("Unavailable")
                        .foregroundColor(Color.red)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.trailing)
                    
                    Button {
                        isCodeAvailable = false
                        userSuggestedCode = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    
                } else {
                    
                    Button {

                        isCodeAvailable = false
                        userSuggestedCode = ""
                        
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                }
                
            }.padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 0))
            .padding(.horizontal)
            
            
            if userSuggestedCode.isEmpty || isCodeAvailable {
                
                //Empty view
                
            } else {
                
                Button {
                    
                    hideKeyboard()
                    
                    referralID = UUID().uuidString
                    
                    var handle = "performance-hoodie"
                    
                    let discountCode = userSuggestedCode.prefix(12).replacingOccurrences(of: " ", with: "-")
                    
                    referralsViewModel.addReferral(color: selectedOption, companyName: itemObject.order.companyName, customMessage: "", discountCode: discountCode, domain: itemObject.order.domain, handle: handle, itemTitle: itemObject.order.title, companyID: itemObject.ids.companyID, itemID: itemObject.ids.itemID, referralID: referralID, shopifyProductID: itemObject.ids.shopifyProductID, userID: itemObject.ids.userID, email: itemObject.order.email, rewardAmount: itemObject.referrals.rewardAmount, rewardType: itemObject.referrals.rewardType, recipientFirstName: selectedContact[1], recipientLastName: selectedContact[2], recipientPhone: selectedContact[3], offerRewardAmount: 20, status: "PENDING", usageLimit: 1)
                    
                    referralsViewModel.listenForOneReferralInProgress(userID: itemObject.ids.userID, companyID: itemObject.ids.companyID, referralID: referralID)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isCodeAvailable = true
                        
                    }
                    
                } label: {
                    
                    HStack {
                        Spacer()
                        Text("Create this code (if available)")
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
            
            if referralsViewModel.oneReferral.first?.status.status == "CREATED" {
                
                let discountCode = userSuggestedCode.prefix(12).replacingOccurrences(of: " ", with: "-")
                
                NavigationLink {
                    ReferProduct5(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject, designSelection: designSelection, selectedOption: selectedOption, selectedContact: $selectedContact, userSuggestedCode: discountCode, createdReferralID: referralID)
                } label: {
                    
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                    
                }
                
            } else {
                
                BottomCapsuleButton(buttonText: "Continue", color: Color("Gray3"))
                
            }
            
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {

            referralsViewModel.listenForOneReferralInProgress(userID: itemObject.ids.userID, companyID: itemObject.ids.companyID, referralID: referralID)
            
        }
        
    }
}
