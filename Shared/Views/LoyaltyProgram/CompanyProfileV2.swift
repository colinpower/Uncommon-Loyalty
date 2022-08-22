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
    @ObservedObject var viewModel_Items = ItemsViewModel()
    
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
        
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                //MARK: BACKGROUND
                Color("Background")
                
                //MARK: CONTENT
                //The content starts here
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        //MARK: TOP CARD W/CURRENT POINTS
                        VStack(alignment: .leading) {
                        
                            //Current balance + pending points
                            HStack (alignment: .top) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Current Balance")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                    Text(String(viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? -1))
                                        .font(.system(size: 48))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                }
                                Spacer()
                                Text("450 pending >")
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("ThemeBright"))
                                    .padding(.top, 4)
                            }.padding(.bottom).padding(.bottom)
                            
                            //Buttons
                            HStack (alignment: .center, spacing: 8) {
                                
                                //Redeem
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
                                    CreateDiscountScreen(isCreateDiscountScreenActive: $isCreateDiscountScreenActive, companyID: companyID, companyName: companyName, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0).navigationTitle("").navigationBarHidden(true)
                                })
                                
                                //Gift
                                Button {
                                    //isCreateDiscountScreenActive.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "gift.fill")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }.padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }
                        
                                //Visit site
                                Button {
                                    //open website
                                } label: {
                                    HStack {
                                        Spacer()
                                        Link(destination: URL(string: urlToShopifySite)!) {
                                            Text("Visit")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }.padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }
                            }
                        }.padding()
                            .background(RoundedRectangle(cornerRadius: 24).foregroundColor(.white))
                            .padding()
                        
                        
                        //MARK: DISCOUNT CODES (IF ANY)
                        if !viewModel1.oneRewardsProgram.isEmpty {
                            
                            //see if you need to list a 2+ of them
                            if viewModel2.myDiscountCodes.count > 3 {
                                //then, you need to represent it as a WidgetFloating
                                VStack {
                                    ForEach(viewModel2.myDiscountCodes.prefix(2)) { DiscountCode in
                                        DiscountCodeSolo(image: "dollarsign.circle.fill", size: 38, firstLine: "Discount Available", secondLine: "$" + String(DiscountCode.dollarAmount) + " off any item", secondLineColor: Color("ThemeBright"), buttonTitle: "Use", status: DiscountCode.status, code: DiscountCode.code, isActive: $isDiscount1Active)
                                    }
                                
                                    HStack {
                                        Spacer()
                                        Text("See all")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(colorToShow[4])
                                        Spacer()
                                    }
                                }
                            } else {
                                ForEach(viewModel2.myDiscountCodes.prefix(3)) { DiscountCode in
                                    DiscountCodeSolo(image: "dollarsign.circle.fill", size: 38, firstLine: "Discount Available", secondLine: "$" + String(DiscountCode.dollarAmount) + " off any item", secondLineColor: Color("ThemeBright"), buttonTitle: "Use", status: DiscountCode.status, code: DiscountCode.code, isActive: $isDiscount1Active)
                                        //.padding(.bottom, 8)
                                }
                            }
                        }
                        
                        //MARK: RECOMMENDED ACTIONS (IF ANY)
                        //If empty, show the empty state
                        
                        if viewModel_Items.myReviewableItemsForCompany.isEmpty {
                            Text("No recommended actions")
                        }
                        //Show the recommended actions
                        else {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{
                                    
                                    
                                    ForEach(viewModel_Items.myReviewableItemsForCompany.indices.prefix(3), id: \.self) { index in
                                        if index == 0 {
                                            Button {
                                                isPrompt1Active.toggle()
                                            } label: {
                                                PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, text: "Write a review for ldkjf aldkjfadoi a oiajdflka lkasdf a dfal alsdkfj akjdfa akdjf " + viewModel_Items.myReviewableItemsForCompany[index].itemID, width: geometry.size.width*1/2)
                                            }
                                            .fullScreenCover(isPresented: $isPrompt1Active) {
                                                ReviewProductPreview(companyID: companyID, email: email, itemID: viewModel_Items.myReviewableItemsForCompany[index].itemID, userID: userID, isActive: $isPrompt1Active)
                                            }
                                        } else if index == 1 {
                                            Button {
                                                isPrompt2Active.toggle()
                                            } label: {
                                                Text("example 2")
//                                                PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, text: "Write a review for ldkjf aldkjfadoi a oiajdflka lkasdf a dfal alsdkfj akjdfa akdjf " + viewModel5.mySuggestedItems[index].itemID, width: geometry.size.width*1/2)
                                            }
//                                            .fullScreenCover(isPresented: $isPrompt2Active) {
//                                                ReviewProductPreview(companyID: companyID, email: email, orderID: "ABC123", userID: userID, isActive: $isPrompt2Active)
//                                            }
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
                            
                            //For each recent order, show an item
                            ForEach(viewModel4.myOrders.prefix(5).reversed()) { Order in
                                MyRecentOrdersItem(item: Order.item_firstItemTitle, timestamp: Order.timestamp, reviewID: Order.orderID, colorToShow: colorToShow[4])
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
                        
                        

                        
                        //Links + Additional info
                        //MARK: Settings
                        WideWidgetHeader(title: "SETTINGS")
                        VStack {
                            
                            //Item 1: Name
                            Button {
                                isHistoryActive.toggle()
                            } label: {
                                WideWidgetItem(image: "clock.fill", size: 20, color: Color("Dark1"), title: "History").padding(.bottom).padding(.bottom)
                            }.fullScreenCover(isPresented: $isHistoryActive) {
                                History(companyID: companyID, email: email, isHistoryActive: $isHistoryActive)
                            }
                            
                            
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
        .navigationBarTitle(viewModel1.oneRewardsProgram.first?.companyName ?? "", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            isHistoryActive.toggle()
                        } label: {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color("ThemePrimary"))
                        }.fullScreenCover(isPresented: $isHistoryActive) {
                            History(companyID: companyID, email: email, isHistoryActive: $isHistoryActive)
                        }
                        
                        Button {
                            isNotificationsActive.toggle()
                        } label: {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 18))
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
            //self.viewModel3.listenForLast60DaysTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel4.listenForMyOrders(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel_Items.listenForMyReviewableItemsForCompany(email: email, companyID: companyID)
            //self.viewModel_Items.listenForMyItems(email: "colinjpower1@gmail.com", companyID: companyID)
            //print(self.viewModel3.myTransactions)
        }
        .onDisappear {
            if self.viewModel1.listener2 != nil {
                print("REMOVING LISTENER 2")
                self.viewModel1.listener2.remove()
            }
            if self.viewModel2.listener_DiscountCodes != nil {
                print("REMOVING LISTENER_DISCOUNTCODES")
                self.viewModel2.listener_DiscountCodes.remove()
            }
            if self.viewModel3.listener_Transactions != nil {
                print("REMOVING LISTENER_TRANSACTIONS")
                self.viewModel3.listener_Transactions.remove()
            }
//            if self.viewModel3.listener_Transactions7 != nil {
//                print("REMOVING LISTENER_TRANSACTIONS7")
//                self.viewModel3.listener_Transactions7.remove()
//            }
            if self.viewModel4.listener_Orders != nil {
                print("REMOVING LISTENER_ORDERS")
                self.viewModel4.listener_Orders.remove()
            }
            if self.viewModel_Items.listener_MyReviewableItemsForCompany != nil {
                print("REMOVING LISTENER_ITEMS")
                self.viewModel_Items.listener_MyReviewableItemsForCompany.remove()
            }
        }
        
    }
}




