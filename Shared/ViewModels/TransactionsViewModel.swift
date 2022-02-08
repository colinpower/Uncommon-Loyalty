//
//  TransactionsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class TransactionsViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var myTransactions = [Transactions]()
    
    var dm = DataManager()
    
    var listener_Transactions: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyTransactions(user: String, company: String) {
        self.myTransactions = [Transactions]()

        self.dm.getMyTransactions(user: user, company: company, onSuccess: { (transactions) in
            //if (self.newTickets.isEmpty) {
                self.myTransactions = transactions
            print("this is the transactions")
            print(self.myTransactions)
        }, listener: { (listener4) in
            self.listener_Transactions = listener4
        })
    }
    
}
