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
    
    
    @State var isPresentingReviewExperience:Bool = false
    
    //Required variables
    var itemID:String? = ""
    
    var item: Items?
    
    
    var body: some View {
        
        
        
        
//        ScrollView {
        VStack {
            
            //Figure out whether you have the itemID or the whole object, and set the value for "itemObject" accordingly??? how to do this without rewriting if else statements every time?
            
            ScrollView {
                
                VStack {
                    
                    //MARK: IMAGE SECTION
                    VStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .center, spacing: 0) {
                            
                            //IMAGE
                            HStack {
                                Spacer()
                                Image("redshorts")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.width * 2/3, alignment: .center)
                                Spacer()
                            }
                            
                            //DIVIDER
                            Divider().padding(.horizontal)
                                .padding(.vertical, 2)
                            
                            //HEADER OF IMAGE
                            HStack (alignment: .center, spacing: 0) {
                                
                                //MARK: COMPANY ICON
                                Image("Athleisure LA")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24, alignment: .center)
                                    .clipped()
                                    .cornerRadius(4)
                                    .padding(.trailing, 12)
                                
                                //MARK: ITEM NAME
                                Text(itemsViewModel.oneItem.first?.title ?? "No item name")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color("Dark1"))
                                    .frame(height: 20, alignment: .center)
                                
                                Spacer()
                                
                                //MARK: RATING
                                
                                if itemsViewModel.oneItem.first?.reviewRating == 5 {
                                    
                                    HStack(alignment: .center, spacing: 8) {
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                    }.font(.system(size: 18, weight: .regular))
                                        .foregroundColor(Color.yellow)
                                        .frame(height: 20)
                                } else {
                                    HStack(alignment: .center, spacing: 4) {
                                        Image(systemName: "star")
                                        Image(systemName: "star")
                                        Image(systemName: "star")
                                        Image(systemName: "star")
                                        Image(systemName: "star")
                                    }.font(.system(size: 18, weight: .regular))
                                        .foregroundColor(Color.gray)
                                        .frame(height: 20, alignment: .center)
                                }
                                
                                
                                
                                
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .frame(height: 44, alignment: .center)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                        .padding(.horizontal)
                        
                    }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 5, alignment: .center)
                        .padding(.vertical)
                    
                    //MARK: REVIEW & REFER BUTTONS
                    
                    if itemsViewModel.oneItem.first?.reviewRating == 0 {   //CHANGE THIS LINE
                        
                        Button {
                            isPresentingReviewExperience = true
                        } label: {
                            HStack {
                                WideReviewButton()
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.white).shadow(radius: 8))
                                    
                            }.padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width)
                            
                        }.sheet(isPresented: $isPresentingReviewExperience) {
                            
                            let item1 = itemsViewModel.oneItem.first
                            
                            ReviewProductCarousel1(isShowingReviewExperience: $isPresentingReviewExperience, item: item1!)
                            
                        }
                        
                    } else {
                        
                        //SHOW THE EQUIVALENT WIDGET FOR REFERRING
                        
                        NavigationLink {
                            
                            //Go to the IntentToReview page
                            if itemID != "" {
                                
                                let itemObject = itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: "")
                                
                                IntentToRefer(itemObject: itemObject)
                                
                            } else {
                                
                                IntentToRefer(itemObject: item!)

                            }
                            
                        } label: {
                            //label
                            
                            HStack {
                                WideReferButton()
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color.white).shadow(radius: 8))
                                    
                            }.padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width)
                            
                        }
                    }
                    
                    
                    //MARK: POINTS EARNED AND PENDING
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Divider().padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Text("Points Earned")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }.padding(.leading)
                        
                        //MARK: CURRENT REVIEWS & REFERRALS
                        HStack(alignment: .center, spacing: 18) {
                            
                            //PURCHASE
                            NavigationLink {
                                //destination
                            } label: {
                                //label
                                PointsEarnedForItemStatsWidget(title: "Purchase", amount: "800", subtitle: "0")
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color("Yoga")).shadow(radius: CGFloat(6)))
                            }
                            
                            //REVIEW
                            NavigationLink {
                                //destination
                            } label: {
                                //label
                                
                                if itemsViewModel.oneItem.first?.reviewRating ?? 0 > 0 {
                                    PointsEarnedForItemStatsWidget(title: "Review", amount: "250", subtitle: "250 Available")
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color("ReviewTeal")).shadow(radius: CGFloat(6)))
                                } else {
                                    PointsEarnedForItemStatsWidget(title: "Review", amount: "0", subtitle: "250 Available")
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(6)))
                                }
                                
                            }
                            
                            
                            //REFERRAL
                            NavigationLink {
                                //destination
                            } label: {
                                //label
                                PointsEarnedForItemStatsWidget(title: "Referrals", amount: "0", subtitle: "Review Required")
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(6)))
                            }
                            
                        }.padding()
                            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                        
                        Divider().padding(.top)
                           
                    }
                    .background(Rectangle().foregroundColor(.white))
                    .padding(.vertical)
                    .padding(.vertical)
                    
                    
                    //MARK: ORDER DETAILS
                    OrderDetailsForItemCard(orderNumber: "#4021", orderDate: 05142022, orderPrice: "$80", linkToConfirmationPage: "Link to confirmation page")
                    
                    
                }
                
                
                
            }

            
            
            
            

        }
