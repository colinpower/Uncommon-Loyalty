//
//  YourBag.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


struct Purchases: View {
    
    //Required for any tab
    @ObservedObject var viewModel = AppViewModel()
    @Binding var selectedTab:Int
    
    @State var isProfileActive:Bool = false
    
    //Data for this view
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    //Variables for this view
    @State var isShowingTempTabView = false
    
    @State var isShowingContactsList:Bool = false
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 0, alignment: nil),
        GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 0, alignment: nil)
    ]
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT
                ScrollView {
                    
                    VStack(alignment: .center, spacing: 0) {
                        
                        //MARK: MOST POPULAR REFERRALS
                        VStack(alignment: .leading) {
                            
                            //header
                            Text("Where you're most influential")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            
                            //divider
                            Divider().padding(.leading)
                            
                            
                            //content
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 20) {

                                    if itemsViewModel.snapshotOfItemsWithMultipleReferrals.isEmpty {
//                                    if itemsViewModel.myItems.isEmpty {
                                     
                                        ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 11)
                                                .stroke(Color("Background"), lineWidth: 1) //.blur(radius: 2)
                                                .shadow(color: Color.white, radius: 3, x: -4, y: -4)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .clipped()
                                            
                                            Text("You haven't referred any friends yet")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color("Gray2"))
                                                .multilineTextAlignment(.center)
                                                .padding().padding(.horizontal)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 11)
                                                        .stroke(Color("Background"), lineWidth: 3) //.blur(radius: 2)
                                                        .shadow(color: Color("Gray2"), radius: 3, x: 3, y: 3)
                                                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                        .clipped()
                                                )
                                            
                                        }.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                            .clipShape(RoundedRectangle(cornerRadius: 11))
                                        
                                        
                                    } else {
                                        
                                        ForEach(itemsViewModel.snapshotOfItemsWithMultipleReferrals.prefix(10)) { item in
                                            
                                            TopReferralsWidget(item: item)
                                                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                                                .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                            
                                        }
                                    }
                                }.offset(x: 20)
                                .padding(.vertical)
                                .padding(.bottom)
                                .padding(.trailing, 40)
                            }
                            
                        }.padding(.top)
                        
                        //MARK: YOUR RECENT PURCHASES
                        VStack(alignment: .leading) {
                            
                            //header
                            HStack(alignment: .center, spacing: 0) {
                                Text("All of your purchases")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(.leading)
                                    .padding(.bottom, 5)
                                
                                Spacer()
                                
//                                Button {
//                                    //create a fake order
//
//                                    itemsViewModel.createFakeItemForDemo(email: viewModel.email!, userID: viewModel.userID!)
//
//                                } label: {
//
//                                    Text("Create a fake order")
//                                        .font(.system(size: 14, weight: .medium))
//                                        .foregroundColor(Color("ReferPurple"))
//                                        .padding(.trailing)
//                                }
                                
                            }
                            
                            
                            //content
                            LazyVGrid(columns: columns, spacing: 0) {
                                
                                ForEach(itemsViewModel.snapshotOfItems.prefix(10)) { item in
                                    
                                    LazyVGridWidget(item: item)
                                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 + 32)
                                        .background(.white)
                                        .clipShape(Rectangle())
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color("Gray3"), lineWidth: 0.5)
                                        )
                                    
                                }
                                
                            }
                            
                        }.padding(.top).padding(.top)
                    }

                }
                
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            
            
            
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Purchases")
            
            //.ignoresSafeArea()
            //Note: need to ignoreSafeArea, set nav title to "", set barHidden to true in order not to break when returning from a navigationViewChild
            
            //.navigationBarTitleDisplayMode(.inline)
            //.navigationBarTitle("")
            //.navigationBarHidden(true)
            .onAppear {

                
                self.itemsViewModel.getSnapshotOfItems(userID: viewModel.userID ?? "")
                self.itemsViewModel.getSnapshotOfItemsWithMultipleReferrals(userID: viewModel.userID ?? "")
                self.itemsViewModel.getSnapshotOfItemsWith5StarsAndNoReferrals(userID: viewModel.userID ?? "")
                
            }
            .onDisappear {
                
                if self.itemsViewModel.listener_MyItems != nil {
                    print("REMOVING LISTENER FOR MYITEMS")
                    self.itemsViewModel.listener_MyItems.remove()
                }
                
            }
        }
    }
}


struct TopReferralsWidget: View {
    
    var item: Items
    
    @State var backgroundURL:String = ""
    
    var body: some View {
        
        //Link to the Review Interceptor page
        NavigationLink {
            PurchasedItem(item: item)
            
        } label: {

            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    
                    if backgroundURL != "" {
                        WebImage(url: URL(string: backgroundURL)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .padding(.vertical, 20)
                    } else {
                        Image(systemName: "bag.fill")
                            .font(.system(size: 48, weight: .regular))
                            .foregroundColor(Color(.lightGray))
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .padding(.vertical, 20)
                    }
                    Text(item.order.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(item.order.companyName)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.bottom, 20)
                    Text(item.referrals.count == 1 ? String(item.referrals.count) + " Referral" : String(item.referrals.count) + " Referrals")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("ReferPurple"))
                        .padding(.bottom, 20)
                }
                Spacer()
            }
            
        }
        .onAppear {
            
            let backgroundPath = "companies/" + item.ids.companyID + "/items/" + String(item.ids.shopifyProductID) + ".png"
            
            let storage = Storage.storage().reference()
            
            storage.child(backgroundPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.backgroundURL = "\(url!)"
                }
            }

        }
    }
}

struct LazyVGridWidget: View {
    
    var item: Items
    
    @State var backgroundURL = ""
    
    var body: some View {
        
        //Link to the Review Interceptor page
        NavigationLink {
            PurchasedItem(item: item)
            
        } label: {

            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    
                    if backgroundURL != "" {
                        WebImage(url: URL(string: backgroundURL)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .padding(.vertical, 20)
                    } else {
                        Image(systemName: "bag.fill")
                            .font(.system(size: 48, weight: .regular))
                            .foregroundColor(Color(.lightGray))
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .padding(.vertical, 20)
                    }
                    
                    
                    
                    
                    Text(item.order.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(item.order.companyName)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.bottom, 20)
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(0..<5) { i in
                            if i < item.review.rating {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        Spacer()
                    }.font(.system(size: 12, weight: .regular))
                        .frame(height: 12)
                        .padding(.bottom, 20)
                    Text(item.referrals.count == 1 ? String(item.referrals.count) + " Referral" : String(item.referrals.count) + " Referrals")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(item.referrals.count == 0 ? "Gray2" : "ReferPurple"))
                        .padding(.bottom, 20)
                }
                Spacer()
            }
            
        }
        .onAppear {
            
            let backgroundPath = "companies/" + item.ids.companyID + "/items/" + String(item.ids.shopifyProductID) + ".png"
            
            let storage = Storage.storage().reference()
            
            storage.child(backgroundPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.backgroundURL = "\(url!)"
                }
            }

        }
    }
}


