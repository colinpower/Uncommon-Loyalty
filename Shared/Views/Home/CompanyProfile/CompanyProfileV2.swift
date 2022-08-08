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
    
    @State var isCreateDiscountScreenActive: Bool = false
    @State var isRedeemScreenActive: Bool = false
    @State var isDiscount1Active: Bool = false
    @State var isDiscount2Active: Bool = false
    
    
    @State var isProfileShowing:Bool = false
    @State var isHistoryActive:Bool = false
    @State var isNotificationsActive:Bool = false

    
    @State var isPrompt1Active: Bool = false
    @State var isPrompt2Active: Bool = false
    @State var isPrompt3Active: Bool = false
    @State var isPrompt4Active: Bool = false
    @State var isPrompt5Active: Bool = false
    
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
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color("ThemePrimary")]
            default:
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color("ThemePrimary")]
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
                
                //MARK: Background
                Color("Background")
                
                //The content starts here
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        
                        //MARK: Attempting to create graph here
                        VStack {
                            VStack(alignment: .center, spacing: 2) {
                                Text(String(viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0))
                                    .font(.system(size: 48))
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorToShow[1])
                                Text("Current Balance")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorToShow[1])
                                HStack {
                                    Button {
                                        //navigate to the "understand tiers" page
                                    } label: {
                                        Text("450 to Platinum")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("ThemeBright"))
                                    }
                                    Spacer()
                                    Text("--------------------")
                                }
                            }.padding(.horizontal)
               
                            
                            LineGraph(data: createLast60DaysPointsArray(transactions: viewModel3.last60DaysTransactions, currentBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0))
                                .frame(height: 200)
                                .padding(.bottom).padding(.bottom)
                            HStack (alignment: .center, spacing: 8) {
                                Button {
                                    isCreateDiscountScreenActive.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Redeem")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }.padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }.fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
                                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: 400, isCreateDiscountScreenActive: $isCreateDiscountScreenActive)
                                    
                                })
                                Button {
                                    isCreateDiscountScreenActive.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Redeem")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }.padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }.fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
                                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: 400, isCreateDiscountScreenActive: $isCreateDiscountScreenActive)
                                    
                                })
                                Button {
                                    //open website
                                } label: {
                                    HStack {
                                        Spacer()
                                        Link(destination: URL(string: urlToShopifySite)!) {
                                            Text("Visit site")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }.padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }
                            }.padding(.horizontal)
                                .padding(.bottom)
                        }
                        
