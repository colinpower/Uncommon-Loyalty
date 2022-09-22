//
//  ItemsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/20/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ItemsViewModel: ObservableObject, Identifiable {
    
    
    @Published var myItems = [Items]()
    @Published var myItemsForCompany = [Items]()
    @Published var myReviewableItemsForCompany = [Items]()
    @Published var myReferableItemsForCompany = [Items]()
    @Published var oneItem = [Items]()
    
    
    @Published var snapshotOfItem = [Items]()
    @Published var snapshotOfReviewableItems = [Items]()
    
    var dm = DataManager()
    
    var listener_MyItems: ListenerRegistration!
    var listener_MyItemsForCompany: ListenerRegistration!
    var listener_MyReviewableItemsForCompany: ListenerRegistration!
    var listener_MyReferableItemsForCompany: ListenerRegistration!
    var listener_OneItem: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyItems(email: String) {
        self.myItems = [Items]()

        self.dm.getMyItems(email: email, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myItems = items
            print("this is the items")
            print(self.myItems)
        }, listener: { (listener10) in
            self.listener_MyItems = listener10
        })
    }
    
    func listenForMyItemsForCompany(email: String, companyID: String) {
        self.myItemsForCompany = [Items]()

        self.dm.getMyItemsForCompany(email: email, companyID: companyID, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myItemsForCompany = items
            print("this is the items")
            print(self.myItemsForCompany)
        }, listener: { (listener11) in
            self.listener_MyItemsForCompany = listener11
        })
    }
    
    func listenForMyReviewableItemsForCompany(email: String, companyID: String) {
        self.myReviewableItemsForCompany = [Items]()

        self.dm.getMyReviewableItemsForCompany(email: email, companyID: companyID, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myReviewableItemsForCompany = items
            print("this is the reviewable items for " + companyID)
            print(self.myReviewableItemsForCompany)
        }, listener: { (listener11) in
            self.listener_MyReviewableItemsForCompany = listener11
        })
    }
    
    func listenForMyReferableItemsForCompany(email: String, companyID: String) {
        self.myReferableItemsForCompany = [Items]()

        self.dm.getMyReferableItemsForCompany(email: email, companyID: companyID, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myReferableItemsForCompany = items
            print("this is the referable items for " + companyID)
            print(self.myReferableItemsForCompany)
        }, listener: { (listener11) in
            self.listener_MyReferableItemsForCompany = listener11
        })
    }
    
    func listenForOneItem(email: String, itemID: String) {
        self.oneItem = [Items]()
        
        self.dm.getOneItem(email: email, itemID: itemID, onSuccess: { (Item) in
            //if (self.newTickets.isEmpty) {
                self.oneItem = Item
            print("this is the one item")
            print(self.oneItem)
        }, listener: { (listener12) in
            self.listener_OneItem = listener12
        })
    }
    
    
    func getSnapshotOfItem(itemID: String) {
        //print("this ONE function was called")
        
        
        db.collection("item")
            .whereField("itemID", isEqualTo: itemID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfItem")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfItem = snapshot.documents.compactMap({ queryDocumentSnapshot -> Items? in
                    print("AT THE TRY STATEMENT FOR ITEMS")
                    print(try? queryDocumentSnapshot.data(as: Items.self))
                    return try? queryDocumentSnapshot.data(as: Items.self)
                })
            }
        
    }
    
    func getSnapshotOfReviewableItems(userID: String) {
        //print("this ONE function was called")
        
        db.collection("item")
            .whereField("userID", isEqualTo: userID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfItem")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                
                self.snapshotOfReviewableItems = snapshot.documents.compactMap({ queryDocumentSnapshot -> Items? in
                    print("AT THE TRY STATEMENT FOR REVIEWABLE ITEMS")
                    print(try? queryDocumentSnapshot.data(as: Items.self))
                    return try? queryDocumentSnapshot.data(as: Items.self)
                })
            }
        
    }
    
    
    func updateItemForReview(userID: String, itemID: String, rating: Int) {
        db.collection("item").document(itemID).setData([
                "reviewID": userID + "-" + itemID,
                "reviewRating": rating,
                "orderID": ""
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    
    
    
}
