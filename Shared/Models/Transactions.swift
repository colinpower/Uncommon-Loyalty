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
    var discountAmount: String
    var discountCode: String
    var discountCodeID: String
    var domain: String
    var email: String
    var historyID: String
    var itemIDs: [String]
    var item_firstItemTitle: String
    var numberOfReviews: Int
    var orderID: String
    var orderStatusURL: String
    var pointsEarned: Int
    var referralCode: String
    var referralID: String
    var referredOrderID: String
    var shopifyOrderID: Int
    var timestamp: Int
    var totalPrice: Int
    var type: String
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case discountAmount
        case discountCode
        case discountCodeID
        case domain
        case email
        case historyID
        case itemIDs
        case item_firstItemTitle
        case numberOfReviews
        case orderID
        case orderStatusURL
        case pointsEarned
        case referralCode
        case referralID
        case referredOrderID
        case shopifyOrderID
        case timestamp
        case totalPrice
        case type
        case userID
    }
}
