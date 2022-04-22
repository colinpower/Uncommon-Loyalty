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
    var companyID: String
    var companyName: String
    var currentPointsBalance: Int
    var email: String
    var lifetimePoints: Int
    var numberOfReferrals: Int
    var numberOfReviews: Int
    var referralCode: String
    var status: String
    var userID: String
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case companyName
        case currentPointsBalance
        case email
        case lifetimePoints
        case numberOfReferrals
        case numberOfReviews
        case referralCode
        case status
        case userID
    }
}


