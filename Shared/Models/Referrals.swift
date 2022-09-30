//
//  Referrals.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Referrals: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var card: ReferralsCardStruct
    var ids: ReferralsIDsStruct
    var offer: ReferralsOfferStruct
    var recipient: ReferralsRecipientStruct
    var reward: ReferralsRewardStruct
    var sender: ReferralsSenderStruct
    var status: ReferralsStatusStruct
   
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case ids
        case offer
        case recipient
        case card
        case reward
        case sender
        case status
    }
}


struct ReferralsCardStruct: Codable {
    
    var color: Int
    var companyName: String
    var customMessage: String
    var discountCode: String
    var itemImage: String
    var itemTitle: String
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case color
        case companyName
        case customMessage
        case discountCode
        case itemImage
        case itemTitle
    }
}



struct ReferralsIDsStruct: Codable {
    var companyID: String
    var domain: String
    var graphQLID: String
    var historyID: String
    var itemID: String
    var referralID: String
    var reviewID: String
    var usedOnOrderID: String
    var userID: String


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case domain
        case graphQLID
        case historyID
        case itemID
        case referralID
        case reviewID
        case usedOnOrderID
        case userID
        
    }
}


struct ReferralsOfferStruct: Codable {
    var expirationTimestamp: Int
    var forNewCustomersOnly: Bool
    var minimumSpendRequired: Int
    var rewardAmount: Int
    var rewardType: String
    var singleUse: Bool
    
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case expirationTimestamp
        case forNewCustomersOnly
        case minimumSpendRequired
        case rewardAmount
        case rewardType
        case singleUse
    }
}


struct ReferralsRecipientStruct: Codable {
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





struct ReferralsRewardStruct: Codable {
    var rewardAmount: Int
    var rewardType: String
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case rewardAmount
        case rewardType
    }
}

struct ReferralsSenderStruct: Codable {
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


struct ReferralsStatusStruct: Codable {
    var status: String
    var timestampCreated: Int
    var timestampUsed: Int
    var timeWaitingForReturnInDays: Int
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case status
        case timestampCreated
        case timestampUsed
        case timeWaitingForReturnInDays
    }
}
