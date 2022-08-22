//
//  Order_Item.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI

struct ItemForOrder: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    //Required variables to be passed
    var email: String
    var companyID: String
    var itemID: String
    
    @State var isShowingReviewScreen:Bool = false
    @State var isShowingReferScreen:Bool = false
    
    //use this variable to be passed back when the user submits a review but you don't know yet??
    @State var finishedReviewLocalLie:Bool = false
    
    //Listeners
    @StateObject var itemsViewModel = ItemsViewModel()
    
    
    var body: some View {
        VStack {
            ForEach(itemsViewModel.snapshotOfItem.prefix(1)) { item in
                Text(item.name)
                Text(item.itemID)
            }
            
            //Link to create a review
            Button {
                isShowingReviewScreen = true
            } label: {
                Text("show Review screen")
            }.fullScreenCover(isPresented: $isShowingReviewScreen) {
                ReviewProductCarousel1(showingReviewProductScreen: $isShowingReviewScreen, companyID: companyID, itemID: itemID, email: email, emailUID: viewModel.userID ?? "")
            }
            
            //Link to refer a friend
            Button {
                isShowingReferScreen = true
            } label: {
                Text("show Refer screen")
            }.fullScreenCover(isPresented: $isShowingReferScreen) {
                ReferAFriend(companyID: companyID, companyName: "Athleisure LA TEST", isReferCompanyActive: $isShowingReferScreen)
            }
            
            
        }.onAppear {
            self.itemsViewModel.getSnapshotOfItem(itemID: itemID)
        }
    }
}

struct ItemForOrder_Previews: PreviewProvider {
    static var previews: some View {
        ItemForOrder(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM", itemID: "Z3GBvz1xRYuHl8Tj6Z9j")
    }
}
