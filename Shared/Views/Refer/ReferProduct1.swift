//
//  ReferProduct1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/20/22.
//

import SwiftUI

struct ReferProduct1: View {
    
    @Binding var isShowingReferExperience:Bool
    
    var itemObject: Items
    
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT AT TOP (SCREENWIDTH / 1.6 is height)
                DiscountCardForReferral(designSelection: [Color.white, Color.white, "engraved", "White"], companyImage: "Athleisure LA", companyName: "Athleisure LA", discountAmount: "$20", discountCode: "CUSTOM-CODE", recipientFirstName: "First", recipientLastName: "Last")
                    .frame(alignment: .center)
                    .padding(.vertical)
                    .padding(.top)
                
                //MARK: PROMPT (80)
                Text("Customize your friend's $20 gift!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding()
                
                Text("The discount card is blank right now. Let's make it pretty.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("Dark2"))
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom).padding(.bottom)
                
                
                
                Label {
                    Text("Takes 30 seconds")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "clock")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                NavigationLink {
                    ReferProduct2(isShowingReferExperience: $isShowingReferExperience, itemObject: itemObject)
                } label: {
                    BottomCapsuleButton(buttonText: "Continue", color: Color("ReferPurple"))
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct ReferProduct1_Previews: PreviewProvider {
//    static var previews: some View {
//        ReferProduct1()
//    }
//}
