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
    
    func addReview(companyID: String, email: String, itemID: String, reviewRating: Int, questionsArray: [String], responsesArray: [String], reviewTitle: String, userID: String) {
        
        db.collection("reviews")
            .addDocument(data: [
                "companyID": companyID,
                "email": email,
                "historyID": "",
                "orderID": "",
                "itemID": itemID,
                "photoID": "",
                "reviewQuestions": questionsArray,
                "reviewRating": reviewRating,
                "reviewResponses": responsesArray,
                "reviewTitle": reviewTitle,
                "timestamp": Int(round(Date().timeIntervalSince1970)),
                "userID": userID
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("hasSeenFRE set to True")
                }

        }
    }
    
    
//    func addReview1(reviewQuestions: ReviewDetails, reviewResponses: [String]) {
//
//        db.collection("reviews")
//            .addDocument(data: [
//                "reviewQuestions": reviewQuestions,
//                "reviewResponses": reviewResponses,
//                "timestamp": Int(round(Date().timeIntervalSince1970))
//            ]) { err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("hasSeenFRE set to True")
//                }
//
//        }
//    }
}
