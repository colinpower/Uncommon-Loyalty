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
            .whereField("userID", isEqualTo: userID)
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
            .whereField("userID", isEqualTo: userID)
            .whereField("itemID", isEqualTo: itemID)
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in snapshotOfAllReferrals")
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
    
    
    

    func addReferral(referralID: String, companyID: String, email: String, itemID: String, orderID: String, referralBonusPoints: Int, referralCodeCreated: String, referralDiscountAmount: Int, userID: String) {

        let referralTimestamp = Int(round(Date().timeIntervalSince1970))
        
        db.collection("referral").document(referralID)
            .setData([
                
                "actualNewCustomerEmail": "",
                "associatedOrderID": orderID,
                "companyID": companyID,
                "domain": "",
                "historyID": "",
                "itemID": itemID,
                "prospectiveNewCustomerEmail": "",
                "referralBonusPoints": referralBonusPoints,
                "referralCode": referralCodeCreated,
                "referralDiscountAmount": referralDiscountAmount,
                "referralID": "",
                "status": "SENT",
                "timestamp_Created": referralTimestamp,
                "timestamp_Used": 0,
                "totalSpent": 0,
                "userID": userID,
                "userSendingReferralEmail": email

        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("IDK WHAT THE ERROR IS??")
            }
        }
    }

}


