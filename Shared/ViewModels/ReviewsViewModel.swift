//
//  ReviewsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/21/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ReviewsViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to Reviews
    
    //@Published var myReviews = [Reviews]()
    
    @Published var snapshotOfOneReview = [Reviews]()
    
    @Published var snapshotOfReviewsForCompany = [Reviews]()
    
    
    //var dm = DataManager()
    
    //var listener_DiscountCodes: ListenerRegistration!
    
    private var db = Firestore.firestore()
    
    //    func listenForMyDiscountCodes(email: String, companyID: String) {
    //        self.myDiscountCodes = [DiscountCodes]()
    //
    //        self.dm.getMyDiscountCodes(email: email, companyID: companyID, onSuccess: { (discountcodes) in
    //            //if (self.newTickets.isEmpty) {
    //                self.myDiscountCodes = discountcodes
    //            print("this is the discount codes")
    //            print(self.myDiscountCodes)
    //        }, listener: { (listener) in
    //            self.listener_DiscountCodes = listener
    //        })
    //    }
    
    
    func getSnapshotOfReviewsForCompany(userID: String, companyID: String) {
        //print("this ONE function was called")
        
        print("this is the USER ID AND ITEM ID FOR reviews for company")
        
        db.collection("reviews")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfReviewsForCompany")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfReviewsForCompany = snapshot.documents.compactMap({ queryDocumentSnapshot -> Reviews? in
                    print("AT THE TRY STATEMENT FOR REFERRALS FOR ITEM")
                    print(try? queryDocumentSnapshot.data(as: Reviews.self))
                    return try? queryDocumentSnapshot.data(as: Reviews.self)
                })
            }
    }
    
    
    func getSnapshotOfOneReview(userID: String, itemID: String) {
        
        print("this is the USER ID AND ITEM ID FOR getSnapshotOfReferralsForItem")
        
        db.collection("reviews")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.itemID", isEqualTo: itemID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getSnapshotOfOneReview")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfOneReview = snapshot.documents.compactMap({ queryDocumentSnapshot -> Reviews? in
                    print("AT THE TRY STATEMENT FOR REVIEWS FOR ITEM")
                    print(try? queryDocumentSnapshot.data(as: Reviews.self))
                    return try? queryDocumentSnapshot.data(as: Reviews.self)
                })
            }
    }
    
    
    
    
    func addReview(
        firstName: String,
        lastName: String,
        itemName: String,
        companyName: String,
        companyLogo: String,
        profilePic: String,
        reviewRating: Int,
        questionsArray: [String],
        responsesArray: [String],
        allowedToDisplayProfilePic: Bool,
        allowedToDisplayName: Bool,
        companyID: String,
        email: String,
        itemID: String,
        orderID: String,
        reviewTitle: String,
        userID: String,
        rewardEarned: Int
    ) {
        
        let reviewTimestamp = Int(round(Date().timeIntervalSince1970))
        
        db.collection("reviews").document(userID + "-" + itemID)
            .setData([
                
                "card": [
                    "firstName": firstName,
                    "lastName": lastName,
                    "timestamp": reviewTimestamp,
                    "itemName": itemName,
                    "companyName": companyName,
                    "companyLogo": companyLogo,
                    "profilePic": profilePic,
                    "rating": reviewRating,
                    "title": responsesArray[2],
                    "body": responsesArray[1],
                    "allowedToDisplayProfilePic": allowedToDisplayProfilePic,
                    "allowedToDisplayName": allowedToDisplayName,
                ],
                "ids": [
                    "companyID": companyID,
                    "domain": "",           //need to get this later
                    "historyID": "",
                    "itemID": itemID,
                    "orderID": "",
                    "shopifyProductID": 0,
                    "reviewID": userID + "-" + itemID,
                    "userID": userID
                ],
                "metadata": [
                    "prompts": questionsArray,
                    "promptTypes": [""],
                    "responses": responsesArray
                ],
                "reward": [
                    "rewardAmount": 0,
                    "rewardEarned": rewardEarned,
                    "rewardPerPrompt": [0, 0],
                    "rewardType": "POINTS",
                ],
                "sender": [
                    "firstName": firstName,
                    "lastName": lastName,
                    "phone": "",
                    "email": email
                ]
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("IDK WHAT THE ERROR IS??")
                }
            }
    }
    
}

