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
    @Published var last60DaysTransactions = [Transactions]()
    
    @Published var snapshotOfTransactionsForCompany = [Transactions]()
    
    var dm = DataManager()
    
    var listener_Transactions: ListenerRegistration!
    var listener_Transactions7: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyTransactions(email: String, companyID: String) {
        self.myTransactions = [Transactions]()

        self.dm.getMyTransactions(email: email, companyID: companyID, onSuccess: { (transactions) in
            //if (self.newTickets.isEmpty) {
                self.myTransactions = transactions
//            print("this is the transactions")
//            print(self.myTransactions)
        }, listener: { (listener4) in
            self.listener_Transactions = listener4
        })
    }
    
    func listenForLast60DaysTransactions(email: String, companyID: String) {
        self.last60DaysTransactions = [Transactions]()

        self.dm.getLast60DaysTransactions(email: email, companyID: companyID, onSuccess: { (transactions) in
            //if (self.newTickets.isEmpty) {
                self.last60DaysTransactions = transactions

            
        }, listener: { (listener7) in
            self.listener_Transactions7 = listener7
        })
    }
    
    func getSnapshotOfTransactionsForCompany(userID: String, companyID: String) {
        //print("this ONE function was called")
        
        //var ordersSnapshot = [Orders]()
        
        db.collection("history")
            .whereField("userID", isEqualTo: userID)
            .whereField("companyID", isEqualTo: companyID)
            .whereField("timestamp", isNotEqualTo: -1)
            .order(by: "timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getSnapshotOfTransactionsForCompany")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfTransactionsForCompany = snapshot.documents.compactMap({ queryDocumentSnapshot -> Transactions? in
                    print("AT THE TRY STATEMENT")
                    print(try? queryDocumentSnapshot.data(as: Transactions.self))
                    return try? queryDocumentSnapshot.data(as: Transactions.self)
                })
            }
    }
    
    
    
}



