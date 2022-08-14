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
    
    func addCode(dollars: Int, pointsSpent: Int, userID: String, companyName: String, companyID: String, email: String) {
        db.collection("discountcodes-" + companyID)
            .addDocument(data: [
                "code": "",
                "companyName": companyName,
                "companyID": companyID,
                "dollarAmount": dollars,
                "email": email,
                "minimumSpendRequired": 100,
                "pointsSpent": pointsSpent,
                "status": "PENDING",
                "timestampCreated": Int(round(Date().timeIntervalSince1970)),
                "timestampUsed": 0,
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
