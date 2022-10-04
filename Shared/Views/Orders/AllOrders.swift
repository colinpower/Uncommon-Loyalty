////
////  Orders_All.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 8/22/22.
////
//
//import SwiftUI
//
//struct AllOrders: View {
//    
//    //Initialize the view with the following variables
//    @EnvironmentObject var viewModel: AppViewModel
//    @Binding var selectedTab: Int
//    
//    //Getting the data for this view
//    @StateObject var ordersViewModel = OrdersViewModel()
//    
//    //@State var isProfileActive = false
//    
//    
//    //Required variables to be passed
//    //var userID: String
//    
//    //@Binding var isShowingAllOrders: Bool
//    
//
//
//    
//    
//    var body: some View {
//                
//        VStack(alignment: .center, spacing: 0) {
//            
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: 0) {
//                    
//                    //MARK: TOP SECTION
//                    VStack(alignment: .leading) {
//                        
//                        Divider().padding(.leading)
//                        
//                        HStack {
//                            Text("Here's a list of your recent orders. Tap on an item to see more details.")
//                                .font(.system(size: 18, weight: .regular))
//                                .foregroundColor(Color("Dark1"))
//                                .lineSpacing(6)
//                                .multilineTextAlignment(.leading)
//                        }.padding()
//                        .padding(.bottom)
//                        
//                        Divider().padding(.leading).padding(.bottom)
//                        
//                    }
//                    
//                    
//                    VStack {
//                        ForEach(ordersViewModel.snapshotOfAllOrders) { order in
//                            
//                            //title
//                            VStack {
//                                //This is the title of the order
//                                AllOrdersSingleOrderTitle()
//                                AllOrdersSingleItemView(order: order)
//                                //This is the set of items in the order
//                                
//                                
//                            }.padding(.bottom)
//                        }
//                    }.padding(.horizontal)
//                }
//                
//            }
//        }.background(Color("Background"))
//            .edgesIgnoringSafeArea([.bottom, .horizontal])
//            .navigationTitle("Orders")
//            .navigationBarTitleDisplayMode(.inline)
////            .background(Color("Background"))
////            .ignoresSafeArea()
////            .navigationTitle("")
////            .navigationBarHidden(true)
//            .onAppear {
//                self.ordersViewModel.snapshotOfAllOrders(userID: viewModel.userID ?? "")
//            }
//    }
//}
//
//struct AllOrders_Previews: PreviewProvider {
//    static var previews: some View {
//        AllOrders(selectedTab: .constant(1))//userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2") //, isShowingAllOrders: .constant(true))
//    }
//}
//
//
//struct AllOrdersSingleOrderTitle: View {
//
//    var body: some View {
//
//        HStack(alignment: .bottom, spacing: 0) {
//            Image("Athleisure LA")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 24, height: 24, alignment: .center)
//                .clipped()
//                .cornerRadius(6)
//                .padding(.trailing, 10)
//            Text("August 6")
//                .font(.system(size: 20))
//                .fontWeight(.medium)
//                .foregroundColor(Color("Dark1"))
//            Spacer()
//        }.padding(.bottom, 4)
//    }
//
//}
//
//
//struct AllOrdersMainContentOfItem: View {
//    
//    var firstItemTitle: String
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Text("Athleisure LA")
//                .font(.system(size: 13))
//                .fontWeight(.regular)
//                .foregroundColor(Color("Dark2"))
//                .padding(.bottom, 3)
//            Text(firstItemTitle)
//                .font(.system(size: 16))
//                .fontWeight(.semibold)
//                .foregroundColor(Color("Dark1"))
//                .padding(.bottom, 8)
//            HStack(alignment: .center, spacing: 0) {
//                Text("Status: ")
//                    .font(.system(size: 12))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("Delivered")
//                    .font(.system(size: 12))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Dark2"))
//            }.padding(.bottom, 4)
//            HStack(alignment: .center, spacing: 0) {
//                Text("Points Earned: ")
//                    .font(.system(size: 12))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("900 / 20K")
//                    .font(.system(size: 12))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Dark2"))
//            }
//        }
//        
//    }
//    
//    
//}
//
//
//struct AllOrdersSingleItemView: View {
//    
//    var order: Orders
//
//    var body: some View {
//        
//        VStack {
//            ForEach(order.itemIDs, id: \.self) { itemID in
//                
////                NavigationLink(destination: Item(itemID: itemID)) {
////                    HStack {
////                        //image
////                        Image("redshorts")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 100, height: 100, alignment: .center)
////                            .clipped()
////                            .cornerRadius(8)
////                            .padding(.trailing)
////
////                        //main content
////                        AllOrdersMainContentOfItem(firstItemTitle: order.item_firstItemTitle)
////
////                        //spacer + arrow
////                        Spacer()
////
////                        Image(systemName: "chevron.right")
////                            .font(.system(size: 16, weight: .medium))
////                            .foregroundColor(.gray.opacity(0.6))
////
////                    }.padding(.all)
////                }
//                
//                //if there's only one item... or it's the last item in the order, don't add a divider
//                if (order.itemIDs.count < 2) || (itemID == order.itemIDs[order.itemIDs.count-1]) {
//                    
//                } else {
//                    
//                    //Else, add the divider to separate individual orders
//                    Divider().padding(.leading)
//                     
//                }
//                
//            }
//        }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
////        .navigationTitle("")
////        .navigationBarHidden(true)
//        
//        
//        
//    }
//    
//    
//}
//
//
////struct OrderForAllOrdersViews: View {
////
////    //Required variables to be passed
////
////
////    @State var orderSnapshot: Orders
////
////    var body: some View {
////        VStack(spacing: 0) {
////
////            //Header
////            HStack {
////                Text(orderSnapshot.companyID)
////                Spacer()
////                Text("Details")
////            }.padding()
////                .background(.red)
////
////            VStack {
////
////                //$ / Points
////                HStack {
////                    VStack(alignment: .leading) {
////                        Text("$" + String(orderSnapshot.totalPrice))
////                        Text("Total Price")
////                    }
////                    Spacer()
////                    VStack(alignment: .leading) {
////                        Text(String(orderSnapshot.pointsEarned))
////                        Text("Points Earned")
////                    }
////                }.padding(.trailing)
////
////                Divider().padding(.vertical)
////
////                // Number, Date, Return
////                HStack {
////                    Text("Order Number")
////                    Spacer()
////                    Text("#42255")
////                }.padding(.bottom)
////
////                HStack {
////                    Text("Ordered on")
////                    Spacer()
////                    Text("Aug 06")
////                }.padding(.bottom)
////
////                HStack {
////                    Text("Days to return")
////                    Spacer()
////                    Text("4 days")
////                }
////
////                Divider().padding(.vertical)
////
////                //Subheader
////                HStack {
////                    Text("Items")
////                    Spacer()
////                    Text("Details")
////                }
////
////                //Items loop through
////                ForEach(orderSnapshot.itemIDs, id: \.self) { itemID in
////
////                    NavigationLink(destination: ItemForOrder(itemID: itemID)) {
////                        HStack {
////                            Image(systemName: "checkmark.circle")
////                                .font(.system(size: 18))
////                            Text(itemID)
////                            Spacer()
////                            Text("View")
////                        }.navigationTitle("")
////                        .navigationBarHidden(true)
////                    }
////                }
////            }.padding(.horizontal)
////                .padding(.bottom)
////                .background(.white)
////        }
////        .clipShape(RoundedRectangle(cornerRadius: 24))
////        //.background(RoundedRectangle(cornerRadius: 24))
////        .padding()
////
////
////    }
////}
//
//
//
//
//
////EXPLORING A VIEW WHERE YOU SHOW THE NUMBER OF POINTS EARNED ON EACH ORDER
////HStack(alignment: .center, spacing: 0) {
////                        Image(systemName: "heart.fill")
////                            .font(.system(size: 14, weight: .regular))
////                            .foregroundColor(.green)
////                            .padding(.trailing, 2)
////                        Text("900")
////                            .font(.system(size: 14))
////                            .fontWeight(.medium)
////                            .foregroundColor(.green)
////                            .padding(.trailing, 8)
////                        Image(systemName: "star")
////                            .font(.system(size: 14, weight: .regular))
////                            .foregroundColor(.gray)
////                            .padding(.trailing, 2)
////                        Text("250")
////                            .font(.system(size: 14))
////                            .fontWeight(.regular)
////                            .foregroundColor(Color(.gray))
////                            .padding(.trailing, 6)
////                        Image(systemName: "paperplane")
////                            .font(.system(size: 14, weight: .regular))
////                            .foregroundColor(.gray)
////                            .padding(.trailing, 2)
////                        Text("20K")
////                            .font(.system(size: 14))
////                            .fontWeight(.regular)
////                            .foregroundColor(Color(.gray))
////                    }