//
//
//        List {
//
//            //MARK: ORDER IMAGE + COMPANY SECTION
//            Section {
//
//                //image
//                HStack {
//                    Spacer()
//                    Image("redshorts")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.width * 2/3, alignment: .center)
//                        .clipped()
//                        .cornerRadius(8)
//                    Spacer()
//                }
//
//                //company -> about us page
//                HStack (alignment: .center) {
//
//                    //MARK: COMPANY ICON
//                    Image("Athleisure LA")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 40, height: 40, alignment: .center)
//                        .clipped()
//                        .cornerRadius(8)
//                        .padding(.trailing, 6)
//                        .padding(.bottom, 5)
//
//                    //MARK: COMPANY NAME AND STATUS
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text("Athleisure LA")
//                            .foregroundColor(Color("Dark1"))
//                            .font(.system(size: 16, weight: .medium))
//                        Text("Joggers 2.0")
//                            .font(.system(size: 14, weight: .regular))
//                            .foregroundColor(Color("Gray1"))
//                    }
//
//                    Spacer()
//
//                    //MARK: RATING
//
//                    if itemID != "" {
//                        HStack(alignment: .center) {
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                        }.font(.system(size: 12, weight: .regular))
//                        .foregroundColor(Color.yellow)
//                        .frame(height: 20)
//                    } else {
//                        HStack(alignment: .center) {
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                        }.font(.system(size: 12, weight: .regular))
//                        .foregroundColor(Color.yellow)
//                        .frame(height: 20)
//                    }
//
//            }
//            }
//
//            //MARK: "POINTS EARNED" SECTION
//            Section(header: Text("Points Earned: 1000")) {
//
//                //for purchase
//                NavigationLink {
//                    ProfileTEMP()
//                } label: {
//                    PointsEarnedSectionRow(image: "dollarsign.circle", imageColor: Color.green, title: "Purchase - Pending", subtitle: "10 points per dollar", points: "800", isEnabled: true)
//                }
//
//                //for review
//                NavigationLink  {
//
//                    if itemID != "" {
//                        IntentToReview(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
//                    } else {
//                        IntentToReview(itemObject: item!)
//                    }
//
//
//                } label: {
//                    PointsEarnedSectionRow(image: "star.circle.fill", imageColor: Color("ReviewTeal"), title: "Review", subtitle: "Up to 250 points", points: "200", isEnabled: true)
//                }
//
//                //for referral
//                NavigationLink  {
//                    IntentToRefer(itemObject: itemsViewModel.snapshotOfItem.first ?? Items(companyID: "", domain: "", email: "", itemID: "", name: "", orderID: "", price: "", quantity: 0, referred: false, reviewID: "", reviewRating: 0, shopifyItemID: 0, status: "", timestamp: 0, title: "", userID: ""))
//                } label: {
//                    PointsEarnedSectionRow(image: "paperplane.circle.fill", imageColor: Color("ReferPurple"), title: "Referral", subtitle: "15K points per referral", points: "15000", isEnabled: false)
//                }
//
//            }
//
//            //MARK: ORDER SECTION
//            Section(header: Text("Order Details")) {
//
//                //order #
//                OrderSectionRow(title: "Order Number", description: "#2300")
//
//                //date
//                OrderSectionRow(title: "Date", description: String(itemsViewModel.snapshotOfItem.first?.timestamp ?? 0))
//
//                //status
//                OrderSectionRow(title: "Status", description: itemsViewModel.snapshotOfItem.first?.status ?? "")
//
//                //return by
//                NavigationLink {
//                    ProfileTEMP()
//                } label: {
//                    OrderSectionRow(title: "Return by", description: "Timestamp + 30")
//                }
//
//            }
//
//            //MARK: ITEM SECTION
//            Section(header: Text("Item Details")) {
//
//                //price
//                OrderSectionRow(title: "Price", description: itemsViewModel.snapshotOfItem.first?.price ?? "")
//
//                //sku
//                OrderSectionRow(title: "SKU", description: "Black")
//
//            }
//
//            //MARK: CONTACT US SECTION
//            Section {
//                Button {
//
//                } label: {
//                    Text("Contact")
//                }
//            }
//
//            //MARK: VISIT WEBSITE SECTION
//            Section {
//                HStack {
//                    Link(destination: URL(string: "https://athleisure-la.myshopify.com")!) {
//                        Text("Open website")
//                    }
//                }
//            }
//
//        }
        .background(Color("Background"))
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle(itemsViewModel.snapshotOfItem.first?.title ?? "Item", displayMode: .inline)
        .onAppear {
            if itemID != "" {
                self.itemsViewModel.listenForOneItem(email: viewModel.email ?? "", itemID: itemID!)
            } else {
                self.itemsViewModel.listenForOneItem(email: viewModel.email ?? "", itemID: item?.itemID ?? "")
            }
            
        }
        .onDisappear {
            
            if self.itemsViewModel.listener_OneItem != nil {
                print("REMOVING LISTENER FOR ONE ITEM")
                self.itemsViewModel.listener_OneItem.remove()
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




struct PointsEarnedForItemStatsWidget: View {
    
    var title:String
    var amount:String
    var subtitle:String
    
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            VStack(alignment: .center, spacing: 0) {
                
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                    .padding(.top, 16)
                    .padding(.bottom, 10)
                
                Text(amount)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(amount == "0" ? Color("Gray1") : Color("Dark1"))
                    .padding(.bottom, 6)
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(subtitle.prefix(1) == "0" ? Color(.white) : Color("Gray1"))
                    .padding(.bottom, 16)
            }
            
            Spacer()
            
        }.frame(height: 106)
    }
}


