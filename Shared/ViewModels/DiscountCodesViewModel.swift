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
    @Published var oneDiscountCodeInProgress = [DiscountCodes]()
    
    @Published var inProgressPersonalDiscountCode = [DiscountCodes]()
    
    var dm = DataManager()
    
    var listener_MyActiveDiscountCodes: ListenerRegistration!
    var listener_OneDiscountCodeInProgress: ListenerRegistration!
    var listener_InProgressPersonalDiscountCode: ListenerRegistration!
        
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
    
    func listenForOneDiscountCodeInProgress(userID: String, companyID: String, discountID: String) {
        
        self.oneDiscountCodeInProgress = [DiscountCodes]()
        
        self.dm.getOneDiscountCodeInProgress(userID: userID, companyID: companyID, discountID: discountID, onSuccess: { (discountcodes) in
            //if (self.newTickets.isEmpty) {
                self.oneDiscountCodeInProgress = discountcodes
            //print("this is the discount codes")
            //print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_OneDiscountCodeInProgress = listener
        })
    }
    
    func listenForInProgressPersonalDiscountCode(userID: String, companyID: String, discountID: String) {
        
        self.inProgressPersonalDiscountCode = [DiscountCodes]()
        
        self.dm.getInProgressPersonalDiscountCode(userID: userID, companyID: companyID, discountID: discountID, onSuccess: { (discountcodes) in
            //if (self.newTickets.isEmpty) {
                self.inProgressPersonalDiscountCode = discountcodes
            //print("this is the discount codes")
            //print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_InProgressPersonalDiscountCode = listener
        })
    }
    
    
    func updateDiscountToAcceptPersonalCode(discountID: String) {
        
        //try <- I eliminated the try / catch thing.. this seems like it should work just fine?
        
        db.collection("discount").document(discountID)
            .updateData([
                "status.status": "ACTIVE"
            ]);
    }
    
    func addToPersonalCode(discountID: String, domain: String, graphqlID: String, minimumSpendRequired: Int, pointsSpent: Int, rewardAmount: Int, status: String) {
        
        let timestamp = Int(round(Date().timeIntervalSince1970))

        db.collection("discount").document(discountID).collection("additions").addDocument(data:
            [
                "domain": domain,
                "graphqlID": graphqlID,
                "minimumSpendRequired": minimumSpendRequired,
                "pointsSpent": pointsSpent,
                "rewardAmount": rewardAmount,
                "status": status,
                "timestamp": timestamp
               
            ]) { err in
                    if let err = err {
                        print("Error updating DISCOUNT: \(err)")
                    } else {
                        print("hasSeenFRE set to True")
                    }
            }
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



