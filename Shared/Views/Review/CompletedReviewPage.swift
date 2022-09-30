//
//  CompletedReviewPage.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/25/22.
//

import SwiftUI

struct CompletedReviewPage: View {
    
    @StateObject var reviewsViewModel = ReviewsViewModel()
    
    var itemID: String
    var userID: String
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            ReviewCard(
                reviewerProfilePic: reviewsViewModel.snapshotOfOneReview.first?.card.profilePic ?? "",
                reviewerFirstName: reviewsViewModel.snapshotOfOneReview.first?.card.firstName ?? "",
                reviewerLastName: reviewsViewModel.snapshotOfOneReview.first?.card.lastName ?? "",
                reviewTimestamp: reviewsViewModel.snapshotOfOneReview.first?.card.timestamp ?? 0,
                reviewRating: reviewsViewModel.snapshotOfOneReview.first?.card.rating ?? 0,
                reviewTitle: reviewsViewModel.snapshotOfOneReview.first?.card.title ?? "",
                reviewBody: reviewsViewModel.snapshotOfOneReview.first?.card.body ?? ""
            )
            .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white))
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .shadow(radius: 5)
            .padding()
            
            Spacer()
            
            Text("alkdfjalksdf")
            
            Text("alkdfjalksdf")
            
            Spacer()
            
        }
        .onAppear {
            
            reviewsViewModel.getSnapshotOfOneReview(userID: userID, itemID: itemID)
            
        }
    }
}

