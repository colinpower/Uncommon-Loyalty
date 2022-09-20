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
                NavigationLink {
                    AboutCompany() //MARK: NEED TO PASS IN THE ACTUAL COMPANY ID!!
                } label: {
                    HStack {
                    
                        Image("Athleisure LA")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28, alignment: .center)
                            .clipped()
                            .cornerRadius(7)
                            .padding(.horizontal, 2)
                        
                        Text("Athleisure LA")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                    
                }
            }
            }
            
            //MARK: "POINTS EARNED" SECTION
            Section(header: Text("Points Earned")) {
                    
                //for purchase
                NavigationLink {
                    ProfileTEMP()
                } label: {
                    PointsEarnedSectionRow(image: "heart.circle.fill", imageColor: Color.red, title: "Purchase", points: "800", isEnabled: true)
                }

                //for review
                NavigationLink  {
                    
                    if itemID != "" {
                        IntentToReview(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
                    } else {
                        IntentToReview(itemObject: item!)
                    }
                    
                    
                } label: {
                    PointsEarnedSectionRow(image: "star.circle.fill", imageColor: Color("ReviewTeal"), title: "Review", points: "200", isEnabled: true)
                }

                //for referral
                NavigationLink  {
                    IntentToRefer(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
                } label: {
                    PointsEarnedSectionRow(image: "paperplane.circle.fill", imageColor: Color("ReferPurple"), title: "Referral", points: "15000", isEnabled: false)
                }
                
                //total
                HStack {
                    Text("Total")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                    Text("1000")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
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
