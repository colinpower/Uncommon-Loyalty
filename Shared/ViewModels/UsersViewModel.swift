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
    
    @Published var currentUser: Users?
    
    
    @Published var oneUser = [Users]()
    
    @Published var snapshotOfOneUser = [Users]()
    
    @Published var oneVerificationResult = [VerificationResult]()
    
    var dm = DataManager()
    
    var listener_oneUser: ListenerRegistration!
    var listener_currentUser: ListenerRegistration!
    var listener_oneVerificationResult: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    func listenForCurrentUser(userID: String) {
        self.currentUser = Users(birthday: "", email: "", firstName: "", lastName: "", newUpdate: "", timestampJoined: -1, userID: "")
        
        self.dm.getCurrentUser(userID: userID, onSuccess: { (User) in
            
            //if (self.newTickets.isEmpty) {
            self.currentUser = User
            print("this is the one user")
            print(self.currentUser)
            
        }, listener: { (listener) in
            self.listener_currentUser = listener
        })
    }
    
    
    func listenForOneUser(userID: String) {
        self.oneUser = [Users]()
        
        self.dm.getOneUser(userID: userID, onSuccess: { (User) in
            //if (self.newTickets.isEmpty) {
            self.oneUser = User
            print("this is the one user")
            print(self.oneUser)
        }, listener: { (listener) in
            self.listener_oneUser = listener
        })
    }
    
    func updateUserID(email: String, firstName: String, lastName: String, phone: String, userID: String) {
        
        let timestampJoined = Int(round(Date().timeIntervalSince1970))
        
        db.collection("users").document(userID).setData([
            
            "birthday": "",
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "newUpdate": "",
            "timestampJoined": timestampJoined,
            "phone": "",
            "phoneIsVerified": false,
            "userID": userID,
            
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    func requestVerificationCode(phone: String, codeExpiresInSeconds: Int, userID: String, verificationID: String) {
        
        let timestampCreated = Int(round(Date().timeIntervalSince1970))
        let timestampExpires = timestampCreated + codeExpiresInSeconds
        
        db.collection("users").document(userID).collection("requestVerificationCode").document(verificationID).setData([
            
            "phone": phone,
            "timestampCreated": timestampCreated,
            "timestampExpires": timestampExpires,
            "timestampSubmitted": -1,
            "uncommonGeneratedCode": "",
            "userSubmittedCode": "",
            
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("triggering a code to be sent")
            }
        }
    }
    
    
    func submitVerificationCode(code: String, userID: String, verificationID: String) {
        
        let timestampSubmitted = Int(round(Date().timeIntervalSince1970))
        
        db.collection("users").document(userID).collection("requestVerificationCode").document(verificationID).updateData([
            
            "timestampSubmitted": timestampSubmitted,
            "userSubmittedCode": code
            
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("sending a verification code back to firebase")
            }
        }
    }
    
    
    func listenForPhoneVerification(userID: String, verificationID: String) {
        
        self.oneVerificationResult = [VerificationResult]()
        
        self.dm.getVerificationResult(userID: userID, verificationID: verificationID, onSuccess: { (Result) in
            //if (self.newTickets.isEmpty) {
            self.oneVerificationResult = Result
            print("this is the one result")
            print(self.oneVerificationResult)
        }, listener: { (listener) in
            self.listener_oneVerificationResult = listener
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

