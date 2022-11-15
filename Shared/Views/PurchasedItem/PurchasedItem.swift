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
    var id: String {
        return self.rawValue
    }
}


struct PurchasedItem: View {
    
    //ViewModels
    @StateObject var itemsViewModel = ItemsViewModel()
    @StateObject var companiesViewModel = CompaniesViewModel()
    
    //State
    @State var selectedTab:Int = 2
    
    var item: Items
    
    
    @State private var activeReviewOrReferSheet: ActiveReviewOrReferSheet? = nil
    //@State var showReviewOrReferSheet:Bool = false
    
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
                                    Image("bag.fill")
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
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            //check if it has been reviewed yet
                            if item.review.rating <= 0 {
                                //not yet reviewed... need to show prompt
                                OrderDetailsNotReviewedRow(
                                    bonusType: companiesViewModel.snapshotOfCompanyProduct.first?.reviewReward.type ?? "NONE",
                                    bonusAmount: companiesViewModel.snapshotOfCompanyProduct.first?.reviewReward.amount ?? -1
                                )
                                
                            } else {
                                // it has been reviewed.. need to show success + link to view review
                                
                                OrderDetailsReviewedRow(
                                    bonusType: item.review.rewardType,
                                    bonusAmount: item.review.rewardAmount,
                                    item: item
                                )
                            }
                            
                            OrderDetailsReferralRow(
                                rewardType: companiesViewModel.snapshotOfCompanyProduct.first?.referralReward.type ?? "NONE",
                                rewardAmount: companiesViewModel.snapshotOfCompanyProduct.first?.referralReward.amount ?? 0,
                                offerType: companiesViewModel.snapshotOfCompanyProduct.first?.referralOfferNewCustomer.type ?? "NONE",
                                offerAmount: companiesViewModel.snapshotOfCompanyProduct.first?.referralOfferNewCustomer.amount ?? 0,
                                numberOfReferrals: item.referrals.count,
                                item: item
                            )

                            
                        }
                        
                        Spacer()
                        
                    }.padding(.all, 20)
                    .padding(.vertical, 10)
                    
                    Divider().padding(.horizontal, 30)
                    
                    
                    //MARK: ORDER DETAILS
                    HStack {
                            
                        VStack(alignment: .leading, spacing: 20) {
                            
                            OrderDetailsIconAndTextRow(icon: "number", title: item.order.companyName + " Order #" + String(item.order.orderNumber), subtitle: "Use this number for tracking and exchanges.")
                            
                            OrderDetailsIconAndTextRow(icon: "calendar", title: convertTimestampToString(timestamp: item.order.timestamp), subtitle: "You ordered on this date.")
                            
                            OrderDetailsIconAndTextRow(icon: "dollarsign", title: "$" + item.order.price, subtitle: "The price of this item without tax or shipping.")
                            
                            let returnEndDate = item.order.returnPolicyInDays * 24 * 60 * 60 + item.order.timestamp
                            
                            OrderDetailsIconAndTextRow(icon: "airplane", title: "Return by " + convertTimestampToString(timestamp: returnEndDate), subtitle: "The return policy is " + String(item.order.returnPolicyInDays) + " days from purchase.")
                            
                            OrderDetailsIconAndLinkRow(icon: "arrow.up.forward", linkTitle: "View order confirmation page", link: item.order.orderStatusURL, subtitle: "View more details in your browser.")
                            
                        }
                        
                        Spacer()
                        
                    }.padding(.all, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, 30)
                    
                }
            }
            
            //MARK: REVIEW & REFER BUTTONS
            
            HStack(alignment: .center, spacing: 16) {
                Spacer()
                
                if item.review.rating <= 0 {
                    
                    Button {
                        self.activeReviewOrReferSheet = .reviewSheet
                    } label: {
                        WideReviewButton()
                            .frame(height: 70)
                    }
                    
                    Button {
                        self.activeReviewOrReferSheet = .referSheet
                    } label: {
                        WideReferButton(isFullWidth: false, buttonText: item.referrals.count <= 0 ? "Refer a friend" : "Refer again")
                            .frame(height: 70)
                    }
                    
                } else {
                    
                    Button {
                        self.activeReviewOrReferSheet = .referSheet
                    } label: {
                        WideReferButton(isFullWidth: true, buttonText: item.referrals.count <= 0 ? "Refer a friend" : "Refer again")
                            .frame(height: 70)
                    }
                    
                }
                
                Spacer()
                
            }
            .padding(.bottom, 30)
            .frame(width: UIScreen.main.bounds.width, height: 100)
            .background(Rectangle().foregroundColor(Color.white).shadow(color: Color("Gray2"), radius: 2, x: 0, y: -1))
                
        }
        .background(.white)
        .ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
        
        .sheet(item: $activeReviewOrReferSheet, onDismiss: { activeReviewOrReferSheet = nil }) { sheet in

            switch sheet {
            case .referSheet:
                ReferProduct0(activeReviewOrReferSheet: $activeReviewOrReferSheet, itemObject: item, productRewards: companiesViewModel.snapshotOfCompanyProduct.first!)
            case .reviewSheet:
                ReviewProductCarousel1(activeReviewOrReferSheet: $activeReviewOrReferSheet, item: item)
            }
        }
        
        .onAppear {
            
            self.itemsViewModel.listenForOneItem(userID: item.ids.userID, itemID: item.ids.itemID)
            
            self.companiesViewModel.getSnapshotOfCompany(companyID: item.ids.companyID)
            self.companiesViewModel.getSnapshotOfCompanyProduct(companyID: item.ids.companyID, productID: String(item.ids.shopifyProductID))
            
//            @Published var snapshotOfCompany = [Companies]()
//            @Published var snapshotOfCompanyProduct = [CompanyProduct]()
            
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
        
}

