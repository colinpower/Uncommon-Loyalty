//
//  Item.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI

struct Item: View {
    
    //Environment
    @EnvironmentObject var viewModel: AppViewModel
    
    //ViewModels
    @StateObject var itemsViewModel = ItemsViewModel()
    
    //State
    @State var selectedTab:Int = 2
    
    //Required variables
    var itemID:String? = ""
    
    var item: Items?
    
    
    var body: some View {
        
        
        
        List {
            
            //MARK: ORDER IMAGE + COMPANY SECTION
            Section {
                
                //image
                HStack {
                    Spacer()
                    Image("redshorts")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.width * 2/3, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                    Spacer()
                }
            
                //company -> about us page
                HStack (alignment: .center) {
                                       
                    //MARK: COMPANY ICON
                    Image("Athleisure LA")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                        .padding(.trailing, 6)
                        .padding(.bottom, 5)
                
                    //MARK: COMPANY NAME AND STATUS
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Athleisure LA")
                            .foregroundColor(Color("Dark1"))
                            .font(.system(size: 16, weight: .medium))
                        Text("Joggers 2.0")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                    }
                
                    Spacer()
                
                    //MARK: RATING
                    
                    if itemID != "" {
                        HStack(alignment: .center) {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                        }.font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.yellow)
                        .frame(height: 20)
                    } else {
                        HStack(alignment: .center) {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                        }.font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.yellow)
                        .frame(height: 20)
                    }
                    
            }
            }
            
            //MARK: "POINTS EARNED" SECTION
            Section(header: Text("Points Earned: 1000")) {
                    
                //for purchase
                NavigationLink {
                    ProfileTEMP()
                } label: {
                    PointsEarnedSectionRow(image: "dollarsign.circle", imageColor: Color.green, title: "Purchase - Pending", subtitle: "10 points per dollar", points: "800", isEnabled: true)
                }

                //for review
                NavigationLink  {
                    
                    if itemID != "" {
                        IntentToReview(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
                    } else {
                        IntentToReview(itemObject: item!)
                    }
                    
                    
                } label: {
                    PointsEarnedSectionRow(image: "star.circle.fill", imageColor: Color("ReviewTeal"), title: "Review", subtitle: "Up to 250 points", points: "200", isEnabled: true)
                }

                //for referral
                NavigationLink  {
                    IntentToRefer(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
                } label: {
                    PointsEarnedSectionRow(image: "paperplane.circle.fill", imageColor: Color("ReferPurple"), title: "Referral", subtitle: "15K points per referral", points: "15000", isEnabled: false)
                }
                
            }
                        
            //MARK: ORDER SECTION
            Section(header: Text("Order Details")) {
                
                //order #
                OrderSectionRow(title: "Order Number", description: "#2300")
                
                //date
                OrderSectionRow(title: "Date", description: String(itemsViewModel.snapshotOfItem.first?.timestamp ?? 0))
                
                //status
                OrderSectionRow(title: "Status", description: itemsViewModel.snapshotOfItem.first?.status ?? "")
                
                //return by
                NavigationLink {
                    ProfileTEMP()
                } label: {
                    OrderSectionRow(title: "Return by", description: "Timestamp + 30")
                }
                
            }
            
            //MARK: ITEM SECTION
            Section(header: Text("Item Details")) {
                
                //price
                OrderSectionRow(title: "Price", description: itemsViewModel.snapshotOfItem.first?.price ?? "")
                
                //sku
                OrderSectionRow(title: "SKU", description: "Black")

            }
            
            //MARK: CONTACT US SECTION
            Section {
                Button {
                    
                } label: {
                    Text("Contact")
                }
            }
            
            //MARK: VISIT WEBSITE SECTION
            Section {
                HStack {
                    Link(destination: URL(string: "https://athleisure-la.myshopify.com")!) {
                        Text("Open website")
                    }
                }
            }
            
        }
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle(itemsViewModel.snapshotOfItem.first?.title ?? "Item", displayMode: .inline)
        .onAppear {
            if itemID != "" {
                self.itemsViewModel.getSnapshotOfItem(itemID: itemID!)
            }
            
        }
    }
}


struct PointsEarnedSectionRow: View {
    
    var image:String
    var imageColor:Color
    var title:String
    var subtitle:String
    var points:String
    var isEnabled:Bool
    
    
    var body: some View {
        
        HStack {
            Image(systemName: image)
                .font(.system(size: 40))
                .foregroundColor(isEnabled ? imageColor : .gray)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(isEnabled ? .black : .gray)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(isEnabled ? .black : .gray)
            }
            Spacer()
            Text(points)
                .font(.system(size: 16))
                .foregroundColor(isEnabled ? .black : .gray)
        }
    }
}
