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
        VStack (alignment: .leading) {
            
            HStack {
                Image("sale")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 89, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.trailing, 12)
                Text("Convert your rewards points into a discount code!")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            .padding(.bottom, 8)
            Text("Use the slider to create your discount. Every 500 points is worth $5 in discounts.")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.6))
                .padding(.bottom, 36)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(String(availablePoints-Int(rewardsUsed)))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Points available")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.75))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(Int(rewardsUsed)))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Points used")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.75))
                }
            }
            
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
                }
            ).padding(.bottom, 48)
            
            HStack {
                Spacer()
                Text("$\(rewardsUsed/10, specifier: "%.0f")")
                    .font(.system(size: 80))
                    .foregroundColor(rewardsUsed == 0 ? .gray : .green)
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    //create discount code in Firebase
                    viewModel2.addCode(dollars: Int(rewardsUsed), pointsSpent: Int(rewardsUsed), userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2", companyName: companyName, companyID: companyID, email: "colinjpower1@gmail.com")
                    showingDiscountScreen.toggle()
                }) {
                    Text("Create discount code")
                        .foregroundColor(rewardsUsed == 0 ? Color.white.opacity(0.4) : Color.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 36).fill(rewardsUsed == 0 ? Color.green.opacity(0.4) : Color.green))
                }
                .disabled(rewardsUsed==0)
                Spacer()
            }
            Spacer()
            
        }.padding(.horizontal, 24)
            .padding(.top, 24)
        .navigationBarTitle("Create Discount", displayMode: .inline)
    }
}

struct CreateDiscountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateDiscountScreen(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", availablePoints: 100, showingDiscountScreen: .constant(true))
    }
}
