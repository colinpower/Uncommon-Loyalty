//
//  Items.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/20/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Items: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var ids: ItemsIDsStruct
    var referrals: ItemsReferralsStruct
    var review: ItemsReviewStruct
    var order: ItemsOrderStruct
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case ids
        case referrals
        case review
        case order
        
    }
}


struct ItemsIDsStruct: Codable {
    var companyID: String
    var itemID: String
    var orderID: String
    var referralIDs: [String]
    var reviewID: String
    var shopifyItemID: Int
    var shopifyProductID: Int
    var userID: String


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case itemID
        case orderID
        case referralIDs
        case reviewID
        case shopifyItemID
        case shopifyProductID
        case userID
    }
}


struct ItemsReferralsStruct: Codable {
    var count: Int
    var rewardType: String
    var rewardAmount: Int
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case count
        case rewardType
        case rewardAmount
    }
}

struct ItemsReviewStruct: Codable {
    var rating: Int
    var rewardType: String
    var rewardAmount: Int
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case rating
        case rewardType
        case rewardAmount
    }
}


struct ItemsOrderStruct: Codable {
    
    var companyName: String
    var domain: String
    var email: String
    var handle: String
    var imageURL: String
    var name: String
    var orderNumber: Int
    var orderStatusURL: String
    var phone: String
    var price: String
    var quantity: Int
    var returnPolicyInDays: Int
    var status: String
    var timestamp: Int
    var title: String
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case companyName
        case domain
        case email
        case handle
        case imageURL
        case name
        case orderNumber
        case orderStatusURL
        case phone
        case price
        case quantity
        case returnPolicyInDays
        case status
        case timestamp
        case title
        
    }
}