////MARK: Attempting to create graph here
//VStack {
//    VStack(alignment: .center, spacing: 2) {
//        Text(String(viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? -1))
//            .font(.system(size: 48))
//            .fontWeight(.semibold)
//            .foregroundColor(colorToShow[1])
//        Text("Current Balance")
//            .font(.system(size: 16))
//            .fontWeight(.semibold)
//            .foregroundColor(colorToShow[1])
//    }.padding(.horizontal)
//        .padding(.vertical)
//        .padding(.vertical)
//
//    HStack {
//        Button {
//            //navigate to the "understand tiers" page
//        } label: {
//            Text("450 to Platinum")
//                .font(.system(size: 14))
//                .fontWeight(.semibold)
//                .foregroundColor(Color("ThemeBright"))
//        }
//        Spacer()
//        Text("--------------------")
//    }
//
//    LineGraph(data: createLast60DaysPointsArray(transactions: viewModel3.last60DaysTransactions, currentBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0))
//        .frame(height: 200)
//        .padding(.bottom).padding(.bottom)
//
//
//    HStack (alignment: .center, spacing: 24) {
//        Button {
//            isCreateDiscountScreenActive.toggle()
//        } label: {
//            HStack {
//                Spacer()
//                Text("Redeem")
//                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                Spacer()
//            }.padding(.vertical, 12)
//            .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
//        }.fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
//            CreateDiscountScreen(isCreateDiscountScreenActive: $isCreateDiscountScreenActive, companyID: companyID, companyName: companyName, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0).navigationTitle("").navigationBarHidden(true)
//        })
//
//        Button {
//            //open website
//        } label: {
//            HStack {
//                Spacer()
//                Link(destination: URL(string: urlToShopifySite)!) {
//                    Text("Visit site")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//                Spacer()
//            }.padding(.vertical, 12)
//                .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
//        }
//    }.padding(.horizontal).padding(.horizontal)
//        .padding(.bottom)
//}



struct DiscountCodeSolo: View {
    
    var image: String
    var size: Int? = 48
    var firstLine: String
    var secondLine: String
    var secondLineColor: Color? = Color("Gray2")
    var buttonTitle: String? = ""
    var status: String
    var code: String
    
    @Binding var isActive: Bool
    
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            HStack {
                Image(systemName: image)
                    .foregroundColor(Color("ThemePrimary"))
                    .font(.system(size: CGFloat(size!)))
                VStack(alignment: .leading, spacing: 3) {
                    Text(firstLine + " " + status)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(secondLine + " " + code)
                        .font(secondLineColor! == Color("Gray2") ? .system(size: 16) : .system(size: 14))
                        .fontWeight(secondLineColor! == Color("Gray2") ? .regular : .semibold)
                        .foregroundColor(secondLineColor)
                }
                Spacer()
                if !buttonTitle!.isEmpty {
                    Text(buttonTitle!)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))

                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Gray2"))
                        .font(Font.system(size: 15, weight: .semibold))
                }
            }.padding(.horizontal, 12)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        }
        .padding(.horizontal)
    }
}
