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
    var companyID: String
    var companyName: String
    var joiningBonus: Int
    var joiningBonusType: String
    var pointsForGold: Int
    var pointsPerDollarOfDiscount: Int
    var pointsPerDollarSpent: Int
    var pointsPerReferral: Int
    var pointsPerReview: Int
    var timestampJoined: Int
    var website: String
    
    //need to add RewardsProgramReference?? so I can query this specific loyalty program?

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case companyName
        case joiningBonus
        case joiningBonusType
        case pointsForGold
        case pointsPerDollarOfDiscount
        case pointsPerDollarSpent
        case pointsPerReferral
        case pointsPerReview
        case timestampJoined
        case website
    }
}