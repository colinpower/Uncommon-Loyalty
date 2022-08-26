//
//  Earn.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI


struct Earn: View {
    
    @ObservedObject var viewModel = AppViewModel()
    
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                //MARK: TITLE
                PageHeader(isProfileActive: $isProfileActive, pageTitle: "Earn")
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        //Title
                        HStack {
                            Text("Latest Rewards")
                                .font(.system(size: 32))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Text("See all")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.blue))
                        }.padding(.horizontal)
                        
                        Text("Earn points for reviewing recent purchases or referring favorite items to your friends.")
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Gray1"))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(8)
                            .frame(width: UIScreen.main.bounds.width/4*3)
                            .padding(.horizontal)
                        
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 16) {
                                ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(5)) { item in
                                
                                    NavigationLink {
                                        IntentToReview(itemObject: item)
                                    } label: {

//                                        ZStack(alignment: .topLeading) {

                                            //Picture + Description on bottom
                                            VStack(spacing:0) {
                                                Image("redshorts")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(30)
                                                    .padding()
                                                    .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 8) {
                                                        Text("Joggers 2.0")
                                                            .font(.system(size: 20))
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(Color("Dark1"))
                                                        Text("From Lululemon".uppercased())
                                                            .font(.system(size: 14))
                                                            .fontWeight(.regular)
                                                            .foregroundColor(Color("Gray1"))
                                                    }
                                                    Spacer()
                                                    VStack (alignment: .center, spacing: 2) {
                                                        Text("Review".uppercased())
                                                            .font(.system(size: 16))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(Color(.blue))
                                                            .padding(.horizontal, 16)
                                                            .padding(.vertical, 6)
                                                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))
                                                        HStack(alignment: .center, spacing: 6) {
                                                            Image(systemName: "clock")
                                                                .font(.system(size: 10, weight: .regular))
                                                                .foregroundColor(Color("Gray1"))
                                                            Text("30s")
                                                                .font(.system(size: 12, weight: .regular))
                                                                .foregroundColor(Color("Gray1"))
                                                        }
                                                    }
                                                }.padding()
                                                .frame(width: UIScreen.main.bounds.width/3*2)
                                                .background(.white, in: Rectangle())

                                            }
                                            //Company name in top left corner
//                                            Text("+250 POINTS")
//                                                .font(.system(size: 16))
//                                                .fontWeight(.semibold)
//                                                .padding()
//                                                .foregroundColor(.white)
//                                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(.blue)))
//                                        }
                                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(.white)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
                                        .padding(.vertical, 32)
                                    }
                                }
                                    
                            }.padding(.leading)
                        }
                        .padding(.vertical)
                        
                        //Title
                        HStack {
                            Text("Recent Orders")
                                .font(.system(size: 32))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                            Text("See all")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.blue))
                        }.padding(.horizontal)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 16) {
                                ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(5)) { item in
                                
                                    NavigationLink {
                                        IntentToReview(itemObject: item)
                                    } label: {

                                        ZStack(alignment: .topLeading) {

                                            //Picture + Description on bottom
                                            VStack(spacing:0) {
                                                Image("redshorts")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .cornerRadius(30)
                                                    .padding()
                                                    .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 8) {
                                                        Text("Joggers 2.0")
                                                            .font(.system(size: 20))
                                                            .fontWeight(.semibold)
                                                            .foregroundColor(Color("Dark1"))
                                                        Text("From Lululemon".uppercased())
                                                            .font(.system(size: 14))
                                                            .fontWeight(.regular)
                                                            .foregroundColor(Color("Gray1"))
                                                    }
                                                    Spacer()
                                                    VStack (alignment: .center, spacing: 2) {
                                                        Text("Review".uppercased())
                                                            .font(.system(size: 16))
                                                            .fontWeight(.bold)
                                                            .foregroundColor(Color(.blue))
                                                            .padding(.horizontal, 16)
                                                            .padding(.vertical, 6)
                                                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))
                                                        HStack(alignment: .center, spacing: 6) {
                                                            Image(systemName: "clock")
                                                                .font(.system(size: 10, weight: .regular))
                                                                .foregroundColor(Color("Gray1"))
                                                            Text("30s")
                                                                .font(.system(size: 12, weight: .regular))
                                                                .foregroundColor(Color("Gray1"))
                                                        }
                                                    }
                                                }.padding()
                                                .frame(width: UIScreen.main.bounds.width/3*2)
                                                .background(.white, in: Rectangle())

                                            }
                                            //Company name in top left corner
                                            Text("+250 POINTS")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .padding()
                                                .foregroundColor(.white)
                                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(.blue)))
                                        }
                                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(.blue).opacity(0.1)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(.blue), lineWidth: 4)
                                        ).padding(.vertical)
                                        
                                    }
                                }
                                    
                            }.padding(.leading)
                        }
                            .padding(.vertical, 32)
                        
                        Spacer()
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                MyTabView(selectedTab: $selectedTab)
                
            }.ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
            .onAppear {
                self.itemsViewModel.getSnapshotOfReviewableItems(userID: viewModel.userID ?? "")
                print(self.itemsViewModel.snapshotOfReviewableItems)
            }
        }
    }
            
            
                    
                    
                    
                    //suggestedReviews
                    
            

        
    
}
    
    
    
//    var RecentOrders: some View {
        
        
        //                //MARK: Recent Orders
        //                VStack(alignment: .leading) {
        //
        //                    //Header
        //                    HStack {
        //                        Text("Recent Orders")
        //                            .font(.system(size: 18))
        //                            .fontWeight(.semibold)
        //                            .foregroundColor(Color("Dark1"))
        //                        Spacer()
        //                    }
        //
        //                    //For each recent order, show an item
        //
        //                    ForEach(ordersViewModel.allOrders.prefix(5)) { Order in
        //
        //                        NavigationLink(destination: OneOrder(email: Order.email, companyID: Order.companyID, orderID: Order.orderID)) {
        //                            MyRecentOrdersItem(item: Order.item_firstItemTitle, timestamp: Order.timestamp, reviewID: Order.orderID, colorToShow: Color("Dark1"))
        //                        }
        //                    }
        //                    HStack {
        //                        Spacer()
        //                        Button {
        //                            isShowingAllOrders = true
        //                        } label: {
        //                            Text("See all")
        //                                .font(.system(size: 16))
        //                                .fontWeight(.semibold)
        //                                .foregroundColor(Color("ThemeAction"))
        //                        }.fullScreenCover(isPresented: $isShowingAllOrders) {
        //                            AllOrders(userID: viewModel.userID ?? "", isShowingAllOrders: $isShowingAllOrders)
        //                        }
        //                        Spacer()
        //                    }
        //                }.padding()
        //                    .padding(.vertical)
        //                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        //                .padding(.horizontal)
        //                .padding(.bottom)
        
        
        
//    }
    
    

struct Earn_Previews: PreviewProvider {
    static var previews: some View {
        Earn(selectedTab: .constant(0))
    }
}
