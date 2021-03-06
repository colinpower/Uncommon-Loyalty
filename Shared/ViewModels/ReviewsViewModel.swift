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
    
    func addReview(companyID: String, reviewDetails: String, email: String, orderID: String, reviewRating: Int, reviewTitle: String, userID: String) {
        try db.collection("reviews-" + companyID)
            .addDocument(data: [
                "companyID": companyID,
                "details": reviewDetails,
                "email": email,
                "historyID": "",
                "orderID": orderID,
                "photoID": "",
                "rating": reviewRating,
                "timestamp": Int(round(Date().timeIntervalSince1970)),
                "title": reviewTitle,
                "userID": userID
            ])
    }
    
}
