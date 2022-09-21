//
//  AddLoyaltyProgramPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/6/22.
//

import SwiftUI


//need to change this view to just be getting a snapshot

struct AddLoyaltyProgramPreview: View {
    
    @StateObject var viewModel_companies = CompaniesViewModel()
    
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()

    @State var isAddLoyaltyProgramCarouselActive : Bool = false
    
    var company: Companies
    
    var userID: String
    
    var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            let array = rewardsProgramViewModel.myRewardsPrograms.map {$0.companyID}
            
            
            //MARK: HEADER OF PAGE
            ZStack(alignment: .top) {
                Image("BlueGoldenRatio")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Spacer()
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Image("Athleisure LA")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                            .padding(.trailing)
                        Text("Athleisure LA")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding([.leading, .bottom])
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
                    .layoutPriority(-1)
            
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
            
            //MARK: ABOUT US SECTION
            VStack(alignment: .leading, spacing: 0) {
                Text("About Us")
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                Text("We make very high quality products for all your athletic needs")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 16, weight: .medium))
            }
            .padding()
            .padding(.vertical)
            
            //MARK: MOST POPULAR SECTION

            VStack(alignment: .leading, spacing: 0) {
                Text("Athleisure Rewards")
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
            }.padding()
            
            
            List {

                //MARK: POINTS, TIME, QUESTIONS
                Section(header: Text("Rewards for influence")) {

                    HStack {

                        Text("Referrals")
                            .font(.system(size: 16))
                            .foregroundColor(.black)

                        Spacer()

                        Text("20K points")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("ReferPurple"))


                    }
                }

                //MARK: REFERRALS
                Section(header: Text("Other rewards")) {

                    HStack {
                        Text("Reviews")
                            .font(.system(size: 16))
                            .foregroundColor(.black)

                        Spacer()

                        Text("250 points")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)


                    }
                    
                    HStack {
                        Text("For each dollar spent")
                            .font(.system(size: 16))
                            .foregroundColor(.black)

                        Spacer()

                        Text("10 points")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)


                    }
                }
            }

            
            
//            VStack(alignment: .leading, spacing: 0) {
//
//                Text("We're known for these products")
//                    .multilineTextAlignment(.leading)
//                    .foregroundColor(Color("Dark1"))
//                    .font(.system(size: 20, weight: .bold))
//                    .padding(.horizontal)
//                    .padding(.bottom)
//
//                AddLoyaltyProgramPopularItemsTabView()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3 / 4)
//            }
//            .padding(.bottom, 40)
            
            
            
            
            Spacer()
            
            
            Button(action: {
                isAddLoyaltyProgramCarouselActive = true
            }) {
                
                array.contains(company.companyID) ? BottomCapsuleButton(buttonText: "Joined", color: Color.green) : BottomCapsuleButton(buttonText: "Join \(company.companyName) Rewards", color: Color("ReferPurple"))
               
            }.sheet(isPresented: $isAddLoyaltyProgramCarouselActive) {
                //on dismiss....
                
            } content: {
                JoinLoyaltyProgram1(company: company, isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive, userID: userID, email: email)
                //AddLoyaltyProgramCarousel(isAddLoyaltyProgramCarouselActive: $isAddLoyaltyProgramCarouselActive)
            }.disabled(array.contains(company.companyID))
        }
        .ignoresSafeArea()
        .background(Color("Background"))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewModel_companies.listenForMyCompanies()
            self.rewardsProgramViewModel.listenForMyRewardsPrograms(userID: userID)
        }
        .onDisappear {
            print("DISAPPEAR")
            if self.viewModel_companies.listener_myCompanies != nil {
                print("REMOVING LISTENER")
                self.viewModel_companies.listener_myCompanies.remove()
            }
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
