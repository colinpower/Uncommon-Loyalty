//
//  Reviews.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/13/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Reviews: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var card: ReviewsCardStruct
    var ids: ReviewsIDsStruct
    var metadata: ReviewsMetadataStruct
    var reward: ReviewsRewardStruct
    var sender: ReviewsSenderStruct

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case card
        case ids
        case metadata
        case reward
        case sender
    }
}


struct ReviewsCardStruct: Codable {
    
    var firstName: String
    var lastName: String
    var timestamp: Int
    var itemName: String
    var companyName: String
    var companyLogo: String
    var profilePic: String
    var rating: Int
    var title: String
    var body: String
    var allowedToDisplayProfilePic: Bool
    var allowedToDisplayName: Bool
        
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case firstName
        case lastName
        case timestamp
        case itemName
        case companyName
        case companyLogo
        case profilePic
        case rating
        case title
        case body
        case allowedToDisplayProfilePic
        case allowedToDisplayName
    }
}

struct ReviewsIDsStruct: Codable {
    
    var companyID: String
    var domain: String
    var historyID: String
    var itemID: String
    var orderID: String
    var shopifyProductID: Int
    var reviewID: String
    var userID: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case companyID
        case domain
        case historyID
        case itemID
        case orderID
        case shopifyProductID
        case reviewID
        case userID
        
    }
}

struct ReviewsMetadataStruct: Codable {
    
    var prompts: [String]
    var promptTypes: [String]
    var responses: [String]

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case prompts
        case promptTypes
        case responses
        
    }
}


struct ReviewsRewardStruct: Codable {
    
    var rewardAmount: Int       //the total rewards avaialable, like 250 points
    var rewardEarned: Int       //the rewards earned for this review, like 175 points
    var rewardPerPrompt: [Int]  //the rewards earned per question, like 25 / 250 points
    var rewardType: String      //the type of reward, POINTS or PERCENTAGE or DOLLAR-DISCOUNT or CASH

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case rewardAmount
        case rewardEarned
        case rewardPerPrompt
        case rewardType
        
    }
}


struct ReviewsSenderStruct: Codable {
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




