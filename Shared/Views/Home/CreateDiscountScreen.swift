//
//  CreateDiscountScreen.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 2/7/22.
//

import SwiftUI

struct CreateDiscountScreen: View {
    
    //note.. need to move NavigationView into the Home view instead of in the tabview.. this way the popup screen won't revert back to the home view
    //https://developer.apple.com/forums/thread/695596
    
    //Adding comment
    var companyID: String
    var companyName: String
    var availablePoints: Int
    
    @Binding var showingDiscountScreen: Bool
    
    @State var rewardsUsed: Double = 0
    
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    
    var body: some View {
        VStack (alignment: .center) {
            
            VStack(alignment: .center) {
                Text("Convert Points")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                Text(String(availablePoints-Int(rewardsUsed)) + " POINTS AVAILABLE")
                    .font(.footnote)
                    .foregroundColor(.gray)
//                Text("CONVERT POINTS INTO A DISCOUNT CODE")
//                    .font(.footnote)
//                    .foregroundColor(.gray)
            }
            Spacer()
            Spacer()
            
            VStack (alignment: .center) {
                Text("$\(rewardsUsed/10, specifier: "%.0f")")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .padding(.bottom, 12)
            }
            
            Spacer()
            Spacer()
            
            
            
            //MARK: SLIDER
            
            Slider(
                value: $rewardsUsed,
                in: 0...Double(availablePoints),
                step: 50,
                onEditingChanged: { (_) in
                    // nil here
                },
                minimumValueLabel: Text(""),
                maximumValueLabel: Text(""),
                label: {
                    Text("")
                })
                
            
            
            Spacer()
             
            Button(action: {
                //create discount code in Firebase
                viewModel2.addCode(dollars: Int(rewardsUsed), pointsSpent: Int(rewardsUsed), userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2", companyName: companyName, companyID: companyID, email: "colinjpower1@gmail.com")
                showingDiscountScreen.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("Convert points")
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(.vertical, 12)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 24).fill(.blue))
                .padding(.horizontal, 24)
            }
            .disabled(rewardsUsed==0)
            
        }.padding(.horizontal, 12)
            .padding(.vertical, 24)
        //.navigationBarTitle("Create Discount", displayMode: .inline)
    }
}

struct CreateDiscountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateDiscountScreen(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", availablePoints: 100, showingDiscountScreen: .constant(true))
    }
}
