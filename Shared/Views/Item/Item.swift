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
//    var itemID:String? = ""
    
    var item: Items
    
    
    var body: some View {
        
//        ScrollView {
        VStack(alignment: .center, spacing: 0) {
            
            //Figure out whether you have the itemID or the whole object, and set the value for "itemObject" accordingly??? how to do this without rewriting if else statements every time?
            
            ScrollView {
                
                VStack(alignment: .center, spacing: 0) {
                    
                    //MARK: IMAGE SECTION
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
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 5, alignment: .center)
                    .padding(.vertical)
                        
                    
                    //MARK: HEADER OF IMAGE
                    VStack (alignment: .leading, spacing: 2) {
                        
                        //MARK: ITEM, COMPANY
                        Text(item.order.title)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                        
                        Text(item.ids.companyID)
                            .underline()
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("Dark1"))
                        
                        //MARK: RATING
                        HStack(alignment: .center, spacing: 1) {
                            
                            let ratingVariable = item.review.rating
                            
                            ForEach(0..<5) { i in
                                if i < ratingVariable {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                        .font(.system(size: 14, weight: .regular))
                                } else {
                                    Image(systemName: "star")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 14, weight: .regular))
                                }
                            }
                            
                            if ratingVariable != 0 {
                                Text("See your review")
                                    .underline()
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.leading, 6)
                            }
                            
                        }
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    
                    //MARK: ORDER DETAILS
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Divider().padding(.bottom).padding(.leading)
                        
                        Text("Order Details")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                Image(systemName: "number.square")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                
                                Text(String(item.order.orderNumber))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("Dark1"))
                            }
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                Image(systemName: "number.square")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                
                                Text(String(item.order.orderNumber))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("Dark1"))
                            }
                            
                            
                        }
                    }
                    
                    OrderDetailsForItemCard(orderNumber: "#4021", orderDate: 05142022, orderPrice: "$80", linkToConfirmationPage: "Link to confirmation page")
                        .padding(.bottom, 100)
                        .background(Rectangle().foregroundColor(Color("Background")))
                    
                    
                    
                    //MARK: POINTS EARNED AND PENDING
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Divider().padding(.bottom).padding(.leading)
                        
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
                                PointsEarnedForItemStatsWidget(title: "Purchase", amount: "800", subtitle: "")
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color("Yoga")).shadow(radius: CGFloat(6)))
                            }
                            
                            //REVIEW
                                
                            if item.review.rating > 0 {
                                
                                NavigationLink {
                                    //destination
                                } label: {
                                    //label
                                    PointsEarnedForItemStatsWidget(title: "Review", amount: "250", subtitle: "")
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(Color("ReviewTeal")).shadow(radius: CGFloat(6)))
                                }
                                
                            } else {
                                PointsEarnedForItemStatsWidget(title: "Review", amount: "0", subtitle: "250 Available")
                                    .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(6)))
                            }
                            
                            
                            //REFERRAL
                            
                            //IF THERE IS NO REVIEW YET
                            if item.review.rating == 0 {
                                
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Color("Background"), lineWidth: 1) //.blur(radius: 2)
                                        .shadow(color: Color.white, radius: 3, x: -4, y: -4)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .clipped()
                                        
                                    
                                    Text("Missing review. Can't refer yet.")
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("Gray2"))
                                        .multilineTextAlignment(.center)
                                        .padding(.all, 6)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 11)
                                                .stroke(Color("Background"), lineWidth: 2) //.blur(radius: 2)
                                                .shadow(color: Color("Gray2"), radius: 2, x: 2, y: 2)
                                                .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                                .clipped()
                                        )
                                    
                                }.frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                
                            }
                            //IF THERE IS A REVIEW WITH 5 STARS
                            else if item.review.rating ?? 0 == 5 {
                                
                                NavigationLink {
                                    ReferralTrackerForItem(userID: item.ids.userID, itemID: item.ids.itemID)
                                } label: {
                                    //label
                                    
                                    PointsEarnedForItemStatsWidget(title: "Referrals", amount: String((item.referrals.count) * 20), subtitle: "")
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(6)))
                                    
                                }
                                
                            }
                            //IF THERE IS A REVIEW WITH < 5 STARS
                            else {
                                
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Color("Background"), lineWidth: 1) //.blur(radius: 2)
                                        .shadow(color: Color.white, radius: 3, x: -4, y: -4)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .clipped()
                                        
                                    
                                    Text("Referral Unavailable")
                                        .font(.system(size: 12))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("Gray2"))
                                        .multilineTextAlignment(.center)
                                        .padding(.all, 6)
                                        .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 11)
                                                .stroke(Color("Background"), lineWidth: 2) //.blur(radius: 2)
                                                .shadow(color: Color("Gray2"), radius: 2, x: 2, y: 2)
                                                .frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                                .clipped()
                                        )
                                    
                                }.frame(width: UIScreen.main.bounds.width * 3 / 11, height: 106)
                                    .clipShape(RoundedRectangle(cornerRadius: 11))
                                
                            }
                            
                        }.padding()
                            .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                        
                        Divider().padding(.top)
                           
                    }
                    .padding(.vertical)
                    .padding(.vertical)
                    .background(Rectangle().foregroundColor(Color("Background")))
                    
                    
                    
                    
                }
                
                
                
            }
            
            //MARK: REVIEW & REFER BUTTONS
            //IF THERE IS NO REVIEW WRITTEN YET
            if itemsViewModel.oneItem.first?.review.rating ?? -1 == 0 {
                
                Button {
                    isPresentingReviewExperience = true
                } label: {
                    HStack {
                        WideReviewButton()
                            .padding(.horizontal).padding(.horizontal)
                            .padding(.vertical, 5)
                            //.background(Color.white).shadow(radius: 8))
                            
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width, height: 90)
                    .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
                    
                }.sheet(isPresented: $isPresentingReviewExperience) {
                    
                    ReviewProductCarousel1(isShowingReviewExperience: $isPresentingReviewExperience, item: item)
                    
                }
            
            }
            //IF THERE IS A 5 STAR REVIEW
            else if itemsViewModel.oneItem.first?.review.rating ?? -1 == 5 {
                
                //SHOW THE EQUIVALENT WIDGET FOR REFERRING
                
//                Button {
//                    isPresentingReviewExperience = true
//                } label: {
//                    HStack {
//                        WideReviewButton()
//                            .padding(.horizontal).padding(.horizontal)
//                            .padding(.vertical, 5)
//                            //.background(Color.white).shadow(radius: 8))
//
//                    }
//                    .padding(.top, 10)
//                    .padding(.bottom, 20)
//                    .frame(width: UIScreen.main.bounds.width, height: 90)
//                    .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
//
//                }.sheet(isPresented: $isPresentingReviewExperience) {
//
//                    ReviewProductCarousel1(isShowingReviewExperience: $isPresentingReviewExperience, item: item)
//
//                }
                
                
                
                NavigationLink {
                    
                    //Go to the IntentToReview page
                    IntentToRefer(itemObject: item)

                    
                } label: {
                    //label
                    
                    HStack {
                        WideReferButton()
                            .padding(.horizontal).padding(.horizontal)
                            .padding(.vertical, 5)
                            //.background(Color.white).shadow(radius: 8))

                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .frame(width: UIScreen.main.bounds.width, height: 90)
                    .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
                    
                }
            }

        }

        .background(Color.white)
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle(itemsViewModel.snapshotOfItem.first?.order.title ?? "Item", displayMode: .inline)
        .onAppear {
            
            self.itemsViewModel.listenForOneItem(userID: item.ids.userID, itemID: item.ids.itemID)
            
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

