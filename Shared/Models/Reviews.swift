//
//  Reviews.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/13/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Reviews: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var companyID: String
    var email: String
    var historyID: String
    var orderID: String
    var photoID: String
    var reviewQuestions: [String]
    var reviewRating: Int
    var reviewResponses: [String]
    var reviewTitle: String
    var timestamp: Int
    var userID: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case email
        case historyID
        case orderID
        case photoID
        case reviewQuestions
        case reviewRating
        case reviewResponses
        case reviewTitle
        case timestamp
        case userID
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
