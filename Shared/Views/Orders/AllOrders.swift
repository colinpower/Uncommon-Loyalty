//
//  Orders_All.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI

struct AllOrders: View {
    
    //Required variables to be passed
    var userID: String
    
    @Binding var isShowingAllOrders: Bool
    
    
    //Getting the
    @StateObject var ordersViewModel = OrdersViewModel()
    
    var body: some View {
        VStack {
            
            Button {
                isShowingAllOrders = false
            } label: {
                Text("CLOSE")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
            }
            
            
            Text("ALL ORDERS VIEW")
            
            ForEach(ordersViewModel.snapshotOfAllOrders) { order in
                HStack {
                    Text(order.orderID)
                    Text(order.item_firstItemTitle)
                }
                
            }
            
            
        }.onAppear {
            self.ordersViewModel.snapshotOfAllOrders(userID: userID)
        }
        
        
    }
}

struct AllOrders_Previews: PreviewProvider {
    static var previews: some View {
        AllOrders(userID: "", isShowingAllOrders: .constant(true))
    }
}
