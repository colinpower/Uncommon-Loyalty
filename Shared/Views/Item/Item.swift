//
//  Item.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI


//MARK: HACK necessary to get the right sheet up
enum ActiveReviewOrReferSheet: String, Identifiable { // <--- note that it's now Identifiable
    case reviewSheet, referSheet
    var id: Int {
        hashValue
    }
}



struct Item: View {
    
    //Environment
    @EnvironmentObject var viewModel: AppViewModel
    
    //ViewModels
    @StateObject var itemsViewModel = ItemsViewModel()
    
    //State
    @State var selectedTab:Int = 2
    
    
    //@State var isPresentingReviewExperience:Bool = false
    
    
    var item: Items
    
    
    @State private var activeReviewOrReferSheet: ActiveReviewOrReferSheet? = nil
    @State var showReviewOrReferSheet:Bool = false
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Figure out whether you have the itemID or the whole object, and set the value for "itemObject" accordingly??? how to do this without rewriting if else statements every time?
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 2 / 3, alignment: .center)
                    .padding(.top, 72)
                    .background(.white)
                        
                    //MARK: HEADER OF IMAGE
                    HStack {
                        
                        VStack (alignment: .leading, spacing: 3) {
                            
                            //MARK: ITEM, COMPANY
                            Text(item.order.title)
                                .font(.system(size: 26, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                                .padding(.bottom, 2)
                            
                            //MARK: COMPANY NAME
                            NavigationLink {
                                AboutCompany()
                            } label: {
                                Text("From ")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                +
                                Text(companyName)
                                    .underline()
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color("Dark1"))
                            }
                            
                                
                            
                            //MARK: RATING
                            HStack(alignment: .center, spacing: 1) {
                                
                                let ratingVariable = itemsViewModel.oneItem.first?.review.rating ?? -1
                                let referralsVariable = itemsViewModel.oneItem.first?.referrals.count ?? -1
                                
                                ForEach(0..<5) { i in
                                    if i < ratingVariable {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color.yellow)
                                            .font(.system(size: 13, weight: .regular))
                                    } else {
                                        Image(systemName: "star")
                                            .foregroundColor(Color.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    }
                                }
                                
                                if ratingVariable != 0 {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 3, weight: .regular))
                                        .foregroundColor(Color("Dark2"))
                                        .padding(.horizontal, 4)
                                    
                                    NavigationLink {
                                        CompletedReviewPage()
                                    } label: {
                                        Text("Read your review")
                                            .underline()
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color("Dark1"))
                                    }
                                    
                                }
                                
                                if referralsVariable > 0 {
                                    
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 3, weight: .regular))
                                        .foregroundColor(Color("Dark2"))
                                        .padding(.horizontal, 4)
                                    
                                    NavigationLink {
                                        ReferralTrackerForItem(userID: item.ids.userID, itemID: item.ids.itemID, itemTitle: item.order.title)
                                    } label: {
                                        
                                        if referralsVariable == 1 {
                                            
                                            Text("Track your Referral")
                                                .underline()
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(Color("Dark1"))
                                            
                                        } else {
                                            
                                            Text("Track your " + String(referralsVariable) + " Referrals")
                                                .underline()
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(Color("Dark1"))
                                            
                                        }
                                    }
                                }
                            }.padding(.top, 6)
                            
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.leading, 8)
                    .padding(.vertical, 10)
                    
                    
                    Divider().padding(.horizontal).padding(.horizontal, 8)
                    

                    VStack(alignment: .leading, spacing: 0) {
                        
                        let ratingVariable1 = itemsViewModel.oneItem.first?.review.rating ?? -1
                        
                        if ratingVariable1 == 0 {
                            
                            Button {
                                self.activeReviewOrReferSheet = .reviewSheet
                                showReviewOrReferSheet = true
                            } label: {
                                
                                HStack(alignment: .center, spacing: 0) {
                                    Group {
                                        Text("Write a review? ")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color("Dark1"))
                                        +
                                        Text("Let us know how you're liking this item. You can refer friends afterwards.")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(Color("Dark1"))
                                    }.multilineTextAlignment(.leading)
                                    
                                    
                                    Spacer()
                                    
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundColor(Color("ReviewTeal").opacity(0.5))
                                        .padding(.bottom, 10)
                                }
                                
                            }.padding()
                            .padding(.horizontal, 8)
                            
                        } else if ratingVariable1 == 5 {
                            
                            Button {
                                self.activeReviewOrReferSheet = .referSheet
                                showReviewOrReferSheet = true
                            } label: {
                                
                                HStack(alignment: .center, spacing: 0) {
                                    Group {
                                        Text("Refer a friend. ")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color("Dark1"))
                                        +
                                        Text("Thanks for your awesome review! Do you think any of your friends would like it too?")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(Color("Dark1"))
                                    }.multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "paperplane.fill")
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundColor(Color("ReferPurple").opacity(0.5))
                                        .padding(.bottom, 10)
                                    
                                }.padding()
                                .padding(.horizontal, 8)
                            }
                        }
                    }
                    
                    .padding(.vertical, 10)
                    
                    
                    Divider().padding(.horizontal).padding(.horizontal, 8)
                    
                    
                    //MARK: ORDER DETAILS
                    HStack {
                            
                        VStack(alignment: .leading, spacing: 20) {
                            
                            OrderDetailsIconAndTextRow(icon: "number.square", title: "Order #" + String(item.order.orderNumber), subtitle: "Use this number for tracking and exchanges.")
                            
                            OrderDetailsIconAndTextRow(icon: "calendar", title: convertTimestampToString(timestamp: item.order.timestamp), subtitle: "You ordered on this date.")
                            
                            OrderDetailsIconAndTextRow(icon: "dollarsign.square", title: "$" + item.order.price, subtitle: "The price of this item without tax or shipping.")
                            
                            let returnEndDate = item.order.returnPolicyInDays * 24 * 60 * 60 + item.order.timestamp
                            
                            OrderDetailsIconAndTextRow(icon: "airplane.circle", title: "Return by " + convertTimestampToString(timestamp: returnEndDate), subtitle: companyName + "'s return policy is " + String(item.order.returnPolicyInDays) + " days from purchase.")
                            
                            OrderDetailsIconAndLinkRow(icon: "arrow.up.forward", linkTitle: "View order confirmation page", link: item.order.orderStatusURL, subtitle: "View more details in your browser.")
                            
                        }
                        
                        Spacer()
                        
                    }.padding()
                    .padding(.leading, 8)
                    .padding(.vertical, 10)
                    .padding(.bottom, 60)
                    
                }
                
                
                
            }
            
            //MARK: REVIEW & REFER BUTTONS
            
            
            //IF THERE IS NO REVIEW WRITTEN YET
            if itemsViewModel.oneItem.first?.review.rating ?? -1 == 0 {
                
                
                Button {

                    self.activeReviewOrReferSheet = .reviewSheet
                    showReviewOrReferSheet = true
                    
                } label: {
                    WideReviewButton()
                        .padding(.horizontal).padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 70)
                        .padding(.bottom, 30)
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                        .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
                }
            }
            
            
            //IF THERE IS A 5 STAR REVIEW
            else if itemsViewModel.oneItem.first?.review.rating ?? -1 == 5 {
                
                //SHOW THE EQUIVALENT WIDGET FOR REFERRING
                
                
                Button {
                    
                    self.activeReviewOrReferSheet = .referSheet
                    showReviewOrReferSheet = true
                    
                } label: {
                    WideReferButton()
                        .padding(.horizontal).padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 70)
                        .padding(.bottom, 30)
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                        .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))

                }
            }
        }
        .background(Color("Background").opacity(0.5))
        .ignoresSafeArea()
        .navigationBarTitle(itemsViewModel.snapshotOfItem.first?.order.title ?? "Item", displayMode: .inline)
        .sheet(isPresented: $showReviewOrReferSheet, onDismiss: {
            
            print("DISMISSED THE SHEET!! TRACK IT")
            activeReviewOrReferSheet = nil
            showReviewOrReferSheet = false
            
        }, content: {
            
            if (self.activeReviewOrReferSheet == .referSheet || item.review.rating == 5) {
                //if you wanna show reviews
                
                ReferProduct1(isShowingReferExperience: $showReviewOrReferSheet, itemObject: item)
                
            } else {
                //if you wanna show referrals
                
                ReviewProductCarousel1(isShowingReviewExperience: $showReviewOrReferSheet, item: item, activeReviewOrReferSheet: $activeReviewOrReferSheet)
//                @State private var activeReviewOrReferSheet: ActiveReviewOrReferSheet? = nil
//                @State var showReviewOrReferSheet:Bool = false
                
            }
        })
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
    
    
    
    var companyName: String {
        switch item.ids.companyID {
        case "zKL7SQ0jRP8351a0NnHM":
            return "Athleisure LA"
        case "SDLFKJSDF":
            return "DIF CO"
        default:
            return "Athleisure LA"
        }
    }
    
    
}