//ROWS IN MIDDLE
struct OrderDetailsReferralRow: View {
    
    var rewardType: String               // Percentage , Fixed , Cash , Points
    var rewardAmount: Int                // 20% , $20 , $20 , 2000
    
    var offerType: String
    var offerAmount: Int
                                        // -1 , -1 , $50 or -1 etc , -1
    var numberOfReferrals: Int
    var item: Items
    
    var offerSubstring: String {       // need to grab "a $20 discount" for "You earned a $20 discount" , "2000 points" for "You earned 2000 points"
        switch offerType {
        case "PERCENTAGE":
            return "Give " + String(offerAmount) + "%"
        case "FIXED":
            return "Give $" + String(offerAmount)
        case "CASH":
            return "Give $" + String(offerAmount) + " in cash"
        case "POINTS":
            return "Give " + String(offerAmount) + " points"
        case "NONE":
            return ""
        default:
            return ""
        }
    }
    
    var rewardSubstring: String {       // need to grab "a $20 discount" for "You earned a $20 discount" , "2000 points" for "You earned 2000 points"
        switch rewardType {
        case "PERCENTAGE":
            return "get " + String(rewardAmount) + "%"
        case "FIXED":
            return "get $" + String(rewardAmount)
        case "CASH":
            return "get $" + String(rewardAmount) + " in cash"
        case "POINTS":
            return "get " + String(rewardAmount) + " points"
        case "NONE":
            return ""
        default:
            return ""
        }
    }
    
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 18) {
            
            Image(systemName: "dollarsign.square.fill")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("ReferPurple"))
                .frame(width: 25, height: 25, alignment: .center)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(numberOfReferrals == 0 ? "Refer a friend" : "Refer again? \(numberOfReferrals) sent")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                
                Text(offerSubstring + ", " + rewardSubstring)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
            
            Spacer()
            
            if numberOfReferrals > 0 {
                NavigationLink {
                    ReferralTrackerForItem(userID: item.ids.userID, itemID: item.ids.itemID, itemTitle: item.order.title)
                } label: {
                    Text("Track")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        .clipShape(Capsule())
                        .background(Capsule().foregroundColor(Color("Gray3")))
                }
            }
            
        }
    }
}
struct OrderDetailsNotReviewedRow: View {
    
