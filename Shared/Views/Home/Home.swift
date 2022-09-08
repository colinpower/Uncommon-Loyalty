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
                                
                                ForEach(testObjectViewModel.snapshotOfTestObject) { testObject in
                                    VStack {
                                        Text(String(testObject.pointsPerDollarSpent))
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.green)
                                        Text(String(testObject.pointsPerLevel.gold))
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.green)
                                        Text(String(testObject.pointsPerLevel.silver))
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.green)
                                        Text(String(testObject.pointsPerLevel.subLevelsArray.gold))
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.green)
                                        
                                    }
                                }
                                
                                Button {
                                    testObjectViewModel.addSnapshotOfItem(pointsPerDollarSpent: 500, pointsPerLevel: LevelsArray(gold: 5, silver: 10, platinum: 50, subLevelsArray: SubLevelsArray(gold: 100)))
                                } label : {
                                    Text("push button to post back to Firebase")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.green)
                                }
                                
                                
                                
                                //Header for section
                                Text("Active".uppercased())
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.green)
                                    .kerning(1.1)
                                    .padding(.bottom, 6)
                                Text("Your loyalty programs")
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
                        
                        
                        
                        //MARK: NEW SECTION CARD
                        VStack(alignment: .leading, spacing: 0) {
                                
                            //MARK: NEW SECTION CONTENT
                            VStack(alignment: .leading, spacing: 0) {
                                
                                //Header for section
                                Text("New!".uppercased())
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.blue)
                                    .kerning(1.1)
                                    .padding(.bottom, 8)
                                Text("The newest companies on Uncommon")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color("Dark1"))
                                    .padding(.bottom)
                                    .padding(.bottom)
                                
                                let array = rewardsProgramViewModel.myRewardsPrograms.map { $0.companyID }
                                
                                ForEach(companiesViewModel.allCompanies) { company in
                                    
                                    if !array.contains(company.companyID) {
                                        
                                        //MARK: MUST UPDATE FOR IS LAST ITEM IN LIST!!!
                                        NewLoyaltyProgramWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, isAlreadyJoined: false, numOfRecentOrders: 4)
                                        
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
                
                self.testObjectViewModel.getSnapshotOfItem()
                
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




extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
