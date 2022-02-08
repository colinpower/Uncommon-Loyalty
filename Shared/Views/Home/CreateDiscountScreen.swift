//
//  CreateDiscountScreen.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 2/7/22.
//

import SwiftUI

struct CreateDiscountScreen: View {
    
    @Binding var showingDiscountScreen: Bool
    var company: String
    var availablePoints: Int
    
    @State var rewardsUsed: Double = 0
    
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Create Discount Code").font(.title).padding(.bottom)
            Text(String(availablePoints) + " AVAILABLE POINTS")
                .font(.body)
                .foregroundColor(.gray)
            Spacer()
            Text("$\(rewardsUsed/10, specifier: "%.0f")").font(.largeTitle)
            
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
            )
            .padding(.horizontal)
            
            
            Spacer()
            Button(action: {
                //create discount code in Firebase
                viewModel2.addCode(dollars: Int(rewardsUsed), user: "colinjpower1@gmail.com", company: company)
                showingDiscountScreen.toggle()
            }) {
                Text("Create discount code")
                    .foregroundColor(rewardsUsed == 0 ? Color.white.opacity(0.4) : Color.white)
                    .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 36).fill(Color.blue))
            }
            .disabled(rewardsUsed==0)
            Spacer()
            
        }
    }
}

//struct CreateDiscountScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateDiscountScreen()
//    }
//}
