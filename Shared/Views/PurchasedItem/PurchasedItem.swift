//
//  PurchasedItem.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/22/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

//MARK: HACK necessary to get the right sheet up
enum ActiveReviewOrReferSheet: String, Identifiable { // <--- note that it's now Identifiable
    case reviewSheet, referSheet
    var id: Int {
        hashValue
    }
}


struct PurchasedItem: View {
    
    //Environment
    @EnvironmentObject var viewModel: AppViewModel
    
    //ViewModels
    @StateObject var itemsViewModel = ItemsViewModel()
    
    //State
    @State var selectedTab:Int = 2
    
    //@State var buttonOffset:CGFloat = 100
    
    
    //@State var isPresentingReviewExperience:Bool = false
    
    
    var item: Items
    
    
    @State private var activeReviewOrReferSheet: ActiveReviewOrReferSheet? = nil
    @State var showReviewOrReferSheet:Bool = false
    
    @State var backgroundURL = ""
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Figure out whether you have the itemID or the whole object, and set the value for "itemObject" accordingly??? how to do this without rewriting if else statements every time?
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    //MARK: IMAGE SECTION WITH BOLD COLORS
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //IMAGE
                        ZStack(alignment: .top) {
                            
                            HStack(alignment: .center, spacing: 0) {
                                
                                Spacer()
                                
                                if backgroundURL != "" {
                                    WebImage(url: URL(string: backgroundURL)!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2, alignment: .center)
                                        .padding(.trailing, 10)
                                } else {
                                    Image("redshorts")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2, alignment: .center)
                                        .padding(.trailing, 10)
                                }

                            }.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 2, alignment: .top)
                                .background(RoundedRectangle(cornerRadius: 11)
                                    .foregroundColor(Color(
                                        red: Double(item.referrals.cardRGB[0]) / Double(255),
                                        green: Double(item.referrals.cardRGB[1]) / Double(255),
                                        blue: Double(item.referrals.cardRGB[2]) / Double(255)
                                    )))
                            
                            
                            HStack(alignment: .center) {
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(item.order.title)
                                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 8)
                                    
                                    HStack(alignment: .center, spacing: 0) {
                                        
                                        let ratingVariable = itemsViewModel.oneItem.first?.review.rating ?? -1
                                        
                                        ForEach(0..<5) { i in
                                            if i < ratingVariable {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(Color.white)
                                                    .font(.system(size: 14, weight: .regular))
                                            } else {
                                                Image(systemName: "star")
                                                    .foregroundColor(Color.white)
                                                    .font(.system(size: 14, weight: .regular))
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }.padding(.all, 16)
                            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 2, alignment: .top)

                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 2, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                        .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 10)
                        .padding(.horizontal, 20)
                        .padding(.top, 25)
                        .padding(.bottom, 5)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2 + 30, alignment: .center)
                    .padding(.top, 88)
                    
                    //MARK: SUBTITLE OF IMAGE
                    VStack (alignment: .leading, spacing: 0) {
                                
                        //MARK: RATING
                        HStack(alignment: .center, spacing: 1) {
                            
                            let ratingVariable = itemsViewModel.oneItem.first?.review.rating ?? -1
                            let referralsVariable = itemsViewModel.oneItem.first?.referrals.count ?? -1
                            
                            if ratingVariable <= 0 {
                                
                                Text("No review submitted")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("Gray2"))
                                
                            } else {
                                
                                NavigationLink {
                                    CompletedReviewPage(itemID: item.ids.itemID, userID: item.ids.userID)
                                } label: {
                                    Text("Read your review")
                                        .underline()
                                        .font(.system(size: 16, weight: .medium))
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
                                        
                                        Text("Track your referral")
                                            .underline()
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color("Dark1"))
                                        
                                    } else {
                                        
                                        Text("Track your " + String(referralsVariable) + " referrals")
                                            .underline()
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color("Dark1"))
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            Spacer()
                            
                        }
                        .padding(.top, 6)
                    }
                    .padding(.leading, 10)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, 20)
                    
                    Divider().padding(.horizontal, 30)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        let ratingVariable1 = itemsViewModel.oneItem.first?.review.rating ?? -1
                        let referralsVariable = itemsViewModel.oneItem.first?.referrals.count ?? -1
                        
                        if ratingVariable1 == 0 {
                            
                            Button {
                                self.activeReviewOrReferSheet = .reviewSheet
                                showReviewOrReferSheet = true
                            } label: {
                                
                                HStack(alignment: .center, spacing: 0) {
                                    Group {
                                        Text("Write a review? ")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color("ReviewTeal"))
                                            //.foregroundColor(Color("Dark1"))
                                        +
                                        Text("Let us know how you're liking this item. If you loved it, we'll show you how to refer a friend afterwards!")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(Color("Dark1"))
                                    }.multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                }.padding(.leading, 10)
                                
                            }.padding(.all, 20)
                            
                        } else if ratingVariable1 == 5 {
                            
                            Button {
                                self.activeReviewOrReferSheet = .referSheet
                                showReviewOrReferSheet = true
                            } label: {
                                
                                HStack(alignment: .center, spacing: 0) {
                                    
                                    if referralsVariable > 0 {
                                        
                                        Group {
                                            Text("Thank you! ")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(Color("ReferPurple"))
                                                //.foregroundColor(Color("Dark1"))
                                            +
                                            Text("We really appreciate your referral! If you still have more friends you'd like to tell, you'll get the same referral bonus for each one.")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(Color("Dark1"))
                                        }.multilineTextAlignment(.leading)
                                        
                                    } else {
                                        
                                        Group {
                                            Text("Refer a friend. ")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(Color("ReferPurple"))
                                                //.foregroundColor(Color("Dark1"))
                                            +
                                            Text("Thanks for your awesome review! If any of your friends would love this too, send them a $20 discount!")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(Color("Dark1"))
                                        }.multilineTextAlignment(.leading)
                                        
                                    }
                                    
                                    
                                    Spacer()
                                    
                                }
                                .padding(.leading, 10)
                                .padding(.all, 20)
                            }
                        }
                    }
                    
                    
                    Divider().padding(.horizontal, 30)
                    
                    
                    //MARK: ORDER DETAILS
                    HStack {
                            
                        VStack(alignment: .leading, spacing: 20) {
                            
                            OrderDetailsIconAndTextRow(icon: "number", title: item.order.companyName + " Order #" + String(item.order.orderNumber), subtitle: "Use this number for tracking and exchanges.")
                            
                            OrderDetailsIconAndTextRow(icon: "calendar", title: convertTimestampToString(timestamp: item.order.timestamp), subtitle: "You ordered on this date.")
                            
                            OrderDetailsIconAndTextRow(icon: "dollarsign", title: "$" + item.order.price, subtitle: "The price of this item without tax or shipping.")
                            
                            let returnEndDate = item.order.returnPolicyInDays * 24 * 60 * 60 + item.order.timestamp
                            
                            OrderDetailsIconAndTextRow(icon: "airplane", title: "Return by " + convertTimestampToString(timestamp: returnEndDate), subtitle: companyName + "'s return policy is " + String(item.order.returnPolicyInDays) + " days from purchase.")
                            
                            OrderDetailsIconAndLinkRow(icon: "arrow.up.forward", linkTitle: "View order confirmation page", link: item.order.orderStatusURL, subtitle: "View more details in your browser.")
                            
                        }
                        
                        Spacer()
                        
                    }.padding(.all, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, 30)
                    
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
                
                let numberOfReferrals = itemsViewModel.oneItem.first?.referrals.count ?? -1
                
                Button {
                    
                    self.activeReviewOrReferSheet = .referSheet
                    showReviewOrReferSheet = true
                    
                } label: {
                    WideReferButton(buttonText: numberOfReferrals <= 0 ? "Refer a friend" : "Refer again")
                        .padding(.horizontal).padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, height: 70)
                        .padding(.bottom, 30)
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                        .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))

                }
            }
        }
        .background(.white)
        .ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
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
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color("Dark2"))
                .frame(width: 25, height: 25, alignment: .center)
            
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
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.blue)
                .frame(width: 25, height: 25, alignment: .center)
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
    
    var titleAmount:String = "Earn 250 points for writing a review"
    var titleType:String = "points"
    var subtitle:String = "30 sec."
    var buttonText:String = "Write a review"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {

                    Text(titleAmount)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                }.padding(.top, 10)
                .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 70, alignment: .topLeading)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal).padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReviewTeal")))
                    .padding(.top, 10)
                    .frame(height: 70, alignment: .center)
                
            }.frame(height: 70)
    }
}

struct WideReferButton: View {
    
    var titleAmount:String = "Give $20, get 20k"
    var titleType:String = "points"
    var subtitle:String = "30 sec."
    var buttonText:String = "Refer a friend"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(titleAmount)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    
                }.padding(.top, 10)
                .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 70, alignment: .leading)
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal).padding(.horizontal)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReferPurple")))
                    .padding(.top, 10)
                    .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 70, alignment: .center)
                
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

