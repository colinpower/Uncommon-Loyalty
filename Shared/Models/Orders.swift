//
//  Orders.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/22/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Orders: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    
    var ids: OrderIDsStruct
    var order: OrderOrderStruct
    var discountCode: OrderDiscountCodeStruct

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case ids
        case order
        case discountCode
    }
}


struct OrderIDsStruct: Codable {
    
    var companyID: String
    var discountCodeID: String
    var itemIDs: [String]
    var orderID: String
    var quantityPerItemID: [Int]
    var referralID: String
    var shopifyOrderID: Int
    var userID: String
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case companyID
        case discountCodeID
        case itemIDs
        case quantityPerItemID
        case orderID
        case referralID
        case shopifyOrderID
        case userID
    }
}

struct OrderOrderStruct: Codable {
    
    var companyName: String
    var domain: String
    var email: String
    var firstItemTitle: String
    var orderNumber: Int
    var orderStatusURL: String
    var phone: String
    var price: String
    var status: String
    var timestampCreated: Int
    var timestampUpdated: Int
    
    
    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        
        case companyName
        case domain
        case email
        case firstItemTitle
        case orderNumber
        case orderStatusURL
        case phone
        case price
        case status
        case timestampCreated
        case timestampUpdated
    }
}


struct OrderDiscountCodeStruct: Codable {
    
    var type: String
    var amount: String
    var code: String
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case amount
        case code
        
    }
    
}

struct OrderItemIDsStruct: Codable {
    
    var itemID: String
    var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        
        case itemID
        case quantity
        
    }
    
}







