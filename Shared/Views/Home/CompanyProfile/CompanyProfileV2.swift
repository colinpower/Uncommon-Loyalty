//
//  CompanyProfileV2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/29/22.
//

import SwiftUI


//how to download an image from firebase
//https://www.youtube.com/watch?v=PYpTto3iQXU&t=446s


struct CompanyProfileV2: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Variables received from HomeView
    var companyID: String
    var companyName: String
    //var currentPointsBalance: Int
    var email: String
    var userID: String
//    var status: String
    var urlToShopifySite: String = "https://athleisure-la.myshopify.com"
    
    @State var showingDiscountScreen: Bool = false
    
    //vars for the current state
    @State var progressValue: Float = 0.6
    @State var isDiscountButtonAvailable: Bool = false
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    @ObservedObject var viewModel3 = TransactionsViewModel()
    @ObservedObject var viewModel4 = OrdersViewModel()
    
    @State private var hasDiscountsCreated = false
    
    var colorToShow: [Color] {
        switch viewModel1.oneRewardsProgram.first?.status {
            case "Gold":
                //Primary Rewards Color, Primary Text on Primary Color, Secondary Text on Primary Color, Button Background, Primary Button Color
                return [Color("Gold1"), Color(.white), Color("Gold2"), Color("Gold2").opacity(0.25), Color("Gold1")]
            case "Silver":
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color.blue]
            default:
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color.blue]
        }
    }
    
    //Variables for modifying this page
    @State var rewards: Double = 0
    
    let discounts: [String] = ["COLIN-GOLD-1", "COLIN-GOLD-2", "COLIN-REFER"]
    let history: [String] = ["T shirt", "Sweatshirt", "Watch"]

    // largeTitle, title, headline, body, caption
    // https://developer.apple.com/documentation/swiftui/foreach
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                //Background color
                Color("Background")
                
                //Body
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        //Points + Convert (top section)
                        VStack(alignment: .leading, spacing: 8) {
                            //Balance + tier
                            HStack(alignment: .top){
                                VStack (alignment: .leading){
                                    Text("Points Balance")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                    Text("825")
                                        .font(.system(size: 40))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                }
                                Spacer()
                                Button {
                                    //navigate to the "understand tiers" page
                                } label: {
                                    VStack{
                                        HStack {
                                            Text("450 to Platinum")
                                                .font(.system(size: 14))
                                                .fontWeight(.regular)
                                                .foregroundColor(colorToShow[2])
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(colorToShow[2])
                                                .font(Font.system(size: 12, weight: .bold))
                                        }.padding(.top, 2)
                                    }
                                }
                            }.padding(.bottom)
                            .padding(.bottom)
                            HStack (alignment: .center, spacing: 16) {
                                Button {
                                    //trigger convert points
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Redeem")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundColor(colorToShow[1])
                                        Spacer()
                                    }.padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(colorToShow[3]))
                                }
                                Button {
                                    //open website
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Go to site")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundColor(colorToShow[1])
                                        Spacer()
                                    }.padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(colorToShow[3]))
                                }
                            }
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(colorToShow[0]))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        //Discount codes (if any are available)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Your Discount Codes")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                            }
                            //FOR EACH DISCOUNT CODE, SHOW IT HERE
                            ForEach(viewModel2.myDiscountCodes.prefix(2)) { DiscountCode in
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(colorToShow[4])
                                        .font(.system(size: 40))
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Invite friends")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Get 500 points")
                                            .font(.system(size: 16))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Gray2"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("Gray3"))
                                        .font(Font.system(size: 15, weight: .semibold))
                                }.padding(.vertical)
                                
                            }
                            HStack {
                                Spacer()
                                Text("See all")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorToShow[4])
                                Spacer()
                            }
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        //Suggested Reviews / Referrals
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color("Gray3"))
                                    .frame(width: geometry.size.width/3*2, height: 120)
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color("Gray3"))
                                    .frame(width: geometry.size.width/3*2, height: 120)
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color("Gray3"))
                                    .frame(width: geometry.size.width/3*2, height: 120)
                            }.padding(.horizontal)
                                .padding(.bottom)
                        }
                        
                        //Activity
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Recent Activity")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                            }
                            //FOR EACH DISCOUNT CODE, SHOW IT HERE
                            ForEach(viewModel2.myDiscountCodes.prefix(3)) { DiscountCode in
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(colorToShow[4])
                                        .font(.system(size: 40))
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Invite friends")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Get 500 points")
                                            .font(.system(size: 16))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Gray2"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("Gray3"))
                                        .font(Font.system(size: 15, weight: .semibold))
                                }.padding(.vertical)
                                
                            }
                            HStack {
                                Spacer()
                                Text("See all")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorToShow[4])
                                Spacer()
                            }
                        }.padding()
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        //Links + Additional info
                        HStack {
                            Text("MORE INFO").kerning(1.2)
                                .font(.system(size: 13))
                                .fontWeight(.medium)
                                .foregroundColor(Color("Gray1"))
                            Spacer()
                        }.padding(.horizontal)
                            .padding(.top)
                        VStack {
                            //Name
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20))
                                    .frame(width: 40)
                                Text("Name")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("Gray3"))
                                    .font(Font.system(size: 15, weight: .semibold))
                            }.padding(.bottom)
                                .padding(.bottom)
                            //Email Address
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20))
                                    .frame(width: 40)
                                Text("Email address")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("Gray3"))
                                    .font(Font.system(size: 15, weight: .semibold))
                            }.padding(.bottom)
                                .padding(.bottom)
                            
                            //Notifications
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20))
                                    .frame(width: 40)
                                Text("Notifications")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("Gray3"))
                                    .font(Font.system(size: 15, weight: .semibold))
                            }.padding(.bottom)
                                .padding(.bottom)
                            
                            //Help
                            HStack {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(Color("Dark1"))
                                    .font(.system(size: 20))
                                    .frame(width: 40)
                                Text("Get help")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("Gray3"))
                                    .font(Font.system(size: 15, weight: .semibold))
                            }
                        }
                        .padding()
                        .background(.white)
                        .padding(.bottom)
                        
                        
                    }.padding(.vertical)
                }
            }
                    

            
            
            
            
            
            
            //            VStack {
                
                
