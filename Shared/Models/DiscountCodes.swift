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
    var companyName: String
    var companyID: String
    var dollarAmount: Int
    var email: String
    var minimumSpendRequired: Int
    var pointsSpent: Int
    var status: String
    var timestampCreated: Int
    var timestampUsed: Int
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case code
        case companyName
        case companyID
        case dollarAmount
        case email
        case minimumSpendRequired
        case pointsSpent
        case status
        case timestampCreated
        case timestampUsed
        case userID
    }
}
