//
//  DiscountCodesViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class DiscountCodesViewModel: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var myDiscountCodes = [DiscountCodes]()
    
    var dm = DataManager()
    
    var listener_DiscountCodes: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyDiscountCodes(email: String, companyID: String) {
        self.myDiscountCodes = [DiscountCodes]()
        
        self.dm.getMyDiscountCodes(email: email, companyID: companyID, onSuccess: { (discountcodes) in
            //if (self.newTickets.isEmpty) {
                self.myDiscountCodes = discountcodes
            //print("this is the discount codes")
            //print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_DiscountCodes = listener
        })
    }
    
    func addCode(companyID: String, companyName: String, dollars: Int, domain: String, email: String, firstNameID: String, pointsSpent: Int, usageLimit: Int, userID: String) {
        db.collection("discount")
            .addDocument(data: [
                "code": "",
                "companyID": companyID,
                "companyName": companyName,
                "discountID": "",
                "dollarAmount": dollars,
                "domain": domain,
                "email": email,
                "firstNameID": firstNameID,
                "graphqlID": "",
                "historyID": "",
                "minimumSpendRequired": 0,
                "pointsSpent": pointsSpent,
                "status": "PENDING",
                "timestamp_Active": 0,
                "timestamp_Created": Int(round(Date().timeIntervalSince1970)),
                "timestamp_Used": 0,
                "usageLimit": usageLimit,
                "usedOnOrderID": "",
                "userID": userID
            ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("hasSeenFRE set to True")
                    }
            }
    }
}
