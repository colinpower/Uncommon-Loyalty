//
//  CompanyDetailsModal.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/26/22.
//

import SwiftUI

struct CompanyDetailsModal: View {
    
    @Binding var isShowingCompanyDetails: Bool
    
    var options = ["OPTION 1", "OPTION 2", "OPTION 3"]
    
    var body: some View {
        
        TabView {
            Text(options[0]).background(.red)
            Text(options[1]).background(.red)
            Text(options[2]).background(.red)
            
//            RewardOptionPage(showingReviewProductScreen: $showingReviewProductScreen, showingPositiveReviewScreen: $showingPositiveReviewScreen, showingChooseYourRewardScreen: $showingChooseYourRewardScreen, rewardDescription: options[2])
        }.frame(height: UIScreen.main.bounds.height/2)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct CompanyDetailsModal_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsModal(isShowingCompanyDetails: .constant(true))
    }
}
