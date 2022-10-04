//
//  ReferralsViewModel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/26/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ReferralsViewModel: ObservableObject, Identifiable {
    
    @Published var snapshotOfAllReferrals = [Referrals]()
    @Published var snapshotOfReferralsForItem = [Referrals]()
    
    @Published var oneReferral = [Referrals]()
    
    var listener_OneReferral: ListenerRegistration!
    
    var dm = DataManager()
    
    private var db = Firestore.firestore()


    func getSnapshotOfAllReferrals(userID: String) {
        //print("this ONE function was called")
        
        
        db.collection("referral")
            .whereField("ids.userID", isEqualTo: userID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfAllReferrals")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfAllReferrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Referrals? in
                    print("AT THE TRY STATEMENT FOR GET ALL REFERRALS")
                    print(try? queryDocumentSnapshot.data(as: Referrals.self))
                    return try? queryDocumentSnapshot.data(as: Referrals.self)
                })
            }
        
    }
    
    
    func getSnapshotOfReferralsForItem(userID: String, itemID: String) {
        //print("this ONE function was called")
        
        print("this is the USER ID AND ITEM ID FOR getSnapshotOfReferralsForItem")
        print(userID)
        print(itemID)
        
        db.collection("referral")
            .whereField("ids.userID", isEqualTo: userID)
            .whereField("ids.itemID", isEqualTo: itemID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfReferralsForItem")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.snapshotOfReferralsForItem = snapshot.documents.compactMap({ queryDocumentSnapshot -> Referrals? in
                    print("AT THE TRY STATEMENT FOR REFERRALS FOR ITEM")
                    print(try? queryDocumentSnapshot.data(as: Referrals.self))
                    return try? queryDocumentSnapshot.data(as: Referrals.self)
                })
            }
        
    }
    
    
    func listenForOneReferralInProgress(userID: String, companyID: String, referralID: String) {
        
        self.oneReferral = [Referrals]()
        
        self.dm.getOneReferralInProgress(userID: userID, companyID: companyID, referralID: referralID, onSuccess: { (referrals) in
            //if (self.newTickets.isEmpty) {
                self.oneReferral = referrals
            //print("this is the discount codes")
            //print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_OneReferral = listener
        })
    }
    
    func updateReferralWithCustomMessage(referralID: String, customMessage: String, handle: String) {
        
        db.collection("referral").document(referralID).updateData([
            
            "card.customMessage": customMessage,
            "ids.handle": handle
                  
            ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("hasSeenFRE set to True")
            }
        }
    }
    
    

    func addReferral(color: Int, companyName: String, customMessage: String, discountCode: String, domain: String, handle: String, itemTitle: String, companyID: String, itemID: String, referralID: String, shopifyProductID: Int, userID: String, email: String, rewardAmount: Int, rewardType: String, recipientFirstName: String, recipientLastName: String, recipientPhone: String, offerRewardAmount: Int, status: String, usageLimit: Int) {

        let referralTimestamp = Int(round(Date().timeIntervalSince1970))
        
        let discountCodeCaseInsensitive = discountCode.uppercased()
        
        db.collection("referral").document(referralID)
            .setData([
                
                "card": [
                    
                    "color": color,
                    "companyName": companyName,
                    "customMessage": customMessage,
                    "discountCode": discountCode,
                    "discountCodeCaseInsensitive": discountCodeCaseInsensitive,
                    "itemImage": "",
                    "itemTitle": itemTitle
                    
                ],
                "ids": [
                    "companyID": companyID,
                    "domain": domain,    
                    "graphQLID": "",        //need to get this later
                    "handle": handle,
                    "itemID": itemID,
                    "usedOnOrderID": "",
                    "referralID": referralID,
                    "shopifyProductID": shopifyProductID,
                    "reviewID": "",
                    "userID": userID
                ],
                "offer": [
                    "expirationTimestamp": -1,
                    "forNewCustomersOnly": false,
                    "minimumSpendRequired": -1,
                    "rewardAmount": offerRewardAmount,
                    "rewardType": "DOLLAR-DISCOUNT",
                    "usageLimit": usageLimit
                ],
                "recipient": [
                    "firstName": recipientFirstName,
                    "lastName": recipientLastName,
                    "phone": recipientPhone,
                    "email": ""
                ],
                "reward": [
                    "rewardAmount": rewardAmount,
                    "rewardType": "POINTS",
                ],
                "sender": [
                    "firstName": "",
                    "lastName": "",
                    "phone": "",
                    "email": email
                ],
                "status": [
                    "status": status,
                    "timestampCreated": referralTimestamp,
                    "timestampUsed": -1,
                    "timestampComplete": -1,
                    "timeWaitingForReturnInDays": 5
                ]
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("IDK WHAT THE ERROR IS WITH THE REFERRAL CREATION????")
            }
        }
    }

}