//                ProfileHeader(companyID: companyID, companyName: companyName, email: email, userID: userID)
//                    .padding(.horizontal, 12)
//                    .padding(.top, 12)
//                Divider()
//                ProfileRewardsBalance(progressValue: $progressValue, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0, companyName: "Athleisure LA", companyID: companyID, showingDiscountScreen: $showingDiscountScreen)
//                    .padding(.top, 12)
//                    .padding(.all, 12)
//                MyDiscounts(shortDescription: "Use this code at checkout for $10 off any item", discountCode: "COLIN123")
//                    .padding(.all, 12)
//                YourOrders(companyID: companyID, companyName: companyName, email: email, userID: userID)
//                    .padding(.all, 12)   //need to pass in viewModel4 (Orders observed object)
                    
//            }
        }
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle("Athleisure Gold", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center) {
                        Text("")
                        Link(destination: URL(string: urlToShopifySite)!) {
                            Text("Visit site")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                                .padding(.all, 6)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.15)))
                        }
                    }
                }
            }
        
        .onAppear {
            self.viewModel1.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel2.listenForMyDiscountCodes(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            //print(self.viewModel3.myTransactions)
        }
        
    }
}

//MARK: PROFILE HEADER
//This struct formats the header
struct ProfileHeader: View {
    
    var companyID: String
    var companyName: String
    var email: String
    //var orderID: String // need to get the orderID when in the ReviewsHistory widget
    var userID: String
    
