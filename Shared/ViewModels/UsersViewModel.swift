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
    
//    func createUser(email: String, userID: String) {
//        db.collection("users")
//            .addDocument(data: [
//                "birthday": "",
//                "email": email,
//                "firstName": "",
//                "lastName": "",
//                "newUpdate": "",
//                "timestampJoined": Int(round(Date().timeIntervalSince1970)),
//                "userID": userID
//            ]) { err in
//                    if let err = err {
//                        print("Error updating document: \(err)")
//                    } else {
//                        print("hasSeenFRE set to True")
//                    }
//
//                }
//    }

