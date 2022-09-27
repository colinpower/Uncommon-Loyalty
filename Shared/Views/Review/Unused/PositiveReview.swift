//
//  PositiveReview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct PositiveReview: View {
    
    @Binding var showingReviewProductScreen:Bool
    //@Binding var showingPositiveReviewScreen:Bool
    
    @State var showingChooseYourRewardScreen:Bool = false
    
    var body: some View {
        
        VStack {
            Text("Congrats! Etc...")
            
            
            Button {
                //showingPositiveReviewScreen = false
                showingReviewProductScreen = false
            } label: {
                Text("Tap to dismiss all")
            }
            Spacer()
            
            Button {
                showingChooseYourRewardScreen = true
            } label: {
                Text("CHOOSE YOUR REWARD!")
            }
            
            Spacer()
            
        }
//        .fullScreenCover(isPresented: $showingChooseYourRewardScreen, content: {
//            ChooseYourReward(showingReviewProductScreen: $showingReviewProductScreen, showingPositiveReviewScreen: $showingPositiveReviewScreen, showingChooseYourRewardScreen: $showingChooseYourRewardScreen)
//        })
    }
}

struct PositiveReview_Previews: PreviewProvider {
    static var previews: some View {
        PositiveReview(showingReviewProductScreen: .constant(true))   //, showingPositiveReviewScreen: .constant(true))
    }
}
