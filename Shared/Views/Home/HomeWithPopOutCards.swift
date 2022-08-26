////
////  HomeWithPopOutCards.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 1/17/22.
////
//
//import SwiftUI
//import FirebaseAuth
//
//
////how to merge and store two firestore queries
////https://stackoverflow.com/questions/65688706/how-to-merge-two-queries-using-firestore-swift
//
//
//struct HomeWithPopOutCards: View {
//    
//    @EnvironmentObject var viewModel: AppViewModel
//    
//    //Listeners for updates
//    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
//    @ObservedObject var reviewsViewModel = ReviewsViewModel()
//    @ObservedObject var itemsViewModel = ItemsViewModel()
//    
//    
//    @StateObject var ordersViewModel = OrdersViewModel()
//    
//    
//    //For the clever pop up things
//    @Namespace var namespace1
//    @Namespace var namespace2
//    @State var isFeaturedWidget1Active:Bool = false
//    @State var isFeaturedWidget2Active:Bool = false
//    
//    //Initialize variables
//    @State var isAddCompanyActive:Bool = false
//    @State var isAddCompanyPreviewActive:Bool = false               //might not need this one? Can create a dif @State var on the AddCompany screen
//    @State var isProfileActive:Bool = false
//    @State var isSendFeedbackActive:Bool = false
//    
//    
//    @State var isShowingAllOrders:Bool = false
//    
//    //Remove this one
//    @State var showFirstRunExperience:Bool = true
//    
//    
//    //TEMP VAR
//    @State var isShowingDetailView = false
//    
//    
//    @Binding var selectedTab:Int
//
//    
//    var body: some View {
//        
//        NavigationView{
//            GeometryReader { geometry in
//                ZStack(alignment: .top) {
//                    
//                    
//                    //MARK: ZStack Layer 1 - Background
//                    Color("Background")
//                    
//                    //MARK: ZStack Layer 2 - Content
//                    VStack(alignment: .leading) {
//                        
//                        
//                        //MARK: VStack Section 1 - Header
//                        PageHeader(isProfileActive: $isProfileActive, pageTitle: "Home V2")
//                        
//                        
//                        //MARK: VStack Section 2 - Scrollview
//                        ScrollView(.vertical, showsIndicators: false) {
//                            
//                            
//                            //MARK: Loyalty Programs
//                            VStack(alignment: .leading) {
//                                
//                                //Title
//                                HStack {
//                                    Text("My Loyalty Programs")
//                                        .font(.system(size: 20))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color("Dark1"))
//                                    Spacer()
//                                    Button {
//                                        isAddCompanyPreviewActive.toggle()
//
//                                    } label: {
//                                        
//                                        if rewardsProgramViewModel.myRewardsPrograms.first == nil {
//                                            Text("Add")
//                                                .font(.system(size: 16))
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(Color.white)
//                                                .padding(.vertical, 6)
//                                                .padding(.horizontal, 12)
//                                                .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("ThemePrimary")))
//                                        } else {
//                                            Text("Add")
//                                                .font(.system(size: 16))
//                                                .fontWeight(.semibold)
//                                                .foregroundColor(Color("ThemeLight"))
//                                                .padding(.vertical, 6)
//                                                .padding(.horizontal, 12)
//                                                .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("ThemeAction")))
//                                        }
//                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
//                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
//                                    })
//                                }
//                                
//                                //Body
//                                VStack {
//                                    
//                                    ForEach(rewardsProgramViewModel.myRewardsPrograms) { RewardsProgram in
//                                        
//                                        
//                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
//                                            
//                                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance)
//                                        
//                                        }
//                                    }
//                                }
//
//                            }.padding().padding(.vertical)
//                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)
//
//                            
//                            //MARK: Quick actions
//                            VStack(alignment: .leading, spacing: 0) {
//                                
//                                //Title
//                                HStack {
//                                    Text("Quick actions")
//                                        .font(.system(size: 20))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color("Dark1"))
//                                    Spacer()
//                                }
//                                
//                                Text("Earn points for reviewing recent purchases or referring favorite items to your friends.")
//                                    .font(.system(size: 16))
//                                    .fontWeight(.regular)
//                                    .foregroundColor(Color("Gray1"))
//                                    .multilineTextAlignment(.leading)
//                                    .lineSpacing(8)
//                                    .padding(.vertical, 16)
//                                
//                                //Body
//                                VStack(alignment: .leading) {
//                                    MyQuickActionsItem(companyImage: "Athleisure LA", company: "Athleisure LA", item: "JOGGERS", action: "Review")
//                                    MyQuickActionsItem(companyImage: "LululemonGold", company: "Lululemon", item: "Sweatshirt", action: "Refer")
//                                }.padding(.top)
//                            }.padding().background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)
//                            
//                            
//                            //MARK: Recent Orders
//                            VStack(alignment: .leading) {
//                                
//                                //Header
//                                HStack {
//                                    Text("Recent Orders")
//                                        .font(.system(size: 18))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color("Dark1"))
//                                    Spacer()
//                                }
//                                
//                                //For each recent order, show an item
//                                
//                                ForEach(ordersViewModel.allOrders.prefix(5)) { Order in
//                                    
//                                    NavigationLink(destination: OneOrder(email: Order.email, companyID: Order.companyID, orderID: Order.orderID)) {
//                                        MyRecentOrdersItem(item: Order.item_firstItemTitle, timestamp: Order.timestamp, reviewID: Order.orderID, colorToShow: Color("Dark1"))
//                                    }
//                                }
//                                HStack {
//                                    Spacer()
//                                    Button {
//                                        isShowingAllOrders = true
//                                    } label: {
//                                        Text("See all")
//                                            .font(.system(size: 16))
//                                            .fontWeight(.semibold)
//                                            .foregroundColor(Color("ThemeAction"))
//                                    }.fullScreenCover(isPresented: $isShowingAllOrders) {
//                                        //AllOrders(userID: viewModel.userID ?? "", isShowingAllOrders: $isShowingAllOrders)
//                                    }
//                                    Spacer()
//                                }
//                            }.padding()
//                                .padding(.vertical)
//                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
//                            .padding(.horizontal)
//                            .padding(.bottom)
//                            
//                            
//                            
//                            //MARK: Discover company (beautiful animation)
//                            //https://www.youtube.com/watch?v=f0wYIYfPBa4
//                            FeaturedWidget1(namespace: namespace1, isFeaturedWidget1Active: $isFeaturedWidget1Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure")
//                                .onTapGesture {
//                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                                        isFeaturedWidget1Active.toggle()
//                                    }
//                                }
//                            
//                            
//                            //MARK: Discover company (beautiful animation)
//                            //https://www.youtube.com/watch?v=f0wYIYfPBa4
//                            FeaturedWidget2(namespace: namespace2, isFeaturedWidget2Active: $isFeaturedWidget2Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure")
//                                .onTapGesture {
//                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                                        isFeaturedWidget2Active.toggle()
//                                    }
//                                }
//                            
//                            
//                            //MARK: HELP US IMPROVE
//                            WideWidgetHeader(title: "HELP US IMPROVE")
//                            VStack {
//                                
//                                NavigationLink(destination: SuggestAShopPreview(isShowingDetailView: $isShowingDetailView).navigationBarTitle("", displayMode: .inline).navigationBarHidden(true), isActive: $isShowingDetailView) {
//                                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
//                                }
//
//                                
////                                Button("Tap to show detail") {
////                                    self.isShowingDetailView = true
////                                }
//                                
////                                NavigationLink(destination: SuggestAShopPreview()) {
////
////                                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
////
////                                }.padding(.bottom)
//                                
//                                //Send feedback
//                                Button {
//                                    isSendFeedbackActive.toggle()
//                                } label: {
//                                    WideWidgetItem(image: "bubble.left.circle.fill", size: 40, title: "Send feedback", subtitle: "We respond super fast!")
//                                }.fullScreenCover(isPresented: $isSendFeedbackActive) {
//                                    SendFeedback(isSendFeedbackActive: $isSendFeedbackActive)
//                                }
//
//                            }.padding(.horizontal, 12).padding(.vertical).background(.white)
//                            
//                        }
//                    }
//                    VStack {
//                        Spacer()
//                        MyTabView(selectedTab: $selectedTab)
//                    }
//                    
//                    if isFeaturedWidget1Active {
//                        FeaturedView1(namespace: namespace1, isFeaturedWidget1Active: $isFeaturedWidget1Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure", height: geometry.size.height)
//                    }
//                    
//                    if isFeaturedWidget2Active {
//                        FeaturedView2(namespace: namespace2, isFeaturedWidget2Active: $isFeaturedWidget2Active, category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure", height: geometry.size.height)
//                    }
//                }
//            }
//            .ignoresSafeArea()
//            .navigationTitle("")
//            .navigationBarHidden(true)
//            .onAppear {
//                self.rewardsProgramViewModel.listenForMyRewardsPrograms(email: viewModel.email ?? "")
//                
//                self.ordersViewModel.listenForAllOrders(userID: viewModel.userID ?? "")
//                //self.ordersViewModel.snapshotOfAllOrders(userID: viewModel.userID ?? "")
//                print("CURRENT USER IS")
//                print(viewModel.email ?? "")
//                
//            }
//            .onDisappear {
//                print("DISAPPEAR")
//                if self.rewardsProgramViewModel.listener1 != nil {
//                    print("REMOVING LISTENER")
//                    self.rewardsProgramViewModel.listener1.remove()
//                }
//                if self.ordersViewModel.listenerForAllOrders != nil {
//                    print("REMOVING LISTENER FOR ALL ORDERS")
//                    self.ordersViewModel.listenerForAllOrders.remove()
//                }
//                
//            }
//        }
//    }
//}
//
//struct HomeWithPopOutCards_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeWithPopOutCards(selectedTab: .constant(1))
//    }
//}