struct ReviewAndReferButtons: View {
    
    var buttonText:String
    
    var body: some View {
            
            HStack(spacing: 0) {
                Spacer()
                Text(buttonText)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("Dark1"))
                Spacer()
            }.frame(height: 48)
    }
}


struct WideReviewButton: View {
    
    var title:String = "What did you think?"
    var subtitle:String = "Earn 250 points"
    
    var buttonText:String = "Review"
    
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                    
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("ReviewTeal"))
                    
                }.padding(.vertical, 12)
                    .frame(height: 60)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal).padding(.horizontal, 10)
                    .clipShape(Capsule())
                    .background(Capsule().foregroundColor(Color("ReviewTeal")))
                    .padding(.vertical, 11)
                    .frame(height: 60, alignment: .center)
                
            }.frame(height: 60)
    }
}

struct WideReferButton: View {
    
    var title:String = "Give a friend $20"
    var subtitle:String = "Earn 20,000 points!"
    
    var buttonText:String = "Refer"
    
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                    
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("ReferPurple"))
                    
                }.padding(.vertical, 12)
                    .frame(height: 60)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal).padding(.horizontal, 10)
                    .clipShape(Capsule())
                    .background(Capsule().foregroundColor(Color("ReferPurple")))
                    .padding(.vertical, 11)
                    .frame(height: 60, alignment: .center)
                
            }.frame(height: 60)
    }
}







//MARK: ORDER DETAILS

struct OrderDetailsForItemCard: View {
    
    var orderNumber: String
    var orderDate: Int
    var orderPrice: String
    var linkToConfirmationPage: String
    
    var body: some View {
            
        //MARK: MY SHOPS CONTENT
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Order Details")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("Dark1"))
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 0) {
                
                //ORDER NUMBER
                HStack(alignment: .center) {
                    
                    Text("Order Number")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 10)
                    Spacer()
                    Text(orderNumber)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Gray2"))
                    
                }.padding(.horizontal)
                
                Divider().padding(.leading)
                
                //ORDER DATE
                HStack(alignment: .center) {
                    
                    Text("Order Date")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 10)
                    Spacer()
                    Text(String(orderDate))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Gray2"))
                    
                }.padding(.horizontal)
                
                Divider().padding(.leading)
                
                //ORDER PRICE
                HStack(alignment: .center) {
                    
                    Text("Price")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 10)
                    Spacer()
                    Text(orderPrice)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("Gray2"))
                    
                }.padding(.horizontal)
                
                Divider().padding(.leading)
                
                //LINK TO ORDER CONFIRMATION
                HStack(alignment: .center) {
                    
                    Text("Link to order confirmation")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.blue)
                        .padding(.vertical, 10)
                    Spacer()
                    
                    
                }.padding(.horizontal)
                    
                
                
            }
        }
        .padding().padding(.bottom)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 7)
        )
        .padding(.horizontal)
    }
    
}

