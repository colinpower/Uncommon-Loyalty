//
//  Transactions.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Transactions: Identifiable, Codable {
    //means that whenever we map from a doc into a Ticket struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var companyID: String
    var description: String
    var discountAmount: Int
    var discountCode: String
    var email: String
    var orderID: String
    var pointsEarnedOrSpent: Int
    var price: Int
    var reviewID: String
    var timestamp: Int
    var type: String
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case description
        case discountAmount
        case discountCode
        case email
        case orderID
        case pointsEarnedOrSpent
        case price
        case reviewID
        case timestamp
        case type
        case userID
    }
}
