//
//  OneOrder.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI
import Firebase

struct OneOrder: View {
    
    //Required variables to be passed
    @State var email: String
    @State var companyID: String
    @State var orderID: String
    
    //Get snapshot from Firestore
    @StateObject var ordersViewModel = OrdersViewModel()
    
    
    var body: some View {
        VStack {
            //Add title
            
            //Body
            ForEach(ordersViewModel.snapshotOfOrder.prefix(1)) { order in
                HStack {
                    Text(order.orderID)
                    Text(String(order.totalPrice))
                    
                }
                Text("total number of items")
                
                ForEach(order.itemIDs, id: \.self) { itemID in
                    
                    Text(itemID)
                    NavigationLink(destination: ItemForOrder(userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2", email: email, companyID: companyID, itemID: itemID)) {
                        HStack {
                            Text(itemID)
//                            Text(order.item_firstItemTitle)
//                            Text(order.orderID)
                            //Text("\$0")
                        }
                    }
                }
                Text(order.item_firstItemTitle)
            }
        }.onAppear {
            self.ordersViewModel.snapshotOfOrder(orderID: orderID)
        }
    }
}

struct OneOrder_Previews: PreviewProvider {
    static var previews: some View {
        OneOrder(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM", orderID: "0aLyC3D7wXp8cuZMhtmM")
    }
}