    var body: some View {
        VStack {
            //NAME, MEMBER STATUS, VIDEO
            HStack{
                Text("Hi Colin!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(Color(UIColor.lightGray))
//                Text("Silver Tier")
//                    .font(.body)
//                    .fontWeight(.medium)
//                    .foregroundColor(.gray)
//                Image("AthleisureSweatshirt")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 48, height: 48, alignment: .center)
//                    .clipped()
//                    .cornerRadius(48)
            }.padding(.bottom, 18)
            
            //REFERRALS, HISTORY, TIERS
            HStack(alignment: .top) {
                NavigationLink(
                    destination: ReferAFriend(companyID: companyID, companyName: companyName),
                    label: {
                        HStack(alignment: .center) {
                            Image("Rewards")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Refer")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }.padding(.trailing, 18)
                    })
                NavigationLink(
                    destination: ReviewHistory(companyID: companyID, email: email, userID: userID),
                    label: {
                        HStack(alignment: .center) {
                            Image("History")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Review")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                    })
                Spacer()
                NavigationLink(
                    destination: VoteOnProduct(),
                    label: {
                        HStack(alignment: .center) {
                            Image("Diamond")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Tiers")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                    })
            }
        }
    }
    
}

//MARK: REWARDS BALANCE
//This struct handles your points, and how you earn... see animations tutorial
//https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions
struct ProfileRewardsBalance: View {
    
    @Binding var progressValue: Float
    @State private var showDetail = false
    
    var currentPointsBalance: Int
    var companyName: String
    var companyID: String
    
    @Binding var showingDiscountScreen: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Point Balance")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }.padding(.bottom, 8)

            HStack(alignment: .center) {
                Text(String(currentPointsBalance))
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                Spacer()
                Button(action: {
                    showingDiscountScreen = true
                }) {
                    Text("Convert")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.blue))
                }.sheet(isPresented: $showingDiscountScreen, content: {
                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: currentPointsBalance, showingDiscountScreen: $showingDiscountScreen)
                })
            }
        }
    }
    
}

//MARK: MY DISCOUNTS
//This struct formats the discount codes that are available
struct MyDiscounts: View {
    var shortDescription: String
    var discountCode: String
    
    @State private var buttonText: String = "Copy"
    @State private var buttonColor: Color = Color.blue
    @State private var isShowing = true
    //var description: String
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Discounts")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }.padding(.bottom, 8)
            if(shortDescription.isEmpty){
                //EmptyView()
                Text("No discounts available")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else {
                HStack {
                    Text("$10")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .fill(Color.green))
                        .padding(.trailing, 18)
                    Text(discountCode)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.8))
                    Spacer()
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(buttonColor)
                        .onTapGesture(count: 1) {
                            //need to switch to DispatchQueue here
                            //https://stackoverflow.com/questions/59682446/how-to-trigger-action-after-x-seconds-in-swiftui
                            buttonText = "Copied"
                            buttonColor = Color.green
                            UIPasteboard.general.string = discountCode
                        }
                }.padding(.all, 16)
                .background(RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 1))
            }
        }
    }
}

//MARK: YOUR ORDERS
//ForEach(viewModel3.myTransactions) { myTransaction in
////                    MyHistoryItem(type: myTransaction.type, timestamp: myTransaction.timestamp, pointsEarnedOrSpent: myTransaction.pointsEarnedOrSpent)
////                }
struct YourOrders: View {
    
    var companyID: String
    var companyName: String
    var email: String
    var userID: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Purchases")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }.padding(.bottom, 8)
            
            
            HStack(alignment: .center) {
                Image("AthleisureJogger")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipped()
                    .cornerRadius(8)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text("Joggers 2.0")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.8))
                    Text("May 21")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
//                NavigationLink(
//                    destination: ReviewProductPreview(companyID: companyID, email: email, orderID: "123", userID: userID),
//                    label: {
//                        Text("Review")
//                            .font(.body)
//                            .fontWeight(.medium)
//                            .foregroundColor(.blue)
//                            .padding(.trailing, 8)
//                    })
                
            }
        }
    }
}


//MARK: MY HISTORY
//This struct formats the discount codes that are available
struct MyHistoryItem: View {
    
    var type: String
    var timestamp: Int
    var pointsEarnedOrSpent: Int
    
    var iconToShow: String {
        switch type {
            case "REFERRAL":
                return "person.2.fill"
            case "REVIEW":
                return "text.bubble.fill"
            case "ORDER":
                return "signature"
            case "DISCOUNTCODE":
                return "dollarsign.circle.fill"
            default:
                return "bag.fill"
        }
    }
    
    var textToShow: String {
        switch type {
            case "REFERRAL":
                return "Referred a friend"
            case "REVIEW":
                return "Created a review"
            case "ORDER":
                return "Placed an order"
            case "DISCOUNTCODE":
                return "Created a discount code"
            default:
                return "bag.fill"
        }
    }
    
//    var pointsToShow: String = ""
//
//    if pointsEarnedOrSpent > 0 {
//        pointsToShow = "+" + String(pointsEarnedOrSpent)
//    } else {
//        pointsToShow = "-" + String(pointsEarnedOrSpent)
//    }
//
    //var description: String
    
    var body: some View {
        HStack {
            Image(systemName: iconToShow).padding(.trailing, 4)
            Text(textToShow)
            Spacer()
            VStack {
                Text(String(pointsEarnedOrSpent))
                Text(convertTimestampToString(timestamp: timestamp))
                    .font(.footnote)
            }
        }.padding(.vertical, 6)
        .padding(.horizontal, 12)
    }
}




struct CompanyProfileV2_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileV2(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", email: "colinjpower1@gmail.com", userID: "temp user ID here")
    }
}


