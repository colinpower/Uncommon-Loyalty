//
//  RewardsProgram.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RewardsProgram: Identifiable, Codable {
    //means that whenever we map from a doc into a Ticket struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var card: RewardsProgramPersonalCardStruct
    var ids: RewardsProgramIDsStruct
    var owner: RewardsProgramOwnerStruct
    var status: RewardsProgramStatusStruct
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case card
        case ids
        case owner
        case status
    }
}


struct RewardsProgramPersonalCardStruct: Codable {
    
    var color: Int
    var companyName: String
    var discountCode: String
    var discountCodeCaseInsensitive: String
    var cardType: String                // PERSONAL-CARD-PERMANENT or PERSONAL-CARD-SINGLE-USE or (in the future) REFERRAL
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case color
        case companyName
        case discountCode
        case discountCodeCaseInsensitive
        case cardType
    }
}

struct RewardsProgramIDsStruct: Codable {
    
    var companyID: String
    var domain: String
    var personalCardDiscountID: String
    var rewardsProgramID: String
    var userID: String
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case domain
        case personalCardDiscountID
        case rewardsProgramID
        case userID
    }
}

struct RewardsProgramOwnerStruct: Codable {
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

struct RewardsProgramStatusStruct: Codable {
    var status: String                  //NEW, PENDING, CREATED, USED, DELETED
    var currentPointsBalance: Int
    var lifetimePoints: Int
    var numberOfReferralsSent: Int
    var numberOfReferralsCompleted: Int
    var numberOfReviews: Int
    var numberOf5StarReviews: Int
    var timestampCreated: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case status
        case currentPointsBalance
        case lifetimePoints
        case numberOfReferralsSent
        case numberOfReferralsCompleted
        case numberOfReviews
        case numberOf5StarReviews
        case timestampCreated
    }
}




