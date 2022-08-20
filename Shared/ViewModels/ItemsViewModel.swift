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
    
    func listenForOneItem(email: String, companyID: String, itemID: String) {
        self.oneItem = [Items]()
        
        self.dm.getOneItem(email: email, companyID: companyID, itemID: itemID, onSuccess: { (Item) in
            //if (self.newTickets.isEmpty) {
                self.oneItem = Item
            print("this is the one item")
            print(self.oneItem)
        }, listener: { (listener12) in
            self.listener_OneItem = listener12
        })
    }
    
}
