//
//  DiscountCodes.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DiscountCodes: Identifiable, Codable {
    //means that whenever we map from a doc into a Ticket struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var code: String
    var companyID: String
    var companyName: String
    var discountID: String
    var dollarAmount: Int
    var domain: String
    var email: String
    var firstNameID: String
    var graphqlID: String
    var historyID: String
    var minimumSpendRequired: Int
    var pointsSpent: Int
    var status: String
    var timestamp_Created: Int
    var timestamp_Active: Int
    var timestamp_Used: Int
    var usageLimit: Int
    var usedOnOrderID: String
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case code
        case companyName
        case companyID
        case discountID
        case dollarAmount
        case domain
        case email
        case firstNameID
        case graphqlID
        case historyID
        case minimumSpendRequired
        case pointsSpent
        case status
        case timestamp_Created
        case timestamp_Active
        case timestamp_Used
        case usageLimit
        case usedOnOrderID
        case userID
    }

    
    
}
