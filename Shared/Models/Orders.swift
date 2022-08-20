//
//  Orders.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/22/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Orders: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
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
    var shopifyOrderID: Int
    var status: String
    var timestamp: Int
    var totalPrice: Int
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
        case shopifyOrderID
        case status
        case timestamp
        case totalPrice
        case userID
    }
}
