//
//  Rewards.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage


//how to merge and store two firestore queries
//https://stackoverflow.com/questions/65688706/how-to-merge-two-queries-using-firestore-swift


struct Rewards: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    //@State var shouldShowFirstRunExperience: Bool = true
    
    //Read data from Firebase
    @StateObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @StateObject var companiesViewModel = CompaniesViewModel()
    
    //Binding variables to be passed downstream
    @Binding var selectedTab:Int
    
    
    var body: some View {
            
        NavigationView{
                
            //MARK: Content
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: VStack Section 2 - Scrollview
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //MARK: ALL SECTIONS OF CONTENT (E.G. "YOUR LOYALTY PROGAMS" / "DISCOVER" / "NEW" ...)
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //check if user has any loyalty programs
                        if rewardsProgramViewModel.snapshotOfMyRewardsPrograms.isEmpty {
                            
                            getStarted
                            
                        } else {
                            
                            myShops
                                .padding(.bottom)
                                .padding(.bottom)
                            
                            //allShops
                            
                        }
                        
                    }.padding(.top)
                        
                }
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationTitle("Rewards").foregroundColor(.white)
            .onAppear {
                self.rewardsProgramViewModel.getSnapshotOfMyRewardsPrograms(userID: Auth.auth().currentUser?.uid ?? "")
                self.companiesViewModel.getSnapshotOfAllCompanies()
                
            }
            
            
        }
//        .(isPresented: $shouldShowFirstRunExperience) {
//            FirstRunExperience(shouldShowFirstRunExperience: $shouldShowFirstRunExperience)
//        }
    }
    
    
    //MARK: MY SHOPS CARD
    var myShops: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: MY SHOPS CONTENT
            VStack(alignment: .leading, spacing: 0) {
                
                Text("ACTIVE")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.green)
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
                
                Text("Your Shops")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("Dark1"))
                    .padding(.bottom)
                    .padding(.bottom)
                
                //ForEach...
                ForEach(rewardsProgramViewModel.snapshotOfMyRewardsPrograms) { rewardsProgramVar in
                    
                    NavigationLink(destination: RewardsForShop(selectedTab: $selectedTab, rewardsProgram: rewardsProgramVar)) {
                        
                        if rewardsProgramVar.ids.companyID == rewardsProgramViewModel.snapshotOfMyRewardsPrograms.last?.ids.companyID {
                            ActiveLoyaltyProgramWidget(rewardsProgram: rewardsProgramVar, image: rewardsProgramVar.card.companyName, company: rewardsProgramVar.card.companyName, status: rewardsProgramVar.status.status, currentPointsBalance: rewardsProgramVar.status.currentPointsBalance, isLastItemInList: true)
                        } else {
                            ActiveLoyaltyProgramWidget(rewardsProgram: rewardsProgramVar, image: rewardsProgramVar.card.companyName, company: rewardsProgramVar.card.companyName, status: rewardsProgramVar.status.status, currentPointsBalance: rewardsProgramVar.status.currentPointsBalance, isLastItemInList: false)
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
//
//    //MARK: ALL SHOPS CARD
//    var allShops: some View {
//
//        VStack(alignment: .leading, spacing: 0) {
//
//            Divider()
//
//            //MARK: ACTIVE SECTION CONTENT
//            VStack(alignment: .leading, spacing: 0) {
//
//                Text("All Shops")
//                    .font(.system(size: 25, weight: .bold))
//                    .foregroundColor(Color("Dark1"))
//                    .padding(.top)
//                    .padding(.bottom)
//                    .padding(.bottom)
//
//                let array = rewardsProgramViewModel.snapshotOfMyRewardsPrograms.map { $0.ids.companyID }
//
////                ForEach(companiesViewModel.snapshotOfAllCompanies) { company in
////
////                    if array.contains(company.companyID) {
////
////                        NavigationLink(destination: RewardsForShop(companyID: company.companyID, companyName: company.companyName, email: Auth.auth().currentUser?.email ?? "", userID: Auth.auth().currentUser?.uid ?? "", selectedTab: $selectedTab)) {
////
////                            AllLoyaltyProgramsWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, isAlreadyJoined: true, numOfRecentOrders: 4)
////                        }
////
////                    } else {
////
////                        //MARK: MUST UPDATE FOR IS LAST ITEM IN LIST!!!
////                        NavigationLink {
////                            AddLoyaltyProgramPreview(company: company, userID: Auth.auth().currentUser?.uid ?? "", email: Auth.auth().currentUser?.email ?? "")
////                        } label: {
////                            AllLoyaltyProgramsWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, isAlreadyJoined: false, numOfRecentOrders: 4)
////                        }
////                    }
////                }
//
//
//            }
//            .padding(.horizontal)
//
//        }
//        .padding(.bottom)
//        .background(.white)
//        .padding(.top)
//        .padding(.top)
//
//    }
//
    //MARK: GET STARTED CARD
    var getStarted: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Welcome to the Rewards page!\n\nEarn rewards for purchases, reviews, and referrals at your favorite shops.")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color("Dark1"))
                .multilineTextAlignment(.leading)
                .lineSpacing(CGFloat(4))
                .padding(.horizontal)
                .padding(.leading, 2)
                .padding(.bottom)
                .padding(.bottom)
            
            
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: MY SHOPS CONTENT
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("GET STARTED")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.gray)
                        .padding(.vertical, 6)
                        .padding(.leading, 2)
                    
                    Text("Join a shop's rewards program")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    
                    ForEach(companiesViewModel.snapshotOfAllCompanies) { company in
                        
                        //MARK: MUST UPDATE FOR IS LAST ITEM IN LIST!!!
                        NavigationLink {
                            AddLoyaltyProgramPreview(company: company, userID: Auth.auth().currentUser?.uid ?? "", email: Auth.auth().currentUser?.email ?? "")
                        } label: {
                            RecommendedLoyaltyProgramWidget(image: company.image, company: company.companyName, shortDescription: company.categoryShortDescription, joiningBonus: company.joiningBonus, joiningBonusType: company.joiningBonusType, isLastItemInList: false, numOfRecentOrders: 4)
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
    
}
