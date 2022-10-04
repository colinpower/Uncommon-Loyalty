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
    
    @Published var myActiveDiscountCodes = [DiscountCodes]()
    @Published var oneDiscountCode = [DiscountCodes]()
    
    var dm = DataManager()
    
    var listener_MyActiveDiscountCodes: ListenerRegistration!
    var listener_OneDiscountCode: ListenerRegistration!
        
    private var db = Firestore.firestore()
    
    func listenForMyActiveDiscountCodes(userID: String, companyID: String) {
        self.myActiveDiscountCodes = [DiscountCodes]()
        
        self.dm.getMyActiveDiscountCodes(userID: userID, companyID: companyID, onSuccess: { (discountcodes) in
            
            //if (self.newTickets.isEmpty) {
            self.myActiveDiscountCodes = discountcodes
            
            print("this is the discount codes")
            print(self.myActiveDiscountCodes)
            
        }, listener: { (listener) in
            self.listener_MyActiveDiscountCodes = listener
        })
    }
    
    func listenForOneDiscountCode(userID: String, companyID: String, code: String) {
        
        let discountID = companyID + "-" + code
        
        self.oneDiscountCode = [DiscountCodes]()
        
        self.dm.getOneDiscountCode(userID: userID, companyID: companyID, discountID: discountID, onSuccess: { (discountcodes) in
            //if (self.newTickets.isEmpty) {
                self.oneDiscountCode = discountcodes
            //print("this is the discount codes")
            //print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_OneDiscountCode = listener
        })
    }
    
    
    
    
    func addCode(color: Int, companyID: String, companyName: String, discountCode: String, cardType: String, discountID: String, domain: String, firstName: String, lastName: String, phone: String, email: String, expirationTimestamp: Int, minimumSpendRequired: Int, rewardAmount: Int, rewardType: String, usageLimit: Int, pointsSpent: Int, userID: String) {
        
        let timestamp = Int(round(Date().timeIntervalSince1970))
        
        let discountCodeCaseInsensitive = discountCode.uppercased()

        db.collection("discount").document(discountID)
            .setData([
                "card": [
                    "cardType": cardType,
                    "color": color,
                    "companyName": companyName,
                    "customMessage": "",
                    "discountCode": discountCode,
                    "discountCodeCaseInsensitive": discountCodeCaseInsensitive,
                ],
                "ids": [
                    "companyID": companyID,
                    "discountID": discountID,
                    "domain": domain,
                    "graphQLID": "",        //hasn't been set yet
                    "usedOnOrderID": "",
                    "userID": userID
                ],
                "reward": [
                    "expirationTimestamp": expirationTimestamp,
                    "minimumSpendRequired": minimumSpendRequired,
                    "rewardAmount": rewardAmount,
                    "rewardType": rewardType,
                    "usageLimit": usageLimit,
                    "pointsSpent": pointsSpent
                ],
                "owner": [
                    "firstName": firstName,
                    "lastName": lastName,
                    "phone": phone,
                    "email": email,
                ],
                "status": [
                    "status": "PENDING",           //PENDING, CREATED, USED, DELETED
                    "failedToBeCreated": false,       //IF TRUE, SHOULD BE DELETED
                    "timestampCreated": timestamp,
                    "timestampUsed": -1
                ]
                
            ]) { err in
                    if let err = err {
                        print("Error updating DISCOUNT: \(err)")
                    } else {
                        print("hasSeenFRE set to True")
                    }
            }
    }
}



