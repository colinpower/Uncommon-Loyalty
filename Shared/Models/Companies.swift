//
//  Companies.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/11/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Companies: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var categoryShortDescription: String
    var companyID: String
    var companyName: String
    var image: String
    var joiningBonus: Int
    var joiningBonusType: String
    var referralOfferExistingCustomer: ReferralOfferExistingCustomerStruct
    var referralOfferNewCustomer: ReferralOfferNewCustomerStruct
    var referralReward: ReferralRewardStruct
    var reviewReward: ReviewRewardStruct
    var timestampJoined: Int
    var website: String
    
    //return policy, standard reward for review, standard reward for referral, standard offer for referral
    //use: returnPolicyInDays
    
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case categoryShortDescription
        case companyID
        case companyName
        case image
        case joiningBonus
        case joiningBonusType
        case referralOfferExistingCustomer
        case referralOfferNewCustomer
        case referralReward
        case reviewReward
        case timestampJoined
        case website
    }
}


struct ReferralOfferExistingCustomerStruct: Codable {
    
    var amount: Int
    var minSpend: Int
    var timeTilExpiration: Int
    var type: String                        //FIXED, PERCENTAGE, CASH, POINTS
    var usageLimit: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case amount
        case minSpend
        case timeTilExpiration
        case type
        case usageLimit
    }
}

struct ReferralOfferNewCustomerStruct: Codable {
    
    var amount: Int
    var minSpend: Int
    var timeTilExpiration: Int
    var type: String                        //FIXED, PERCENTAGE, CASH, POINTS
    var usageLimit: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case amount
        case minSpend
        case timeTilExpiration
        case type
        case usageLimit
    }
}

struct ReferralRewardStruct: Codable {
    
    var amount: Int
    var minSpend: Int
    var timeTilExpiration: Int
    var type: String                        //FIXED, PERCENTAGE, CASH, POINTS
    var usageLimit: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case amount
        case minSpend
        case timeTilExpiration
        case type
        case usageLimit
    }
}

struct ReviewRewardStruct: Codable {
    
    var amount: Int
    var minSpend: Int
    var timeTilExpiration: Int
    var type: String                        //FIXED, PERCENTAGE, CASH, POINTS, NONE
    var usageLimit: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case amount
        case minSpend
        case timeTilExpiration
        case type
        case usageLimit
    }
}



struct CompanyProduct: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var URL: String
    var handle: String
    var imageURL: String
    var productID: String
    var referralOfferExistingCustomer: ReferralOfferExistingCustomerStruct
    var referralOfferNewCustomer: ReferralOfferNewCustomerStruct
    var referralReward: ReferralRewardStruct
    var reviewReward: ReviewRewardStruct

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case URL
        case handle
        case imageURL
        case productID
        case referralOfferExistingCustomer
        case referralOfferNewCustomer
        case referralReward
        case reviewReward
    }
}