//                        Text(String(createLast60DaysPointsArray(transactions: viewModel3.last60DaysTransactions, currentBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0)[0]))
//                        //MARK: Rewards "Card"
//                        VStack(alignment: .leading, spacing: 8) {
//
////                            ForEach(viewModel2.myDiscountCodes.prefix(1)) { DiscountCode in
////                                WidgetSolo(image: "dollarsign.circle.fill", size: 38, firstLine: "Discount Available", secondLine: "$" + String(DiscountCode.dollarAmount) + " off any item", secondLineColor: Color("ThemeBright"), buttonTitle: "Use", isActive: $isDiscount1Active)
////                                    .padding(.bottom, 8)
////                            }
//
//
//                            //Balance + tier
//                            HStack(alignment: .top){
//                                VStack (alignment: .leading){
//                                    Text("Points Balance")
//                                        .font(.system(size: 16))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(colorToShow[1])
//                                    Text(String(viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0))
//                                        .font(.system(size: 40))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(colorToShow[1])
//                                }
//                                Spacer()
//                                Button {
//                                    //navigate to the "understand tiers" page
//                                } label: {
//                                    VStack{
//                                        HStack {
//                                            Text("450 to Platinum")
//                                                .font(.system(size: 14))
//                                                .fontWeight(.regular)
//                                                .foregroundColor(colorToShow[2])
//                                            Image(systemName: "chevron.right")
//                                                .foregroundColor(colorToShow[2])
//                                                .font(Font.system(size: 12, weight: .bold))
//                                        }.padding(.top, 2)
//                                    }
//                                }
//                            }.padding(.bottom)
//                            .padding(.bottom)
//                            HStack (alignment: .center, spacing: 16) {
//                                Button {
//                                    isCreateDiscountScreenActive.toggle()
//                                } label: {
//                                    HStack {
//                                        Spacer()
//                                        Text("Redeem")
//                                            .font(.system(size: 18))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(colorToShow[1])
//                                        Spacer()
//                                    }.padding(.vertical, 12)
//                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(colorToShow[3]))
//                                }.fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
//                                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: 400, isCreateDiscountScreenActive: $isCreateDiscountScreenActive)
//
//                                })
//                                Button {
//                                    //open website
//                                } label: {
//                                    HStack {
//                                        Spacer()
//                                        Link(destination: URL(string: urlToShopifySite)!) {
//                                            Text("Visit site")
//                                                .font(.system(size: 18))
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(colorToShow[1])
//                                        }
//                                        Spacer()
//                                    }.padding(.vertical, 12)
//                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(colorToShow[3]))
//                                }
//                            }
//                        }.padding()
//                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(colorToShow[0]))
//                            .padding(.horizontal)
//                            .padding(.bottom, 8)
                        
                        //MARK: Discount Codes (if any)
                        if !viewModel1.oneRewardsProgram.isEmpty {
                            
                            //see if you need to list a 2+ of them
                            if viewModel2.myDiscountCodes.prefix(2).count > 2 {
                                //then, you need to represent it as a WidgetFloating
                                
                                HStack {
                                    Spacer()
                                    Text("See all")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[4])
                                    Spacer()
                                }
                            } else {
                                ForEach(viewModel2.myDiscountCodes.prefix(1)) { DiscountCode in
                                    WidgetSolo(image: "dollarsign.circle.fill", size: 38, firstLine: "Discount Available", secondLine: "$" + String(DiscountCode.dollarAmount) + " off any item", secondLineColor: Color("ThemeBright"), buttonTitle: "Use", isActive: $isDiscount1Active)
                                        //.padding(.bottom, 8)
                                }
                            }

                        }
                        
                        //MARK: Recommended Actions (if any)
                        //If empty, show the empty state
                        if viewModel4.myOrders.isEmpty {
                            Text("No recommended actions")
                        }
                        //Show the recommended actions
                        else {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{

                                    ForEach(viewModel4.myOrders.indices.prefix(3), id: \.self) { index in
                                        if index == 0 {
                                            Button {
                                                isPrompt1Active.toggle()
                                            } label: {
                                                PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, text: "Write a review for ldkjf aldkjfadoi a oiajdflka lkasdf a dfal alsdkfj akjdfa akdjf " + viewModel4.myOrders[index].orderID, width: geometry.size.width*1/2)
                                            }.fullScreenCover(isPresented: $isPrompt1Active) {
                                                ReviewProductPreview(companyID: companyID, email: email, orderID: "123", userID: userID, isActive: $isPrompt1Active)
                                            }
                                        } else if index == 1 {
                                            Button {
                                                isPrompt2Active.toggle()
                                            } label: {
                                                PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, text: "Write a review for ldkjf aldkjfadoi a oiajdflka lkasdf a dfal alsdkfj akjdfa akdjf " + viewModel4.myOrders[index].orderID, width: geometry.size.width*1/2)
                                            }.fullScreenCover(isPresented: $isPrompt2Active) {
                                                ReviewProductPreview(companyID: companyID, email: email, orderID: "ABC123", userID: userID, isActive: $isPrompt2Active)
                                            }
                                        } else if index == 2 {
                                            
                                        } else {
                                            
                                        }
                                    }
