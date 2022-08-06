//
//  OrdersViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 4/22/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class OrdersViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var myOrders = [Orders]()
    @Published var oneOrder = [Orders]()
    
    var dm = DataManager()
    
    var listener_Orders: ListenerRegistration!
    var listener_Orders2: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyOrders(email: String, companyID: String) {
        self.myOrders = [Orders]()

        self.dm.getMyOrders(email: email, companyID: companyID, onSuccess: { (orders) in
            //if (self.newTickets.isEmpty) {
                self.myOrders = orders
            print("this is the orderes")
            print(self.myOrders)
        }, listener: { (listener5) in
            self.listener_Orders = listener5
        })
    }
    
    func listenForOneOrder(email: String, companyID: String, orderID: String) {
        self.oneOrder = [Orders]()
        
        self.dm.getOneOrder(email: email, companyID: companyID, orderID: orderID, onSuccess: { (Order) in
            //if (self.newTickets.isEmpty) {
                self.oneOrder = Order
            print("this is the one order")
            print(self.oneOrder)
        }, listener: { (listener6) in
            self.listener_Orders2 = listener6
        })
    }
    
}
