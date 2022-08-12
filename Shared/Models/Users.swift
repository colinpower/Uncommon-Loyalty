//
//  Users.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Users: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var birthday: String
    var email: String
    var firstName: String
    var lastName: String
    var newUpdate: String
    var timestampJoined: Int
    var userID: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case birthday
        case email
        case firstName
        case lastName
        case newUpdate
        case timestampJoined
        case userID
    }
}
