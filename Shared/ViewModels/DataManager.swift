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
    func getMyRewardsPrograms(userID: String, onSuccess: @escaping([RewardsProgram]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        print("this function was called")
        let listenerRegistration1 = db.collection("loyaltyprograms")
            .whereField("ids.userID", isEqualTo: userID)
            .order(by: "card.companyName", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myRewardsProgramsArray = [RewardsProgram]()

            myRewardsProgramsArray = documents.compactMap { (queryDocumentSnapshot) -> RewardsProgram? in
                
                print("here's my rewards programs info...")
                print(try? queryDocumentSnapshot.data(as: RewardsProgram.self))
                return try? queryDocumentSnapshot.data(as: RewardsProgram.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myRewardsProgramsArray)
        }
        listener(listenerRegistration1) //escaping listener
    }
    
    func getOneRewardsProgram(userID: String, companyID: String, onSuccess: @escaping([RewardsProgram]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        print("this ONE function was called")
        
        let listenerRegistration = db.collection("loyaltyprograms")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
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
        listener(listenerRegistration) //escaping listener
    }
    
    
    func getMyActiveDiscountCodes(userID: String, companyID: String, onSuccess: @escaping([DiscountCodes]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration3 = db.collection("discount")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
            .whereField("status.status", isEqualTo: "ACTIVE")
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
    
    func getOneDiscountCode(userID: String, companyID: String, discountID: String, onSuccess: @escaping([DiscountCodes]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        //print("this ONE function was called")
        let listenerRegistration = db.collection("discount")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
            .whereField("ids.discountID", isEqualTo: discountID)
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneDiscountCodeArray = [DiscountCodes]()

                oneDiscountCodeArray = documents.compactMap { (queryDocumentSnapshot) -> DiscountCodes? in
//                print(try? queryDocumentSnapshot.data(as: DiscountCodes.self))
                return try? queryDocumentSnapshot.data(as: DiscountCodes.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneDiscountCodeArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    
    
    
    
    
    
    func getMyTransactions(email: String, companyID: String, onSuccess: @escaping([Transactions]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration4 = db.collection("history")
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .order(by: "timestamp", descending: true)
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
    
    func getLast60DaysTransactions(email: String, companyID: String, onSuccess: @escaping([Transactions]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration7 = db.collection("history-" + companyID)
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .whereField("timestamp", isGreaterThan: (Int(Date().timeIntervalSince1970) - 60*86400))
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var last60DaysTransactionsArray = [Transactions]()

                last60DaysTransactionsArray = documents.compactMap { (queryDocumentSnapshot) -> Transactions? in
//                    print("HERE!!!")
//                print(try? queryDocumentSnapshot.data(as: Transactions.self))
                return try? queryDocumentSnapshot.data(as: Transactions.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(last60DaysTransactionsArray)
        }
        listener(listenerRegistration7) //escaping listener
    }
    
    func getMyItems(userID: String, onSuccess: @escaping([Items]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration10 = db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myItemsArray = [Items]()

                myItemsArray = documents.compactMap { (queryDocumentSnapshot) -> Items? in
                    print("THIS IS THE ITEMS")
                print(try? queryDocumentSnapshot.data(as: Items.self))
                return try? queryDocumentSnapshot.data(as: Items.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myItemsArray)
        }
        listener(listenerRegistration10) //escaping listener
    }
    
    func getOneReferralInProgress(userID: String, companyID: String, referralID: String, onSuccess: @escaping([Referrals]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        print("there's a new listener created / updated for the ONE REFERRAL")
        
        
        let listenerRegistration = db.collection("referral")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
            .whereField("ids.referralID", isEqualTo: referralID)
            .addSnapshotListener { (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                print("No documents for referral in progress")
                return
            }
            var oneReferralArray = [Referrals]()

                oneReferralArray = documents.compactMap { (queryDocumentSnapshot) -> Referrals? in
//                print(try? queryDocumentSnapshot.data(as: DiscountCodes.self))
                return try? queryDocumentSnapshot.data(as: Referrals.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneReferralArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    
    func getMyReferableItemsForCompany(userID: String, companyID: String, onSuccess: @escaping([Items]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration13 = db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.companyID", isEqualTo: companyID)
            .whereField("review.rating", isEqualTo: 5)
            .whereField("referrals.count", isEqualTo: 0)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myReferableItemsForCompanyArray = [Items]()

                myReferableItemsForCompanyArray = documents.compactMap { (queryDocumentSnapshot) -> Items? in
                    print("THIS IS THE REFERABLE ITEMS")
                print(try? queryDocumentSnapshot.data(as: Items.self))
                return try? queryDocumentSnapshot.data(as: Items.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myReferableItemsForCompanyArray)
        }
        listener(listenerRegistration13) //escaping listener
    }
    
    func getOneItem(userID: String, itemID: String, onSuccess: @escaping([Items]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration12 = db.collection("item")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.itemID", isEqualTo: itemID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneItemArray = [Items]()

                oneItemArray = documents.compactMap { (queryDocumentSnapshot) -> Items? in
                    print("SINGLE ITEM")
                print(try? queryDocumentSnapshot.data(as: Items.self))
                return try? queryDocumentSnapshot.data(as: Items.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneItemArray)
        }
        listener(listenerRegistration12) //escaping listener
    }
    
    func getAllOrders(userID: String, onSuccess: @escaping([Orders]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration = db.collection("order")
            .whereField("userID", isEqualTo: userID)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("didn't find any documents for getAllOrders")
                print("No documents")
                return
            }
            var allOrdersArray = [Orders]()

                allOrdersArray = documents.compactMap { (queryDocumentSnapshot) -> Orders? in
                    print("THIS IS ALL THE ORDERS")
                print(try? queryDocumentSnapshot.data(as: Orders.self))
                return try? queryDocumentSnapshot.data(as: Orders.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(allOrdersArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    func getMyOrders(email: String, companyID: String, onSuccess: @escaping([Orders]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration5 = db.collection("order")
            .whereField("email", isEqualTo: email)
            .whereField("companyID", isEqualTo: companyID)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("didn't find any documents for getMyOrders")
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
        let listenerRegistration6 = db.collection("order")
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
    
 
    
    
    
    
    func getAllCompanies( onSuccess: @escaping([Companies]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration = db.collection("companies")
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var allCompaniesArray = [Companies]()

                allCompaniesArray = documents.compactMap { (queryDocumentSnapshot) -> Companies? in
                    print("THIS IS THE COMPANIES")
                print(try? queryDocumentSnapshot.data(as: Companies.self))
                return try? queryDocumentSnapshot.data(as: Companies.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(allCompaniesArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    
    
    func getMyCompanies( onSuccess: @escaping([Companies]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration = db.collection("companies")
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var myCompaniesArray = [Companies]()

                myCompaniesArray = documents.compactMap { (queryDocumentSnapshot) -> Companies? in
                    print("THIS IS THE COMPANIES")
                print(try? queryDocumentSnapshot.data(as: Companies.self))
                return try? queryDocumentSnapshot.data(as: Companies.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(myCompaniesArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    func getOneCompany(companyID: String, onSuccess: @escaping([Companies]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        //print("this ONE function was called")
        let listenerRegistration = db.collection("companies")
            .whereField("companyID", isEqualTo: companyID)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneCompanyArray = [Companies]()

                oneCompanyArray = documents.compactMap { (queryDocumentSnapshot) -> Companies? in
                    print("SINGLE COMPANY")
                print(try? queryDocumentSnapshot.data(as: Companies.self))
                return try? queryDocumentSnapshot.data(as: Companies.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneCompanyArray)
        }
        listener(listenerRegistration) //escaping listener
    }
    
    
    
    func getOneUser(email: String, onSuccess: @escaping([Users]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        
        let listenerRegistration = db.collection("users")
            .whereField("email", isEqualTo: email)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var oneUserArray = [Users]()

                oneUserArray = documents.compactMap { (queryDocumentSnapshot) -> Users? in
                    print("SINGLE USER")
                print(try? queryDocumentSnapshot.data(as: Users.self))
                return try? queryDocumentSnapshot.data(as: Users.self)
                //return try? queryDocumentSnapshot.data(as: Ticket.self)
            }
            onSuccess(oneUserArray)
        }
        listener(listenerRegistration) //escaping listener
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
