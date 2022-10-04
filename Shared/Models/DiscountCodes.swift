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
    var card: DiscountsCardStruct
    var ids: DiscountsIDsStruct
    var owner: DiscountsOwnerStruct
    var reward: DiscountsRewardStruct
    var status: DiscountsStatusStruct

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case card
        case ids
        case owner
        case reward
        case status
    }
}

struct DiscountsCardStruct: Codable {
    
    var cardType: String                // PERSONAL-CARD-PERMANENT or PERSONAL-CARD-SINGLE-USE or (in the future) REFERRAL
    var color: Int
    var companyName: String
    var customMessage: String
    var discountCode: String
    var discountCodeCaseInsensitive: String
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case cardType
        case color
        case companyName
        case customMessage
        case discountCode
        case discountCodeCaseInsensitive
    }
}

struct DiscountsIDsStruct: Codable {
    var companyID: String
    var discountID: String
    var domain: String
    var graphQLID: String
    var usedOnOrderID: String
    var userID: String
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case discountID
        case domain
        case graphQLID
        case usedOnOrderID
        case userID
    }
}

struct DiscountsOwnerStruct: Codable {
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case phone
        case email
    }
}

struct DiscountsRewardStruct: Codable {
    var expirationTimestamp: Int
    var minimumSpendRequired: Int
    var rewardAmount: Int
    var rewardType: String
    var usageLimit: Int
    var pointsSpent: Int
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case expirationTimestamp
        case minimumSpendRequired
        case rewardAmount
        case rewardType
        case usageLimit
        case pointsSpent
    }
}

struct DiscountsStatusStruct: Codable {
    var status: String                  //PENDING, CREATED, USED, DELETED
    var failedToBeCreated: Bool         //IF TRUE, SHOULD BE DELETED
    var timestampCreated: Int
    var timestampUsed: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case status
        case failedToBeCreated
        case timestampCreated
        case timestampUsed
    }
}