    var bonusType: String               // Percentage , Fixed , Cash , Points
    var bonusAmount: Int                // 20% , $20 , $20 , 2000
//    var minSpend: Int                   // -1 , -1 , $50 or -1 etc , -1
    
    var subtitleSubstring: String {       // need to grab "a $20 discount" for "You earned a $20 discount" , "2000 points" for "You earned 2000 points"
        switch bonusType {
        case "PERCENTAGE":
            return "Earn a " + String(bonusAmount) + "% discount"
        case "FIXED":
            return "Earn a $" + String(bonusAmount) + " discount"
        case "CASH":
            return "Earn $" + String(bonusAmount) + " in cash"
        case "POINTS":
            return "Earn " + String(bonusAmount) + " points"
        case "NONE":
            return "What did you think?"
        default:
            return "a bonus"
        }
    }
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 18) {
            
            Image(systemName: bonusType == "NONE" ? "star.fill" : "dollarsign.square.fill")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("ReviewTeal"))
                .frame(width: 25, height: 25, alignment: .center)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Write a review")
                    .font(.system(size: 15, weight: .medium))
                    //.underline(isReviewed)
                    .foregroundColor(Color("Dark1"))
                
                Text(subtitleSubstring)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
        }
    }
}

struct OrderDetailsReviewedRow: View {
    
    var bonusType: String               // Percentage , Fixed , Cash , Points
    var bonusAmount: Int                // 20% , $20 , $20 , 2000
//    var minSpend: Int                   // -1 , -1 , $50 or -1 etc , -1
    var item: Items
    
    var subtitleSubstring: String {       // need to grab "a $20 discount" for "You earned a $20 discount" , "2000 points" for "You earned 2000 points"
        switch bonusType {
        case "PERCENTAGE":
            return "You earned a " + String(bonusAmount) + "% discount"
        case "FIXED":
            return "You earned a $" + String(bonusAmount) + " discount"
        case "CASH":
            return "You earned $" + String(bonusAmount) + " in cash"
        case "POINTS":
            return "You earned " + String(bonusAmount) + " points"
        case "NONE":
            return "Thanks for your review!"
        default:
            return "Earn a bonus"
        }
    }
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 18) {
            
            Image(systemName: bonusType == "NONE" ? "star.fill" : "dollarsign.square.fill")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("ReviewTeal"))
                .frame(width: 25, height: 25, alignment: .center)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Reviewed")
                    .font(.system(size: 15, weight: .medium))
                    //.underline(isReviewed)
                    .foregroundColor(Color("Dark1"))
                
                Text(subtitleSubstring)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray1"))
            }
            
            Spacer()
            
            NavigationLink {
                CompletedReviewPage(itemID: item.ids.itemID, userID: item.ids.userID)
            } label: {
                Text("View")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("Dark1"))
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .clipShape(Capsule())
                    .background(Capsule().foregroundColor(Color("Gray3")))
            }
            
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

//BUTTONS ON BOTTOM
struct WideReviewButton: View {
    
    var buttonText:String = "Review"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
//                    .padding(.vertical, 16)
//                    .padding(.horizontal).padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 48, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReviewTeal")))
                    .padding(.top, 10)
//                    .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 70, alignment: .center)
                
                Spacer()
                
            }.frame(height: 70)
    }
}

struct WideViewReviewButton: View {
    
    var buttonText:String = "View review"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("ReviewTeal"))
                    .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 48, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color.white))
                    .padding(.top, 10)
                
                Spacer()
                
            }.frame(height: 70)
    }
}

struct WideReferButton: View {
    
    var isFullWidth: Bool
    
    var buttonText:String = "Refer"
    
    var body: some View {
            
            HStack(spacing: 0) {
                
                Spacer()
                
                Text(buttonText)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal).padding(.horizontal)
                    .frame(width: isFullWidth ? UIScreen.main.bounds.width * 4 / 5 : UIScreen.main.bounds.width * 2 / 5, height: 48, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("ReferPurple")))
                    .padding(.top, 10)
//                    .frame(width: UIScreen.main.bounds.width * 2 / 5, height: 70, alignment: .center)
                
                Spacer()
                
            }.frame(height: 70)
    }
}
