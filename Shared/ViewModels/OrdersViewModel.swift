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
    
    @Published var allOrders = [Orders]()
    @Published var myOrders = [Orders]()
    @Published var oneOrder = [Orders]()
    
    @Published var snapshotOfAllOrders = [Orders]()
    @Published var snapshotOfOrders = [Orders]()
    @Published var snapshotOfOrder = [Orders]()
    
    var dm = DataManager()
    
    var listenerForAllOrders: ListenerRegistration!
    var listener_MyOrders: ListenerRegistration!
    var listener_OneOrder: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    
    func listenForAllOrders(userID: String) {
        self.allOrders = [Orders]()

        self.dm.getAllOrders(userID: userID, onSuccess: { (orders) in
            //if (self.newTickets.isEmpty) {
                self.allOrders = orders
            print("this is all orders")
            print(self.allOrders)
        }, listener: { (listener) in
            self.listenerForAllOrders = listener
        })
    }
    
    
    func listenForMyOrders(email: String, companyID: String) {
        self.myOrders = [Orders]()

        self.dm.getMyOrders(email: email, companyID: companyID, onSuccess: { (orders) in
            //if (self.newTickets.isEmpty) {
                self.myOrders = orders
            print("this is my orders")
            print(self.myOrders)
        }, listener: { (listener5) in
            self.listener_MyOrders = listener5
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
            self.listener_OneOrder = listener6
        })
    }
    
    func snapshotOfAllOrders(userID: String) {
        //print("this ONE function was called")
        
        //var ordersSnapshot = [Orders]()
        
        db.collection("order")
            .whereField("userID", isEqualTo: userID)
            .whereField("timestamp", isNotEqualTo: 0)
            .order(by: "timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getAllOrdersSnapshot")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfAllOrders = snapshot.documents.compactMap({ queryDocumentSnapshot -> Orders? in
                    print("AT THE TRY STATEMENT")
                    print(try? queryDocumentSnapshot.data(as: Orders.self))
                    return try? queryDocumentSnapshot.data(as: Orders.self)
                })
            }
    }
    
    func snapshotOfOrders(userID: String, companyID: String) {
        //print("this ONE function was called")
        
        //var ordersSnapshot = [Orders]()
        
        db.collection("order")
            .whereField("userID", isEqualTo: userID)
            .whereField("companyID", isEqualTo: companyID)
            .whereField("timestamp", isNotEqualTo: 0)
            .order(by: "timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getOneOrderSnapshot")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfOrders = snapshot.documents.compactMap({ queryDocumentSnapshot -> Orders? in
                    print("AT THE TRY STATEMENT")
                    print(try? queryDocumentSnapshot.data(as: Orders.self))
                    return try? queryDocumentSnapshot.data(as: Orders.self)
                })
            }
    }
    
    func snapshotOfOrder(orderID: String) {
        //print("this ONE function was called")
        
        //var ordersSnapshot = [Orders]()
        
        db.collection("order")
            .whereField("orderID", isEqualTo: orderID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfOrder")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfOrder = snapshot.documents.compactMap({ queryDocumentSnapshot -> Orders? in
                    print("AT THE TRY STATEMENT")
                    print(try? queryDocumentSnapshot.data(as: Orders.self))
                    return try? queryDocumentSnapshot.data(as: Orders.self)
                })
            }
        
    }


    
    
    
    
}
