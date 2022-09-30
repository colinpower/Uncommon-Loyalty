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
    
    
    

    func addReferral(color: Int, companyName: String, customMessage: String, discountCode: String, itemTitle: String, companyID: String, itemID: String, referralID: String, userID: String, email: String, rewardAmount: Int, rewardType: String, recipientFirstName: String, recipientLastName: String, recipientPhone: String, offerRewardAmount: Int) {

        let referralTimestamp = Int(round(Date().timeIntervalSince1970))
        
        db.collection("referral").document(referralID)
            .setData([
                
                "card": [
                    
                    "color": color,
                    "companyName": companyName,
                    "customMessage": customMessage,
                    "discountCode": discountCode,
                    "itemImage": "",
                    "itemTitle": itemTitle
                    
                ],
                "ids": [
                    "companyID": companyID,
                    "domain": "",           //need to get this later
                    "graphQLID": "",        //need to get this later
                    "historyID": "",
                    "itemID": itemID,
                    "usedOnOrderID": "",
                    "referralID": referralID,
                    "reviewID": "",
                    "userID": userID
                ],
                "offer": [
                    "expirationTimestamp": -1,
                    "forNewCustomersOnly": false,
                    "minimumSpendRequired": -1,
                    "rewardAmount": offerRewardAmount,
                    "rewardType": "DOLLAR-DISCOUNT",
                    "singleUse": true
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
                    "status": "SENT",
                    "timestampCreated": referralTimestamp,
                    "timestampUsed": -1,
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