//                                    ForEach(viewModel4.myOrders.prefix(3)) { Order in
//                                        Button {
//                                            isPrompt1Active.toggle()
//                                        } label: {
//                                            PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, text: "Write a review for ldkjf aldkjfadoi a oiajdflka lkasdf a dfal alsdkfj akjdfa akdjf " + Order.orderID, width: geometry.size.width*1/2)
//                                        }.fullScreenCover(isPresented: $isPrompt1Active) {
//                                            ReviewProductPreview(companyID: companyID, email: email, orderID: "123", userID: userID, isActive: $isPrompt1Active)
//                                        }
//                                    }
                                }.padding(.horizontal)
                                    .padding(.vertical)
                                //.padding(.bottom, 8)
                            }
                        }
                        
                        //MARK: Recent Orders
                        VStack(alignment: .leading) {
                            
                            //Header
                            HStack {
                                Text("Recent Orders")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                            }
                            
                            //FOR EACH DISCOUNT CODE, SHOW IT HERE
                            ForEach(viewModel4.myOrders.prefix(5)) { Order in
                                MyRecentOrdersItem(item: Order.item, timestamp: 1650599999, reviewID: Order.reviewID, colorToShow: colorToShow[4])
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
                            .padding(.vertical)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        
//                        //MARK: Activity (Purchases, Spent Points, Reviews, Referrals)
//                        VStack(alignment: .leading) {
//
//                            //Header
//                            HStack {
//                                Text("Recent Activity")
//                                    .font(.system(size: 18))
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(Color("Dark1"))
//                                Spacer()
//                            }
//
//                            //FOR EACH DISCOUNT CODE, SHOW IT HERE
//                            ForEach(viewModel3.myTransactions.prefix(3)) { DiscountCode in
//                                MyHistoryItem(type: DiscountCode.type, timestamp: DiscountCode.timestamp, pointsEarnedOrSpent: DiscountCode.pointsEarnedOrSpent, colorToShow: colorToShow[4])
//                            }
//                            HStack {
//                                Spacer()
//                                Text("See all")
//                                    .font(.system(size: 16))
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(colorToShow[4])
//                                Spacer()
//                            }
//                        }.padding()
//                            .padding(.vertical)
//                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//                        .padding(.horizontal)
//                        .padding(.bottom)
                        
                        //Links + Additional info
                        //MARK: Settings
                        WideWidgetHeader(title: "SETTINGS")
                        VStack {
                            
                            //Item 1: Name
                            WideWidgetItem(image: "person.fill", size: 20, color: Color("Dark1"), title: "Name").padding(.bottom).padding(.bottom)
                            
                            //Item 2: Email
                            WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "Email").padding(.bottom).padding(.bottom)
                            
                            //Item 3: Notifications
                            WideWidgetItem(image: "bell.fill", size: 20, color: Color("Dark1"), title: "Notifications").padding(.bottom).padding(.bottom)
                            
                            //Item 4: Get help
                            WideWidgetItem(image: "questionmark.circle.fill", size: 20, color: Color("Dark1"), title: "Get help").padding(.bottom)
                            
                        }.padding().background(.white).padding(.bottom).padding(.bottom)
                        
                    }.padding(.vertical)
                }
            }
                    

        }
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle("Athleisure Gold", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            isHistoryActive.toggle()
                        } label: {
                            Image(systemName: "clock.fill")
                                .foregroundColor(Color("ThemePrimary"))
                        }.fullScreenCover(isPresented: $isHistoryActive) {
                            History(companyID: companyID, email: email, isHistoryActive: $isHistoryActive)
                        }
                        
                        Button {
                            isNotificationsActive.toggle()
                        } label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(Color("ThemePrimary"))
                        }.fullScreenCover(isPresented: $isNotificationsActive) {
                            Notifications(companyID: companyID, email: email, isNotificationsActive: $isNotificationsActive)
                        }
                        
                    }
                }
            }
        
        .onAppear {
            self.viewModel1.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel2.listenForMyDiscountCodes(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel3.listenForLast60DaysTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel4.listenForMyOrders(email: "colinjpower1@gmail.com", companyID: companyID)
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
    
    @Binding var isCreateDiscountScreenActive: Bool
    
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
                    isCreateDiscountScreenActive = true
                }) {
                    Text("Convert")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.blue))
                }.sheet(isPresented: $isCreateDiscountScreenActive, content: {
                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: currentPointsBalance, isCreateDiscountScreenActive: $isCreateDiscountScreenActive)
                    
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







struct CompanyProfileV2_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileV2(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", email: "colinjpower1@gmail.com", userID: "temp user ID here")
    }
}




//VStack(alignment: .leading) {
////                                HStack {
////                                    Text("Your Discount Codes")
////                                        .font(.system(size: 18))
////                                        .fontWeight(.semibold)
////                                        .foregroundColor(Color("Dark1"))
////                                    Spacer()
////                                }
//    //FOR EACH DISCOUNT CODE, SHOW IT HERE
//    ForEach(viewModel2.myDiscountCodes.prefix(2)) { DiscountCode in
//    //ForEach(viewModel1.oneRewardsProgram.prefix(2)) { RewardsProgram in
//
//        //Text("salfkj")
//        WidgetSolo(image: "dollarsign.circle.fill", size: 40, firstLine: "aldskfjasd", secondLine: "Discsad;lfkasf", secondLineColor: Color("PrimaryBright"), buttonTitle: "Use", isActive: $isDiscount1Active)
//            .padding(.bottom, 2)
//
////                                    HStack {
////                                        Image(systemName: "plus.circle.fill")
////                                            .foregroundColor(colorToShow[4])
////                                            .font(.system(size: 40))
////                                        VStack(alignment: .leading, spacing: 3) {
////                                            Text("Invite friends")
////                                                .font(.system(size: 16))
////                                                .fontWeight(.semibold)
////                                                .foregroundColor(Color("Dark1"))
////                                            Text("Get 500 points")
////                                                .font(.system(size: 16))
////                                                .fontWeight(.regular)
////                                                .foregroundColor(Color("Gray2"))
////                                        }
////                                        Spacer()
////                                        Image(systemName: "chevron.right")
////                                            .foregroundColor(Color("Gray3"))
////                                            .font(Font.system(size: 15, weight: .semibold))
////                                    }.padding(.vertical)
//
//    }
//
//}.padding()
//.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//.padding(.horizontal)
//.padding(.bottom)
