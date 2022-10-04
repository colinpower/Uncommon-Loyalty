////
////  AllOrdersForCompany.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 8/22/22.
////
//
//import SwiftUI
//
//struct AllOrdersForCompany: View {
//    
//    //Required variables to be passed
//    var userID: String
//    var companyID: String
//    
//    @Binding var isShowingAllOrdersForCompany: Bool
//    
//    //Getting the
//    @StateObject var ordersViewModel = OrdersViewModel()
//    
//    var body: some View {
//        VStack {
//            
//            Button {
//                isShowingAllOrdersForCompany = false
//            } label: {
//                Text("CLOSE")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//            }
//            
//            
//            Text("ALL ORDERS FOR COMPANY VIEW")
//            
//            ForEach(ordersViewModel.snapshotOfOrders) { order in
//                HStack {
//                    Text(order.orderID)
//                    Text(order.item_firstItemTitle)
//                }
//                
//            }
//            
//            
//        }.onAppear {
//            self.ordersViewModel.snapshotOfOrders(userID: userID, companyID: companyID)
//        }
//        
//        
//    }
//}
//
