//
//  ReviewHistory.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/1/22.
//

import SwiftUI

struct ReviewHistory: View {
    
    @ObservedObject var ordersViewModel = OrdersViewModel()
    
    @State var showingReviewScreen: Bool = false
    
    var companyID: String
    var email: String
    //var orderID: String
    var userID: String
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(ordersViewModel.myOrders) { myOrder in
                    ReviewItem(companyID: myOrder.companyID, email: myOrder.email, orderID: myOrder.orderID, userID: myOrder.userID, reviewPoints: 0, title: myOrder.item_firstItemTitle, totalPrice: myOrder.totalPrice)
                }
            }
        
        }.padding(.top, 24)
        .padding(.horizontal, 24)
        .navigationBarTitle("", displayMode: .inline)
        .onAppear{
            //need to make a call to get the list of orders for this user, which are available to be reviewed
            self.ordersViewModel.listenForMyOrders(email: "colinjpower1@gmail.com", companyID: companyID)
        }
    }
}

struct ReviewItem: View {
    
    var companyID: String
    var email: String
    var orderID: String
    var userID: String
    var reviewPoints: Int
    var title: String
    var totalPrice: Int
//    var timestamp: Int
//    var hasReview: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Image("AthleisureSweatpants")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .clipped()
                .cornerRadius(10)
                .padding(.trailing, 12)
            VStack (alignment: .leading) {
                Text(title)
                Text(String(totalPrice) + " on Feb 23")
            }.font(.subheadline)
                .foregroundColor(.black.opacity(0.8))
                .padding(.trailing, 12)
            Spacer()
            if reviewPoints > 0 {
                VStack (alignment: .trailing) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.footnote)
                            .foregroundColor(.green)
                        Text("Reviewed")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(.green)
                    }.padding(.bottom, 2)
                    Text("+" + String(reviewPoints) + " points")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            } else {
                
                Text("need to submit a review!")
//                NavigationLink(
//                    destination: ReviewProductPreview(companyID: companyID, email: email, orderID: orderID, userID: userID),
//                    label: {
//                        Text("Add review")
//                            .font(.subheadline)
//                            .fontWeight(.regular)
//                            .foregroundColor(.blue)
//                        Image(systemName: "chevron.right")
//                            .font(.footnote)
//                            .foregroundColor(.blue)
//                    })
            }
                
        }
        
        
        
        
    }
}



struct ReviewHistory_Previews: PreviewProvider {
    static var previews: some View {
    ReviewHistory(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", userID: "temp userID string")
    }
}

//
//Label("Graph", systemImage: "chevron.down")
//    .foregroundColor(.black.opacity(0.8))
//    .labelStyle(.iconOnly)
//    .imageScale(.medium)
//    .rotationEffect(.degrees(showDetail ? -180 : 0))
