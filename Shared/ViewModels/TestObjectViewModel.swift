//
//  TestObjectViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class TestObjectViewModel: ObservableObject, Identifiable {
    
    
    @Published var snapshotOfTestObject = [TestObjectModel]()
    
    //var dm = DataManager()
    
    
    private var db = Firestore.firestore()
    
    
    
    
    func getSnapshotOfItem() {
        //print("this ONE function was called")
        
        
        db.collection("object")
            //.whereField("itemID", isEqualTo: itemID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfTestObject")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfTestObject = snapshot.documents.compactMap({ queryDocumentSnapshot -> TestObjectModel? in
                    print("AT THE TRY STATEMENT FOR TEST OBJECT")
                    print(try? queryDocumentSnapshot.data(as: TestObjectModel.self))
                    return try? queryDocumentSnapshot.data(as: TestObjectModel.self)
                })
            }
        
    }
    
    
    func addSnapshotOfItem(pointsPerDollarSpent: Int, pointsPerLevel: LevelsArray) {
        
        db.collection("object").document()
            .setData([
                "pointsPerDollarSpent": pointsPerDollarSpent,
                "pointsPerLevel": [
                    "gold": pointsPerLevel.gold,
                    "silver": pointsPerLevel.silver,
                    "platinum": pointsPerLevel.platinum,
                    "subLevelsArray": [
                        "gold": pointsPerLevel.subLevelsArray.gold
                    ]
                ]
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("hasSeenFRE set to True")
                }
        }
    }
    
    
    
    
}