struct OrderDetailsIconAndTextRow: View {
    
    var icon: String
    var title: String
    var subtitle: String
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 18) {
            
            Image(systemName: icon)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color("Dark2"))
                .frame(width: 25, height: 25)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
        }
    }
}

struct OrderDetailsIconAndLinkRow: View {
    
    var icon: String
    var linkTitle: String
    var link: String
    var subtitle: String
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 18) {
            
            Image(systemName: icon)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.blue)
                .frame(width: 25, height: 25)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Link(linkTitle, destination: URL(string: link)!)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Color.blue)
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                
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
    
    var title:String = "Earn 250 Points"
    var subtitle:String = "30 Seconds"
    var buttonText:String = "Review"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                    }
                        
                    
                }.padding(.top, 10)
                    .frame(height: 70)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal).padding(.horizontal, 18)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReviewTeal")))
                    .padding(.top, 10)
                    .frame(height: 70, alignment: .center)
                
            }.frame(height: 70)
    }
}

struct WideReferButton: View {
    
    var title:String = "Give $20, Get 20K"
    var subtitle:String = "30 Seconds"
    var buttonText:String = "Refer"
    
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(title)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                        Text(subtitle)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                    }
                    
                }.padding(.top, 10)
                .frame(height: 70)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal).padding(.horizontal, 18)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReferPurple")))
                    .padding(.top, 10)
                    .frame(height: 70, alignment: .center)
                
            }.frame(height: 70)
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

