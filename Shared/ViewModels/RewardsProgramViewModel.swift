//
//  RewardsProgramsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class RewardsProgramViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var myRewardsPrograms = [RewardsProgram]()
    @Published var oneRewardsProgram = [RewardsProgram]()
    
    @Published var snapshotOfMyRewardsPrograms = [RewardsProgram]()
    
    var dm = DataManager()
    
    var listener1: ListenerRegistration!
    var listener_OneRewardsProgram: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    // MARK: Queries for the HOME views
    //Get all tickets that I am able to answer
    
    func listenForMyRewardsPrograms(userID: String) {
        self.myRewardsPrograms = [RewardsProgram]()
        
        self.dm.getMyRewardsPrograms(userID: userID, onSuccess: { (RewardsPrograms) in
            //if (self.newTickets.isEmpty) {
                self.myRewardsPrograms = RewardsPrograms
        }, listener: { (listener1) in
            self.listener1 = listener1
        })
    }
    
    func getSnapshotOfMyRewardsPrograms(userID: String) {
    
        //var ordersSnapshot = [Orders]()
    
        db.collection("loyaltyprograms")
            .whereField("ids.userID", isEqualTo: userID)
            .order(by: "card.companyName", descending: false)
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfMyLoyaltyPrograms")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.snapshotOfMyRewardsPrograms = snapshot.documents.compactMap({ queryDocumentSnapshot -> RewardsProgram? in
                    print("AT THE TRY STATEMENT for snapshotOfMyRewardsPrograms")
                    print(try? queryDocumentSnapshot.data(as: RewardsProgram.self) as Any)
                    return try? queryDocumentSnapshot.data(as: RewardsProgram.self)
                })
            }
    
    }
    
    
    
    
    func listenForOneRewardsProgram(userID: String, companyID: String) {
        self.oneRewardsProgram = [RewardsProgram]()
        
        self.dm.getOneRewardsProgram(userID: userID, companyID: companyID, onSuccess: { (RewardsProgram) in
            
            self.oneRewardsProgram = RewardsProgram
            
            print("this is the rewards program")
            print(self.oneRewardsProgram)
            
        }, listener: { (listener) in
            self.listener_OneRewardsProgram = listener
        })
    }
    
    
//    func addLoyaltyProgram(companyID: String, companyName: String, currentPointsBalance: Int, email: String, lifetimePoints: Int, referralCode: String, status: String, userID: String) {
//
//        //try <- I eliminated the try / catch thing.. this seems like it should work just fine?
//        db.collection("loyaltyprograms").document(userID + "-" + companyID)
//            .setData([
//                "companyID": companyID,
//                "companyName": companyName,
//                "currentPointsBalance": currentPointsBalance,
//                "email": email,
//                "lifetimePoints": lifetimePoints,
//                "numberOfReferrals": 0,
//                "numberOfReviews": 0,
//                "referralCode": "",
//                "status": status,
//                "timestampJoined": Int(round(Date().timeIntervalSince1970)),
//                "userID": userID
//            ]) { err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("hasSeenFRE set to True")
//                }
//
//        }
//    }
    
    func updateLoyaltyPointsForReason(loyaltyProgramID: String, changeInPoints: Int, reason: String) {
        
        //try <- I eliminated the try / catch thing.. this seems like it should work just fine?
        
//        print("trying to update the loyalty program to deduct points")
//        print(loyaltyProgramID)
//        print(userID)
//        print(companyID)
//        print(changeInPoints)
        
        db.collection("loyaltyprograms").document(loyaltyProgramID)
            .updateData([
                "status.currentPointsBalance": FieldValue.increment(Int64(changeInPoints))
            ]);
    }
    
}
