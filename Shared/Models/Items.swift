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
    var companyID: String
    var domain: String
    var email: String
    var itemID: String
    var name: String
    var orderID: String
    var price: String
    var quantity: Int
    var referred: Bool
    var reviewID: String
    var reviewRating: Int
    var shopifyItemID: Int
    var status: String
    var timestamp: Int
    var title: String
    var userID: String


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case domain
        case email
        case itemID
        case name
        case orderID
        case price
        case quantity
        case referred
        case reviewID
        case reviewRating
        case shopifyItemID
        case status
        case timestamp
        case title
        case userID
    }
}
