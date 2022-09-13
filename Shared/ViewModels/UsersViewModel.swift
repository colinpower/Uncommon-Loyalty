//
//  UsersViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UsersViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var oneUser = [Users]()
    
    @Published var snapshotOfOneUser = [Users]()
    
    var dm = DataManager()
    
    var listener_oneUser: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    func listenForOneUser(email: String) {
        self.oneUser = [Users]()
        
        self.dm.getOneUser(email: email, onSuccess: { (User) in
            //if (self.newTickets.isEmpty) {
            self.oneUser = User
            print("this is the one user")
            print(self.oneUser)
        }, listener: { (listener) in
            self.listener_oneUser = listener
        })
    }
}
    
//func snapshotOfOrder(orderID: String) {
//    //print("this ONE function was called")
//    
//    //var ordersSnapshot = [Orders]()
//    
//    db.collection("user")
//        .whereField("orderID", isEqualTo: orderID)
//        .getDocuments { (snapshot, error) in
//            
//            guard let snapshot = snapshot, error == nil else {
//                //handle error
//                print("found error in snapshotOfOrder")
//                return
//            }
//            print("Number of documents: \(snapshot.documents.count ?? -1)")
//            
//            self.snapshotOfOrder = snapshot.documents.compactMap({ queryDocumentSnapshot -> Orders? in
//                print("AT THE TRY STATEMENT")
//                print(try? queryDocumentSnapshot.data(as: Orders.self))
//                return try? queryDocumentSnapshot.data(as: Orders.self)
//            })
//        }
//    
//}

