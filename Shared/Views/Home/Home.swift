//
//  Home.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth


//how to merge and store two firestore queries
//https://stackoverflow.com/questions/65688706/how-to-merge-two-queries-using-firestore-swift


struct Home: View {
    
    
    @AppStorage("shouldShowFirstRunExperience")
    private var shouldShowFirstRunExperience: Bool = true
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Namespace var home_Animation
    
    //Listeners for updates
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @ObservedObject var companiesViewModel = CompaniesViewModel()
    @ObservedObject var discountCodesViewModel = DiscountCodesViewModel()
    
    
    @ObservedObject var testObjectViewModel = TestObjectViewModel()
    
    
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    @StateObject var ordersViewModel = OrdersViewModel()
    
    //Initialize variables
    @State var isAddCompanyActive:Bool = false
    @State var isAddCompanyPreviewActive:Bool = false               //might not need this one? Can create a dif @State var on the AddCompany screen
    @State var isProfileActive:Bool = false
    
    @State var isShowingAllOrders:Bool = false
    
    //Remove this one
    @Binding var selectedTab:Int
    
    
    @State var isReferralCardSelected:Bool = false
    @State var referralCardSelected:DiscountCodes?
    

    
    //@State var showFirstRunExperience:Bool
    
    
    var body: some View {
            
        NavigationView{
                
            //MARK: Content
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: VStack Section 2 - Scrollview
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //MARK: ALL SECTIONS OF CONTENT (E.G. "YOUR LOYALTY PROGAMS" / "DISCOVER" / "NEW" ...)
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //MARK: MY SHOPS CARD
                        yourShops
                        
                        //MARK: REFERRALS RECEIVED
                        Divider()
                            .padding(.top)
                            .padding(.vertical)
                            
                        Text("Referrals You've Received")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("Dark1"))
                            .padding()
                        
                        //MARK: REFERRALS YOU'VE RECEIVED CARD
                        TabViewForReferralsYouveReceived(discountCodes: discountCodesViewModel.myDiscountCodes)
                            .padding(.bottom)
                            .padding(.bottom)
                        
                        
                        //, isReferralCardSelected: $isReferralCardSelected, referralCardSelected: $referralCardSelected, home_Animation: home_Animation)
                            
                        
                        
                        //MARK: RECOMMENDED SECTION CARD
                        VStack(alignment: .leading, spacing: 0) {
                                
                            //MARK: ACTIVE SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Header for section
                                Text("Quick Add")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom, 10)
                                
                                Text("You've shopped these stores before")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom)
                                    .padding(.bottom)
                                
                                let array = rewardsProgramViewModel.myRewardsPrograms.map { $0.companyID }
                                
