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
    
    
    @Published var snapshotOfItems = [Items]()
    @Published var snapshotOfItemsWithMultipleReferrals = [Items]()
    @Published var snapshotOfItemsWith5StarsAndNoReferrals = [Items]()
    
    var dm = DataManager()
    
    var listener_MyItems: ListenerRegistration!
    //var listener_MyItemsForCompany: ListenerRegistration!
//    var listener_MyReviewableItemsForCompany: ListenerRegistration!
    var listener_MyReferableItemsForCompany: ListenerRegistration!
    var listener_OneItem: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyItems(userID: String) {
        self.myItems = [Items]()

        self.dm.getMyItems(userID: userID, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myItems = items
            print("this is the items")
            print(self.myItems)
        }, listener: { (listener10) in
            self.listener_MyItems = listener10
        })
    }
    
    
    func listenForMyReferableItemsForCompany(userID: String, companyID: String) {
        self.myReferableItemsForCompany = [Items]()

        self.dm.getMyReferableItemsForCompany(userID: userID, companyID: companyID, onSuccess: { (items) in
            //if (self.newTickets.isEmpty) {
                self.myReferableItemsForCompany = items
            print("this is the referable items for " + companyID)
            print(self.myReferableItemsForCompany)
        }, listener: { (listener11) in
            self.listener_MyReferableItemsForCompany = listener11
        })
    }
    
    func listenForOneItem(userID: String, itemID: String) {
        self.oneItem = [Items]()
        
        self.dm.getOneItem(userID: userID, itemID: itemID, onSuccess: { (Item) in
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
            .whereField("ids.itemID", isEqualTo: itemID)
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
    
    func getSnapshotOfItems(userID: String) {
        //print("this ONE function was called")
        
        db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .order(by: "order.timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfItem")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                
                self.snapshotOfItems = snapshot.documents.compactMap({ queryDocumentSnapshot -> Items? in
                    print("AT THE TRY STATEMENT FOR REVIEWABLE ITEMS")
                    print(try? queryDocumentSnapshot.data(as: Items.self))
                    return try? queryDocumentSnapshot.data(as: Items.self)
                })
            }
        
    }
    
    
    //snapshotOfItemsWithMultipleReferrals
    func getSnapshotOfItemsWithMultipleReferrals(userID: String) {
        
        db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("referrals.count", isGreaterThan: 0)
            .order(by: "referrals.count", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfItemsWithMultipleReferrals")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                
                self.snapshotOfItemsWithMultipleReferrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Items? in
                    print("AT THE TRY STATEMENT FOR snapshotOfItemsWithMultipleReferrals ITEMS")
                    print(try? queryDocumentSnapshot.data(as: Items.self))
                    return try? queryDocumentSnapshot.data(as: Items.self)
                })
            }
        
    }
    
    //snapshotOfItemsWith5StarsAndNoReferrals
    func getSnapshotOfItemsWith5StarsAndNoReferrals(userID: String) {
        
        db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("referrals.count", isEqualTo: 0)
            .whereField("review.rating", isEqualTo: 5)
            .order(by: "order.timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getSnapshotOfItemsWith5StarsAndNoReferrals")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                
                self.snapshotOfItemsWith5StarsAndNoReferrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Items? in
                    print("AT THE TRY STATEMENT FOR snapshotOfItemsWithMultipleReferrals ITEMS")
                    print(try? queryDocumentSnapshot.data(as: Items.self))
                    return try? queryDocumentSnapshot.data(as: Items.self)
                })
            }
    }
    
    
    
    
    
    
    func updateItemForReview(item: Items, userID: String, rating: Int) {
        
        let reviewID = userID + "-" + item.ids.itemID
        
        db.collection("item").document(item.ids.itemID).updateData([
            
            "ids.reviewID": reviewID,
            "review.rating": rating
                  
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    
    func updateItemForReferral(itemID: String, newReferralIDsArray: [String]) {
        
        db.collection("item").document(itemID).updateData([
            
            "ids.referralIDs": newReferralIDsArray,
            "referrals.count": FieldValue.increment(Int64(1))
            
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    
    
    
    func createFakeItemForDemo(email: String, userID: String) {
        
        let alphanumeric = "abcdefghijklmnopqrstuvwxyz123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        let itemID = randomString(of: 20)
        
        db.collection("item").document(itemID).setData([
            
            "ids": [
                "companyID": "zKL7SQ0jRP8351a0NnHM",
                "itemID": itemID,
                "orderID": "",
                "referralIDs": [""],
                "reviewID": "",
                "shopifyItemID": 123123,
                "shopifyProductID": 7585260634367,
                "userID": userID
            ],
            "referrals": [
                "count": 0,
                "rewardType": "POINTS",
                "rewardAmount": 10000
            ],
            "review": [
                "rating": 0,
                "rewardType": "POINTS",
                "rewardAmount": 250,
                "cardRBG": [192, 40, 43],
                "backgroundRBG": [251, 213, 213]
            ],
            "order": [
                "companyName": "Athleisure LA",
                "domain": "athleisure-la.myshopify.com",
                "email": email,
                "handle": "",
                "imageURL": "",
                "name": "Fake Order Name" + itemID.prefix(3),
                "orderNumber": 1234,
                "orderStatusURL": "https://athleisure-la.myshopify.com/63427707135/orders/618f44c951e2e1f3bade707e0a19bdb4",
                "phone": "6177772994",
                "price": "98.00",
                "quantity": 1,
                "returnPolicyInDays": 45,
                "status": "PAID",
                "timestamp": Int(round(Date().timeIntervalSince1970)),
                "title": "Fake Order Name" + itemID.prefix(3)
            ]
            
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    
    
    
}
