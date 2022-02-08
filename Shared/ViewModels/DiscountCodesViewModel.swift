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
    
    func listenForMyDiscountCodes(user: String, company: String) {
        self.myDiscountCodes = [DiscountCodes]()
        
        self.dm.getMyDiscountCodes(user: user, company: company, onSuccess: { (discountcodes) in
            //if (self.newTickets.isEmpty) {
                self.myDiscountCodes = discountcodes
            print("this is the discount codes")
            print(self.myDiscountCodes)
        }, listener: { (listener) in
            self.listener_DiscountCodes = listener
        })
    }
    
    func addCode(dollars: Int, user: String, company: String) {
        try db.collection("discountCodes")
            .addDocument(data: [
                "code": "COLIN-DISCOUNT-ADDED",
                "company": company,
                "dollarAmount": dollars,
                "pointsSpent": "100000",
                "status": "Active",
                "user": user
            ])
    }
    
}
