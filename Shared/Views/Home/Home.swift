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
    
    //Listeners for updates
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @ObservedObject var companiesViewModel = CompaniesViewModel()
    
    
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

    
    //@State var showFirstRunExperience:Bool
    
    
    var body: some View {
        
        NavigationView{
                
            //MARK: Content (ZStack Layer 2)
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: VStack Section 2 - Scrollview
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //MARK: ALL SECTIONS OF CONTENT (E.G. "YOUR LOYALTY PROGAMS" / "DISCOVER" / "NEW" ...)
                    VStack(alignment: .leading, spacing: 16) {
                        
                        //MARK: ACTIVE SECTION CARD
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //MARK: ACTIVE SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Header for section
                                Text("Active".uppercased())
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.green)
                                    .kerning(1.1)
                                    .padding(.bottom, 6)
                                Text("Your loyalty programs")
                                    .font(.system(size: 28, weight: .bold))
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
                        
                        //MARK: RECOMMENDED DIVIDER
                        Divider()
                            .padding(.top)
                            
                        Text("Recommended For You")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color("Dark1"))
                            .padding(.leading)
                            .padding(.bottom, 8)
                        
                        //MARK: RECOMMENDED SECTION CARD
                        VStack(alignment: .leading, spacing: 0) {
                                
                            //MARK: ACTIVE SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Header for section
                                Text("Quick Add")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom, 10)
                                
                                Text("You've shopped these stores before")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom)
                                    .padding(.bottom)
                                
                                let array = rewardsProgramViewModel.myRewardsPrograms.map { $0.companyID }
                                
                                ForEach(companiesViewModel.allCompanies) { company in
                                    
                                    if array.contains(company.companyID) {
                                        Text("already used")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    } else {
                                        Text(String(company.companyName))
                                            .foregroundColor(.black)
                                            .font(.title)
                                        
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
                        
                        
                        
                        //MARK: NEW SECTION CARD
                        VStack(alignment: .leading, spacing: 0) {
                                
                            //MARK: ACTIVE SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Header for section
                                Text("New".uppercased())
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.blue)
                                    .kerning(1.1)
                                    .padding(.bottom, 8)
                                Text("Check out the latest!")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom)
                                    .padding(.bottom)
                                
                                let array = rewardsProgramViewModel.myRewardsPrograms.map { $0.companyID }
                                
                                ForEach(companiesViewModel.allCompanies) { company in
                                    
                                    if array.contains(company.companyID) {
                                        Text("already used")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    } else {
                                        Text(String(company.companyName))
                                            .foregroundColor(.black)
                                            .font(.title)
                                        
                                    }
                                }
                                
                                
                                
                                
//                                //ForEach...
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 300)
//                                
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//                                
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 60000)
//                                
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//                                
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 3700)
//                                
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//                                
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 12)
//                                
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
                                        Text("SHOW VIEW BUTTON")
                                            .foregroundColor(.black)
                                            .font(.title)
                                    } else {
                                        Text("SHOW JOIN BUTTON")
                                            .foregroundColor(.black)
                                            .font(.title)
                                        
                                    }
                                }
                                
                                
//                                //ForEach...
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 300)
//
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 60000)
//
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 3700)
//
//                                Divider()
//                                    .padding(.leading, 72)
//                                    .padding(.vertical, 10)
//
//                                ActiveLoyaltyProgramWidget(image: "Athleisure LA", company: "Athleisure LA", status: "Silver", currentPointsBalance: 12)
//
                            }
                            .padding(.horizontal)
                            
                        }
                        .padding(.bottom)
                        .background(.white)
                        
                        
                        
                        
                        
                        
                        
                        
                        
//                        NavigationLink {
//                            Messages()
//                        } label: {
//                            Text("Go to messages to see a video")
//                        }


                    }.padding(.top)
                        
                    
                    //.background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)
                
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
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(selectedTab: .constant(1), showFirstRunExperience: .constant(false))
//    }
//}
