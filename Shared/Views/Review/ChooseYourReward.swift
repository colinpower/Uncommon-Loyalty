//
//  ChooseYourReward.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct ChooseYourReward: View {
    
    @Binding var showingReviewProductScreen:Bool
    @Binding var showingPositiveReviewScreen:Bool
    
    @Binding var showingChooseYourRewardScreen:Bool
    
    var options = ["OPTION 1", "OPTION 2", "OPTION 3"]
    
    var body: some View {
        TabView {
            RewardOptionPage(showingReviewProductScreen: $showingReviewProductScreen, showingPositiveReviewScreen: $showingPositiveReviewScreen, showingChooseYourRewardScreen: $showingChooseYourRewardScreen, rewardDescription: options[0])
            RewardOptionPage(showingReviewProductScreen: $showingReviewProductScreen, showingPositiveReviewScreen: $showingPositiveReviewScreen, showingChooseYourRewardScreen: $showingChooseYourRewardScreen, rewardDescription: options[1])
            RewardOptionPage(showingReviewProductScreen: $showingReviewProductScreen, showingPositiveReviewScreen: $showingPositiveReviewScreen, showingChooseYourRewardScreen: $showingChooseYourRewardScreen, rewardDescription: options[2])
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        
    }
}

//struct ChooseYourReward_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseYourReward()
//    }
//}



struct RewardOptionPage: View {
    
    @Binding var showingReviewProductScreen:Bool
    @Binding var showingPositiveReviewScreen:Bool
    @Binding var showingChooseYourRewardScreen:Bool
    
    
    var rewardDescription: String
    
    var body: some View {
        
        VStack {
            
            Image("redshorts")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30)
                .padding()
                .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
                .padding(.vertical, 80)
                .background(Color("Background").opacity(0.1))
            VStack(alignment: .center, spacing: 8) {
                Text("Joggers 2.0")
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
                Text("Lululemon".uppercased())
                    .kerning(1.1)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Gray1"))
            }
            Spacer()
            
            Text("SHORT AMOUNT OF TEXT HERE DESCRIBING THE OPTION THAT YOU'RE CHOOSING")
            
            Spacer()
            

            Button {
               showingChooseYourRewardScreen = false
                showingPositiveReviewScreen = false
                showingReviewProductScreen = false
            } label: {
               HStack {
                   Spacer()
                   Text("Select")
                       .foregroundColor(Color.white)
                       .font(.system(size: 18))
                       .fontWeight(.semibold)
                       .padding(.vertical, 16)
                   Spacer()
               }.background(RoundedRectangle(cornerRadius: 36).fill(Color.blue))
                .padding(.horizontal)
                .padding(.horizontal)
           }
           Spacer()
        }
        .ignoresSafeArea()
    }
}
