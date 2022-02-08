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
    
    func listenForMyRewardsPrograms(user: String) {
        self.myRewardsPrograms = [RewardsProgram]()
        
        self.dm.getMyRewardsPrograms(user: user, onSuccess: { (RewardsPrograms) in
            //if (self.newTickets.isEmpty) {
                self.myRewardsPrograms = RewardsPrograms
        }, listener: { (listener1) in
            self.listener1 = listener1
        })
    }
    
    func listenForOneRewardsProgram(user: String, company: String) {
        self.oneRewardsProgram = [RewardsProgram]()
        
        self.dm.getOneRewardsProgram(user: user, company: company, onSuccess: { (RewardsProgram) in
            //if (self.newTickets.isEmpty) {
                self.oneRewardsProgram = RewardsProgram
            print("this is the rewards program")
            print(self.oneRewardsProgram)
        }, listener: { (listener2) in
            self.listener2 = listener2
        })
    }
    

    
//    func acceptTicket(ticketReference: String) {
//        db.collection("tickets").document(ticketReference).updateData([
//            "agentID": "colinjpower1"
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                //print("Document successfully updated")
//            }
//        }
//    }
//
//    // MARK: Queries for the INBOX views
//    func listenForMyTickets() {
//        self.myTickets = [Ticket]()
//
//        self.dm.getMyTickets(onSuccess: { (tickets) in
//            self.myTickets = tickets
//        }, listener: { (listener) in
//            self.listener2 = listener
//        })
//    }
    
    
    
    
    
  
}
