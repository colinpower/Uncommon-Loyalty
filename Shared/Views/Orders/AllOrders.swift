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
        NavigationView {
            ZStack {
                Color("Background")
                
                ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    SheetHeader(title: "All Orders", isActive: $isShowingAllOrders)
                    
                    ForEach(ordersViewModel.snapshotOfAllOrders) { order in
                        OrderForAllOrdersViews(orderSnapshot: order)
                        
                    }
                    
                    
                }.onAppear {
                    self.ordersViewModel.snapshotOfAllOrders(userID: userID)
                }
            }
            }
                .ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
        
    }
}

struct AllOrders_Previews: PreviewProvider {
    static var previews: some View {
        AllOrders(userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2", isShowingAllOrders: .constant(true))
    }
}




struct OrderForAllOrdersViews: View {
    
    //Required variables to be passed
    
    
    @State var orderSnapshot: Orders
    
    var body: some View {
        VStack(spacing: 0) {
            
            //Header
            HStack {
                Text(orderSnapshot.companyID)
                Spacer()
                Text("Details")
            }.padding()
                .background(.red)
            
            VStack {
            
                //$ / Points
                HStack {
                    VStack(alignment: .leading) {
                        Text("$" + String(orderSnapshot.totalPrice))
                        Text("Total Price")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(String(orderSnapshot.pointsEarned))
                        Text("Points Earned")
                    }
                }.padding(.trailing)
                
                Divider().padding(.vertical)
                
                // Number, Date, Return
                HStack {
                    Text("Order Number")
                    Spacer()
                    Text("#42255")
                }.padding(.bottom)
                
                HStack {
                    Text("Ordered on")
                    Spacer()
                    Text("Aug 06")
                }.padding(.bottom)
                
                HStack {
                    Text("Days to return")
                    Spacer()
                    Text("4 days")
                }
                
                Divider().padding(.vertical)
                
                //Subheader
                HStack {
                    Text("Items")
                    Spacer()
                    Text("Details")
                }
                
                //Items loop through
                ForEach(orderSnapshot.itemIDs, id: \.self) { itemID in
                    
                    NavigationLink(destination: ItemForOrder(userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2",email: orderSnapshot.email, companyID: orderSnapshot.companyID, itemID: itemID)) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 18))
                            Text(itemID)
                            Spacer()
                            Text("View")
                        }.navigationTitle("")
                        .navigationBarHidden(true)
                    }
                }
            }.padding(.horizontal)
                .padding(.bottom)
                .background(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        //.background(RoundedRectangle(cornerRadius: 24))
        .padding()
        
        
    }
}