                                ForEach(companiesViewModel.allCompanies) { company in
                                    
                                    //Check if the loyalty program isn't already in use
                                    if !array.contains(company.companyID) {
                                        
                                        //MARK: MUST UPDATE FOR IS LAST ITEM IN LIST!!!
                                        NavigationLink {
                                            AddLoyaltyProgramPreview(company: company)
                                        } label: {
                                            RecommendedLoyaltyProgramWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, numOfRecentOrders: 4)
                                        }
                                    }
                                }

                            }
                            
                        }
                        .padding().padding(.bottom)
                        .background(RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 7)
                        )
                        .padding(.horizontal)
                        
                        
                        
                        
                        
                        //MARK: ALL SECTION
                        VStack(alignment: .leading, spacing: 0) {
                            Divider()
                                
                            //MARK: ACTIVE SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                
                                
                                Text("All Programs")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.top)
                                    .padding(.bottom)
                                    .padding(.bottom)
                                
                                
                                let array = rewardsProgramViewModel.myRewardsPrograms.map { $0.companyID }
                                
                                ForEach(companiesViewModel.allCompanies) { company in
                                    
                                    if array.contains(company.companyID) {
                                        
                                        AllLoyaltyProgramsWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, isAlreadyJoined: true, numOfRecentOrders: 4)
                                    } else {
                                        AllLoyaltyProgramsWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, isAlreadyJoined: false, numOfRecentOrders: 4)
                                    }
                                }
                                

                            }
                            .padding(.horizontal)
                            
                        }
                        .padding(.bottom)
                        .background(.white)
                        .padding(.top)
                        .padding(.top)
                        

                    }.padding(.top)
                        
                }
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationTitle("Accounts").foregroundColor(.white)
            //.navigationBarHidden(true)
            
            .onAppear {
                self.rewardsProgramViewModel.listenForMyRewardsPrograms(email: viewModel.email ?? "")
                
                self.companiesViewModel.listenForAllCompanies()
                
                self.testObjectViewModel.getSnapshotOfItem()
                
                self.discountCodesViewModel.listenForMyDiscountCodes(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM")
                
                //self.ordersViewModel.listenForAllOrders(userID: viewModel.userID ?? "")
                //self.ordersViewModel.snapshotOfAllOrders(userID: viewModel.userID ?? "")
                print("CURRENT USER IS")
                print(viewModel.email ?? "")
                
                //showFirstRunExperience = true
                
            }
            .onDisappear {
                print("DISAPPEAR")
                if self.rewardsProgramViewModel.listener1 != nil {
                    print("REMOVING LISTENER")
                    self.rewardsProgramViewModel.listener1.remove()
                }
            }
        }.sheet(isPresented: $shouldShowFirstRunExperience) {
            FirstRunExperience(shouldShowFirstRunExperience: $shouldShowFirstRunExperience)
        }
    }
    
    var yourShops: some View {
        
        
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: MY SHOPS CONTENT
            VStack(alignment: .leading, spacing: 0) {
                       
                Text("Your Shops")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom)
                    .padding(.bottom)
                
                //ForEach...
                ForEach(rewardsProgramViewModel.myRewardsPrograms) { rewardsProgramVar in
                    
                    NavigationLink(destination: CompanyProfileV2(companyID: rewardsProgramVar.companyID, companyName: rewardsProgramVar.companyName, email: rewardsProgramVar.email, userID: rewardsProgramVar.userID, selectedTab: $selectedTab)) {
                        
                        if rewardsProgramVar.companyID == rewardsProgramViewModel.myRewardsPrograms.last?.companyID {
                            ActiveLoyaltyProgramWidget(image: rewardsProgramVar.companyName, company: rewardsProgramVar.companyName, status: rewardsProgramVar.status, currentPointsBalance: rewardsProgramVar.currentPointsBalance, isLastItemInList: true)
                        } else {
                            ActiveLoyaltyProgramWidget(image: rewardsProgramVar.companyName, company: rewardsProgramVar.companyName, status: rewardsProgramVar.status, currentPointsBalance: rewardsProgramVar.currentPointsBalance, isLastItemInList: false)
                        }
                        
                    }
                }
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


struct DetailReferredCardView: View {
    
    @Binding var isReferralCardSelected: Bool
    
    
    
    
    
    var referredCard: DiscountCodes
    
    
    //Matched geometry effect
    var home_Animation: Namespace.ID
    
    @State var isShowingCompanyDetails = false
    @State var isShowingHowDoIUseDiscount = false
    
    @State var isLoadingRecommendedItems = false
    
    
    var recommendationsTEMP = ["OPTION 1", "OPTION 2", "OPTION 3"]
    
    //var cardWidth: CGFloat
    
    var body: some View {
        ZStack {
            Color("Background")
            
            GeometryReader { geometry in
                    VStack {
                        //MARK: HEADER
                        HStack {
                            Button {
                                withAnimation(.easeInOut) {
                                    isReferralCardSelected = false
                                }
                            } label : {
                                Text("Done")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            Button {
                                isShowingCompanyDetails.toggle()
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 23, weight: .medium))
                                    .foregroundColor(.black)
                            }.sheet(isPresented: $isShowingCompanyDetails) {
                                CompanyDetailsModal(isShowingCompanyDetails: $isShowingCompanyDetails)
                            }
                            
                        }.padding(.top, 60).padding(.horizontal)
                        
                        //MARK: CARD
                        CardForLoyaltyProgram(cardColor: Color.blue, textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Silver", discountCardDescription: "Personal Card")
                            .matchedGeometryEffect(id: referredCard.id, in: home_Animation)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isReferralCardSelected = false
                                    
                                    print("IN THE DETAIL VIEW PRINTING GEOMETRY")
                                    print(geometry.size.width)
                                    print(geometry.size.height)
                                }
                                
                            }
                            .gesture(DragGesture(minimumDistance: 80, coordinateSpace: .local)
                                .onEnded({ value in
                                    if value.translation.height > 0 {
                                        withAnimation(.easeInOut) {
                                            isReferralCardSelected = false
                                        }
                                    }
                                }))
                        
                        //MARK: BUTTONS
                        HStack(spacing: 12) {
                            Button {
                                //copy
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Copy code").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                            }
                            
                            Button {
                                //copy
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Visit website").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                            }
                            
                        }.padding(.horizontal)
                            .padding(.bottom)
                
                        //MARK: HOW DO I USE THIS DISCOUNT
                        Button {
                            //copy
                        } label: {
                            HStack {
                                Text("How do I use this discount?").font(.system(size: 15, weight: .regular)).padding(.vertical)
                                Spacer()
                            }.padding(.leading)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        }.sheet(isPresented: $isShowingHowDoIUseDiscount) {
                            HowToUseDiscountModal(isShowingHowDoIUseDiscount: $isShowingHowDoIUseDiscount)
                        }.padding(.bottom).padding(.horizontal)
                            
                            
                    
                        //MARK: EXTRA CONTENT
                        if isLoadingRecommendedItems {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                        .scaleEffect(2)
                                    Spacer()
                                }
                                Spacer()
                            }.background(Color("Background"))
                        } else {
                            HStack {
                                Text("Popular this month")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                Spacer()
                            }.padding(.horizontal)
                            .padding(.bottom, 4)
                            
                            
                            
                            TabView {
                                RecommendedItem
                                RecommendedItem
                                RecommendedItem
                                RecommendedItem
                            }//.frame(height: UIScreen.main.bounds.height/2)
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                        }
                    
                                    
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            //DO STUFF HERE
            print("need to hook up to real data")
            startLoadingRecommendedItems()
        }
    }
    
    
    func startLoadingRecommendedItems() {
        isLoadingRecommendedItems = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoadingRecommendedItems = false
        }
    }
    
    
    
    
    var RecommendedItem: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text("ABC Shorts")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 24)
                    .padding(.bottom, 2)
                HStack(alignment: .center, spacing: 6) {
                    Text("Normally $99").strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                    Text("$79 after discount")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                }
                Spacer()
                Image("redshorts")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                Spacer()
                Button {
                    //copy
                } label: {
                    HStack {
                        Spacer()
                        Text("View on website").font(.system(size: 16, weight: .semibold)).padding(.vertical)
                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                }.padding(.horizontal).padding(.bottom)
                
            }
                
                
            Spacer()
        }.background(.white)
        
        
        
        
    }
    
    
    
    
}






extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
