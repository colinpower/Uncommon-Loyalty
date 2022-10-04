//
//  DiscountCardSetup2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 10/3/22.
//

import SwiftUI


struct SearchedCodesObject: Identifiable {
    
    var id = UUID()
    
    var code: String
    var discountID: String
}


struct DiscountCardSetup2: View {
    
    var rewardsProgram: RewardsProgram
    
    @Binding var activeLoyaltySheet:ActiveLoyaltySheet?
    
    @Binding var designSelection: [Any]          //cardColor, textColor, type (engraved or normal), title
    
    @State var selectedOption: Int
    
    @State var isSearching:Bool = false
    
    @State var userSuggestedCode:String = ""
    
    @ObservedObject var discountCodesViewModel = DiscountCodesViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
    
    @State var discountID = UUID().uuidString
    
    @State var codeHasBeenSearchedBefore:Bool = false
    
    @State var searchedCodes:[SearchedCodesObject] = []
    
    @State var listOfCodes:[String] = []
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
            
            DiscountCardForReferral(designSelection: designSelection, companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: userSuggestedCode.isEmpty ? "CUSTOMIZE-ME" : userSuggestedCode, recipientFirstName: rewardsProgram.owner.firstName, recipientLastName: rewardsProgram.owner.lastName)
                .frame(alignment: .center)
                .padding(.vertical)
            
            
            //MARK: PROMPT (80)
            Text("Make a permanent, custom discount code (only for you!)")
                .multilineTextAlignment(.leading)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .frame(alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            if userSuggestedCode.isEmpty {
                Text("You'll enter your personal discount code when checking out at \(rewardsProgram.card.companyName). You can load and reload this card by redeeming rewards in the Uncommon app.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                    .padding()
                    .padding(.bottom)
            } else {
                Group {
                    Text("You'll enter ")
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
                
                TextField("Enter a code here (ex. \(rewardsProgram.owner.firstName)-123)", text: $userSuggestedCode)
                    .limitInputLength(value: $userSuggestedCode, length: 12)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .frame(minWidth: UIScreen.main.bounds.width / 5 * 2, minHeight: 50, alignment: .center)
                    .padding(.leading)
                    .onSubmit {
                        
                        //check if the code is valid
                        hideKeyboard()

                    }
                    .submitLabel(.done)
                
                Spacer()
                
                if (discountCodesViewModel.oneDiscountCodeInProgress.first?.status.status == "PENDING" && isSearching) {
                    
                    Text("Checking")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.trailing)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                        .font(.system(size: 15))
                    
                } else if (discountCodesViewModel.oneDiscountCodeInProgress.first?.status.status == "CREATED-PendingUserApproval" && isSearching) {
                    
                    Text("Available")
                        .foregroundColor(Color.green)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.trailing)
                    
                    Button {
                        isSearching = false
                        userSuggestedCode = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    
                    
                } else if (discountCodesViewModel.oneDiscountCodeInProgress.first?.status.status == "UNAVAILABLE" && isSearching) {
                    
                    Text("Unavailable")
                        .foregroundColor(Color.red)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.trailing)
                    
                    Button {
                        isSearching = false
                        userSuggestedCode = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    
                } else {
                    
                    Button {

                        isSearching = false
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
            .frame(width: UIScreen.main.bounds.width)
            
                        
            if !userSuggestedCode.isEmpty && !isSearching {
                
                Button {
                    
                    print("current state of the codes")
                    print(searchedCodes)
                    print("current list of codes")
                    print(listOfCodes)
                    print("current suggested code")
                    print(userSuggestedCode)
                    
                    
                    hideKeyboard()
                    
                    isSearching = true
                    
                    if(listOfCodes.contains(userSuggestedCode)) {
                        
                        for item in searchedCodes {
                            
                            if (item.code == userSuggestedCode) {
                                
                                discountID = item.discountID
                                
                                discountCodesViewModel.listenForOneDiscountCodeInProgress(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID, discountID: discountID)
                                
                                break
                            }
                        }
                        
                    } else {
                        
                        discountID = UUID().uuidString
                        
                        listOfCodes.append(userSuggestedCode)
                        
                        searchedCodes.append(SearchedCodesObject(code: userSuggestedCode, discountID: discountID))
                        
                        let discountCode = userSuggestedCode.prefix(12).replacingOccurrences(of: " ", with: "-")
                        
                        discountCodesViewModel.addCode(color: selectedOption, companyID: rewardsProgram.ids.companyID, companyName: rewardsProgram.card.companyName, discountCode: userSuggestedCode, cardType: "PERSONAL-CARD-PERMANENT", discountID: discountID, domain: rewardsProgram.ids.domain, firstName: rewardsProgram.owner.firstName, lastName: rewardsProgram.owner.lastName, phone: rewardsProgram.owner.phone, email: rewardsProgram.owner.email, expirationTimestamp: -1, minimumSpendRequired: 0, rewardAmount: 0, rewardType: "DOLLAR-DISCOUNT", usageLimit: 1, pointsSpent: 0, userID: rewardsProgram.ids.userID)
                        
                        discountCodesViewModel.listenForOneDiscountCodeInProgress(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID, discountID: discountID)
                        
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
                
            } else {
                
                //
                
            }
            
            
            
            Spacer()
            
            if discountCodesViewModel.oneDiscountCodeInProgress.first?.status.status == "CREATED-PendingUserApproval" {
                
                Button {
                    
                    let graphqlIDVar = discountCodesViewModel.oneDiscountCodeInProgress.first?.ids.graphQLID
                    
                    rewardsProgramViewModel.updateLoyaltyProgramPersonalCard(loyaltyProgramID: rewardsProgram.ids.rewardsProgramID, color: selectedOption, discountCode: userSuggestedCode, discountID: discountID, graphqlID: graphqlIDVar ?? "")
                    
                    discountCodesViewModel.updateDiscountToAcceptPersonalCode(discountID: discountID)
                    
                    activeLoyaltySheet = nil
                    
                } label: {
                    
                    BottomCapsuleButton(buttonText: "Finish", color: Color("ReferPurple"))
                    
                }
                
            } else {
                
                BottomCapsuleButton(buttonText: "Done", color: Color("Gray3"))
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {

            discountCodesViewModel.listenForOneDiscountCodeInProgress(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID, discountID: discountID)
            
        }
        
        
        
        
        
    }
    
}
