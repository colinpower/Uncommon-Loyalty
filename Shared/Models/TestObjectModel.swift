//
//  TestObjectModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift




//Button {
//    testObjectViewModel.addSnapshotOfItem(pointsPerDollarSpent: 500, pointsPerLevel: LevelsArray(gold: 5, silver: 10, platinum: 50, subLevelsArray: SubLevelsArray(gold: 100)))
//} label : {
//    Text("push button to post back to Firebase")
//        .font(.system(size: 14, weight: .bold))
//        .foregroundColor(.green)
//}

struct TestObjectModel: Identifiable, Codable {
    //means that whenever we map from a doc into a Order struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var pointsPerDollarSpent: Int
    var pointsPerLevel: LevelsArray


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case pointsPerDollarSpent
        case pointsPerLevel
       
    }
}


struct LevelsArray: Codable {
    var gold: Int
    var silver: Int
    var platinum: Int
    var subLevelsArray: SubLevelsArray


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case gold
        case silver
        case platinum
        case subLevelsArray
    }
}


struct SubLevelsArray: Codable {
    var gold: Int


    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case gold
    }

}




//struct LevelsArray {
//
//  let key: String
//  let name: String
//  let addedByUser: String
//  let ref: FIRDatabaseReference?
//  var completed: Bool
//
//  init(name: String, addedByUser: String, completed: Bool, key: String = "") {
//    self.key = key
//    self.name = name
//    self.addedByUser = addedByUser
//    self.completed = completed
//    self.ref = nil
//  }
//
//  init(snapshot: FIRDataSnapshot) {
//    key = snapshot.key
//    let snapshotValue = snapshot.value as! [String: AnyObject]
//    name = snapshotValue["name"] as! String
//    addedByUser = snapshotValue["addedByUser"] as! String
//    completed = snapshotValue["completed"] as! Bool
//    ref = snapshot.ref
//  }
//
//  func toAnyObject() -> Any {
//    return [
//      "name": name,
//      "addedByUser": addedByUser,
//      "completed": completed
//    ]
//  }
//
//}





