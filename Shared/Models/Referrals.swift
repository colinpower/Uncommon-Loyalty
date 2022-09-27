//
//  Referrals.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Referrals: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var actualNewCustomerEmail: String
    var associatedOrderID: String
    var companyID: String
    var domain: String
    var historyID: String
    var itemID: String
    var prospectiveNewCustomerEmail: String
    var referralBonusPoints: Int
    var referralCode: String
    var referralDiscountAmount: Int
    var referralID: String
    var status: String
    var timestamp_Created: Int
    var timestamp_Used: Int
    var totalSpent: Int
    var userID: String
    var userSendingReferralEmail: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case actualNewCustomerEmail
        case associatedOrderID
        case companyID
        case domain
        case historyID
        case itemID
        case prospectiveNewCustomerEmail
        case referralBonusPoints
        case referralCode
        case referralDiscountAmount
        case referralID
        case status
        case timestamp_Created
        case timestamp_Used
        case totalSpent
        case userID
        case userSendingReferralEmail
    }
}



//class ReviewDetails {
//    var rating: Int
//    var question1: String
//
//    init(rating: Int, question1: String) {
//        self.rating = rating
//        self.question1 = question1
//    }
//}


//
//struct ReviewDetails: Codable {
//    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
//    var rating: Int
//    var question1: String
////    var question2: String
////    var question3: String
////    var answer1: String
////    var answer2: String
////    var answer3: String
//}
//
