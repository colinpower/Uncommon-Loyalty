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
    
    @Published var myCompanies = [Companies]()
    //@Published var oneOrder = [Orders]()
    
    var dm = DataManager()
    
    var listener_myCompanies: ListenerRegistration!
    //var listener_Orders2: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
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
    
    
    
    
    
    
//    func listenForOneOrder(email: String, companyID: String, orderID: String) {
//        self.oneOrder = [Orders]()
//
//        self.dm.getOneOrder(email: email, companyID: companyID, orderID: orderID, onSuccess: { (Order) in
//            //if (self.newTickets.isEmpty) {
//                self.oneOrder = Order
//            print("this is the one order")
//            print(self.oneOrder)
//        }, listener: { (listener6) in
//            self.listener_Orders2 = listener6
//        })
//    }
    
}
