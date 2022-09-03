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
    
    @EnvironmentObject var viewModel: AppViewModel
    
    //Listeners for updates
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    @StateObject var ordersViewModel = OrdersViewModel()
    
    //Initialize variables
    @State var isAddCompanyActive:Bool = false
    @State var isAddCompanyPreviewActive:Bool = false               //might not need this one? Can create a dif @State var on the AddCompany screen
    @State var isProfileActive:Bool = false
    
    
    @State var isShowingAllOrders:Bool = false
    
    //Remove this one
    @State var showFirstRunExperience:Bool = true
    
    
    
    
    
    @Binding var selectedTab:Int

    
    var body: some View {
        
        NavigationView{
            
            GeometryReader { geometry in
                
                ZStack(alignment: .top) {
                    
                    
                    //MARK: Background (ZStack Layer 1)
                    Color("Background")
                    
                    //MARK: Content (ZStack Layer 2)
                    VStack(alignment: .leading) {
                        
                        //"Home" + Profile icon
                        //PageHeader(isProfileActive: $isProfileActive, pageTitle: "Home")
                        
                        
                        //MARK: VStack Section 2 - Scrollview
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            //MARK: Loyalty Programs
                            VStack(alignment: .leading) {
                                
                                //Title
                                HStack {
                                    Text("My Loyalty Programs")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                    Button {
                                        isAddCompanyPreviewActive.toggle()

                                    } label: {
                                        
                                        if rewardsProgramViewModel.myRewardsPrograms.first == nil {
                                            Text("Add")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 12)
                                                .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("ThemePrimary")))
                                        } else {
                                            Text("Add")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color("ThemeLight"))
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 12)
                                                .background(RoundedRectangle(cornerRadius: 19).foregroundColor(Color("ThemeAction")))
                                        }
                                    }.fullScreenCover(isPresented: $isAddCompanyPreviewActive, content: {
                                        AddCompanyPreview(isAddCompanyPreviewActive: $isAddCompanyPreviewActive)
                                    })
                                }
                                
                                NavigationLink {
                                    Messages()
                                } label: {
                                    Text("Go to messages to see a video")
                                }

                                
                                
                                //Body
                                VStack {
                                    
                                    ForEach(rewardsProgramViewModel.myRewardsPrograms) { RewardsProgram in
                                        
                                        
                                        NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID, selectedTab: $selectedTab)) {
                                            
                                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance)
                                        
                                        }
                                    }
                                }

                            }.padding().padding(.vertical)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)

                            
                        
                            
                
                            
                            
                            
                            
                        }
                    }
                    VStack {
                        Spacer()
                        MyTabView(selectedTab: $selectedTab)
                    }

                }
            }
            .background(.white)
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .navigationTitle("Accounts")
            //.navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            isProfileActive.toggle()
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                        }.fullScreenCover(isPresented: $isProfileActive) {
                            Profile(isProfileActive: $isProfileActive)
                        }
                    }
                }
            }
            
            .onAppear {
                self.rewardsProgramViewModel.listenForMyRewardsPrograms(email: viewModel.email ?? "")
                
                self.ordersViewModel.listenForAllOrders(userID: viewModel.userID ?? "")
                //self.ordersViewModel.snapshotOfAllOrders(userID: viewModel.userID ?? "")
                print("CURRENT USER IS")
                print(viewModel.email ?? "")
                
            }
            .onDisappear {
                print("DISAPPEAR")
                if self.rewardsProgramViewModel.listener1 != nil {
                    print("REMOVING LISTENER")
                    self.rewardsProgramViewModel.listener1.remove()
                }
                if self.ordersViewModel.listenerForAllOrders != nil {
                    print("REMOVING LISTENER FOR ALL ORDERS")
                    self.ordersViewModel.listenerForAllOrders.remove()
                }
                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(selectedTab: .constant(1))
    }
}
