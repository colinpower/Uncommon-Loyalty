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
    
    var dm = DataManager()
    
    
    var listener1: ListenerRegistration!
    var listener2: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    // MARK: Queries for the HOME views
    //Get all tickets that I am able to answer
    
    func listenForMyRewardsPrograms(email: String) {
        self.myRewardsPrograms = [RewardsProgram]()
        
        self.dm.getMyRewardsPrograms(email: email, onSuccess: { (RewardsPrograms) in
            //if (self.newTickets.isEmpty) {
                self.myRewardsPrograms = RewardsPrograms
        }, listener: { (listener1) in
            self.listener1 = listener1
        })
    }
    
    func listenForOneRewardsProgram(email: String, companyID: String) {
        self.oneRewardsProgram = [RewardsProgram]()
        
        self.dm.getOneRewardsProgram(email: email, companyID: companyID, onSuccess: { (RewardsProgram) in
            //if (self.newTickets.isEmpty) {
                self.oneRewardsProgram = RewardsProgram
            print("this is the rewards program")
            print(self.oneRewardsProgram)
        }, listener: { (listener2) in
            self.listener2 = listener2
        })
    }
    
    
    func addLoyaltyProgram(companyID: String, companyName: String, currentPointsBalance: Int, email: String, lifetimePoints: Int, referralCode: String, status: String, userID: String) {
        
        //try <- I eliminated the try / catch thing.. this seems like it should work just fine?
        db.collection("loyaltyprograms").document(userID + "-" + companyID)
            .setData([
                "companyID": companyID,
                "companyName": companyName,
                "currentPointsBalance": currentPointsBalance,
                "email": email,
                "lifetimePoints": lifetimePoints,
                "numberOfReferrals": 0,
                "numberOfReviews": 0,
                "referralCode": "",
                "status": status,
                "timestampJoined": Int(round(Date().timeIntervalSince1970)),
                "userID": userID
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("hasSeenFRE set to True")
                }

        }
    }
}
