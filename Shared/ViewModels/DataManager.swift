//
//  DataManager.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    
    private var db = Firestore.firestore()
    
    //MARK: Queries for the HOME view
        //how to do the listener stuff
        //https://stackoverflow.com/questions/63088521/firebase-and-swiftui-listening-for-real-time-update-strange-behave-weird
    func getMyRewardsPrograms(email: String, onSuccess: @escaping([RewardsProgram]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        print("this function was called")
        let listenerRegistration1 = db.collection("loyaltyprograms")
            .whereField("email", isEqualTo: email)
            .order(by: "companyName", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myRewardsProgramsArray = [RewardsProgram]()

            myRewardsProgramsArray = documents.compactMap { (queryDocumentSnapshot) -> RewardsProgram? in
                //print(try? queryDocumentSnapshot.data(as: RewardsProgram.self))
                return try? queryDocumentSnapshot.data(as: RewardsProgram.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myRewardsProgramsArray)
        }
        listener(listenerRegistration1) //escaping listener
    }
    
    func getOneRewardsProgram(email: String, companyID: String, onSuccess: @escaping([RewardsProgram]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        print("this ONE function was called")
        let listenerRegistration2 = db.collection("loyaltyprograms")
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneRewardsProgramsArray = [RewardsProgram]()

            oneRewardsProgramsArray = documents.compactMap { (queryDocumentSnapshot) -> RewardsProgram? in
//                print(try? queryDocumentSnapshot.data(as: RewardsProgram.self))
                return try? queryDocumentSnapshot.data(as: RewardsProgram.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneRewardsProgramsArray)
        }
        listener(listenerRegistration2) //escaping listener
    }
    
    
    func getMyDiscountCodes(email: String, companyID: String, onSuccess: @escaping([DiscountCodes]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration3 = db.collection("discountcodes-" + companyID)
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myDiscountCodesArray = [DiscountCodes]()

            myDiscountCodesArray = documents.compactMap { (queryDocumentSnapshot) -> DiscountCodes? in
//                print(try? queryDocumentSnapshot.data(as: DiscountCodes.self))
                return try? queryDocumentSnapshot.data(as: DiscountCodes.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myDiscountCodesArray)
        }
        listener(listenerRegistration3) //escaping listener
    }
    
    
    func getMyTransactions(email: String, companyID: String, onSuccess: @escaping([Transactions]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration4 = db.collection("history-" + companyID)
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myTransactionsArray = [Transactions]()

                myTransactionsArray = documents.compactMap { (queryDocumentSnapshot) -> Transactions? in
//                    print("HERE!!!")
//                print(try? queryDocumentSnapshot.data(as: Transactions.self))
                return try? queryDocumentSnapshot.data(as: Transactions.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myTransactionsArray)
        }
        listener(listenerRegistration4) //escaping listener
    }
    
    func getMyOrders(email: String, companyID: String, onSuccess: @escaping([Orders]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration5 = db.collection("orders-" + companyID)
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myOrdersArray = [Orders]()

                myOrdersArray = documents.compactMap { (queryDocumentSnapshot) -> Orders? in
                    print("THIS IS THE ORDERS")
                print(try? queryDocumentSnapshot.data(as: Orders.self))
                return try? queryDocumentSnapshot.data(as: Orders.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myOrdersArray)
        }
        listener(listenerRegistration5) //escaping listener
    }
    
    func getOneOrder(email: String, companyID: String, orderID: String, onSuccess: @escaping([Orders]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration6 = db.collection("orders-" + companyID)
            .whereField("email", isEqualTo: email)
            .whereField("orderID", isEqualTo: orderID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneOrderArray = [Orders]()

                oneOrderArray = documents.compactMap { (queryDocumentSnapshot) -> Orders? in
                    print("SINGLE ORDER")
                print(try? queryDocumentSnapshot.data(as: Orders.self))
                return try? queryDocumentSnapshot.data(as: Orders.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneOrderArray)
        }
        listener(listenerRegistration6) //escaping listener
    }
    
    
//    // MARK: Queries for the INBOX views
//    func getMyTickets(onSuccess: @escaping([Ticket]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//
//        let listenerRegistration2 = db.collection("tickets")
//            .whereField("agentID", isEqualTo: "colinjpower1")
//            .addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            var myTicketsArray = [Ticket]()
//            myTicketsArray = documents.compactMap { (queryDocumentSnapshot) -> Ticket? in
//                //print(try? queryDocumentSnapshot.data(as: Ticket.self))
//                return try? queryDocumentSnapshot.data(as: Ticket.self)
//                //return try? queryDocumentSnapshot.data(as: Ticket.self)
//            }
//            onSuccess(myTicketsArray)
//        }
//        listener(listenerRegistration2)
//    }
//
//    // MARK: Query for the CHAT view
//    func getMessagesForTicket(ticketReference: String, onSuccess: @escaping([Message]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//
//        let listenerRegistration3 = db.collection("tickets").document(ticketReference).collection("messages")
//            .order(by: "timestamp", descending: false)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//                var tempMessages = [Message]()
//                tempMessages = documents.compactMap { (queryDocumentSnapshot) -> Message? in
//                    //print(type(of: try? queryDocumentSnapshot.data(as: Message.self)))
//                    return try? queryDocumentSnapshot.data(as: Message.self)
//                    //return try? queryDocumentSnapshot.data(as: Ticket.self)
//                }
//                onSuccess(tempMessages)
//            }
//        listener(listenerRegistration3)
//    }
    
    
    
}
