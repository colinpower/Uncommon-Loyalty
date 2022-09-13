//
//  CompaniesViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/11/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CompaniesViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var allCompanies = [Companies]()
    @Published var myCompanies = [Companies]()
    @Published var oneCompany = [Companies]()
    
    
    @Published var snapshotOfAllCompanies = [Companies]()
    
    
    var dm = DataManager()
    
    var listener_allCompanies: ListenerRegistration!
    var listener_myCompanies: ListenerRegistration!
    var listener_oneCompany: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    
    
    
    func listenForAllCompanies() {
        self.allCompanies = [Companies]()

        self.dm.getAllCompanies( onSuccess: { (companies) in
            //if (self.newTickets.isEmpty) {
            self.allCompanies = companies
            print("this is the companies")
            print(self.allCompanies)
        }, listener: { (listener) in
            self.listener_allCompanies = listener
        })
    }
    
    func getSnapshotOfAllCompanies() {
    
        db.collection("companies")
            .order(by: "companyName", descending: false)
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfAllCompanies")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.snapshotOfAllCompanies = snapshot.documents.compactMap({ queryDocumentSnapshot -> Companies? in
                    print("AT THE TRY STATEMENT for snapshotOfAllCompanies")
                    print(try? queryDocumentSnapshot.data(as: Companies.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Companies.self)
                })
            }
    
    }
    
    
    
    
    
    
    func listenForMyCompanies() {
        self.myCompanies = [Companies]()

        self.dm.getMyCompanies( onSuccess: { (companies) in
            //if (self.newTickets.isEmpty) {
            self.myCompanies = companies
            print("this is the companies")
            print(self.myCompanies)
        }, listener: { (listener) in
            self.listener_myCompanies = listener
        })
    }
    

    
    
    
    
    func listenForOneCompany(companyID: String) {
        self.oneCompany = [Companies]()

        self.dm.getOneCompany(companyID: companyID, onSuccess: { (Company) in
            //if (self.newTickets.isEmpty) {
                self.oneCompany = Company
            print("this is the one company")
            print(self.oneCompany)
        }, listener: { (listener) in
            self.listener_oneCompany = listener
        })
    }
    
}
