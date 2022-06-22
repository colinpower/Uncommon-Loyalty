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
    var email: String
    var historyID: String
    var item: String
    var numberOfItemsInOrder: Int
    var orderID: String
    var pointsEarned: Int
    var reviewID: String
    var status: String
    var title: String
    var totalPrice: Int
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case discountAmount
        case discountCode
        case discountCodeID
        case email
        case historyID
        case item
        case numberOfItemsInOrder
        case orderID
        case pointsEarned
        case reviewID
        case status
        case title
        case totalPrice
        case userID
    }
}
