//
//  Home.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    
    //@State var showingDiscountScreen: Bool = false
    @ObservedObject var viewModel = RewardsProgramViewModel()
    
    
    var body: some View {
            VStack {
                HStack{
                    Text("Rewards").font(.system(size: 24)).foregroundColor(Color.black)
                    //Text("Rewards").font(.system(size: 24)).foregroundColor(Color(red: 0.82, green: 0.72, blue: 0.58))
                    Spacer()
//                    Image(systemName: "person.crop.circle")
//                        .foregroundColor(.black)
//                        .font(.system(size: 30))
                }.padding()
                .padding(.horizontal, 12)
                ScrollView {
                    VStack {
                        ForEach(viewModel.myRewardsPrograms) { RewardsProgram in

//                            NavigationLink(destination: CompanyProfile(company: RewardsProgram.company, status: RewardsProgram.status, showingDiscountScreen: $showingDiscountScreen)) {
//                                RewardsProgramWidget(company: RewardsProgram.company, image: RewardsProgram.image, points: RewardsProgram.currentPoints, status: RewardsProgram.status)
//                            }
                            //Need
                            
                            
                            NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                    RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
                                }
                            
                        }
                    }
                }
                
            }
            .navigationTitle("")
                .navigationBarHidden(true)
            .onAppear(perform: {
                self.viewModel.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
                print("CURRENT USER IS")
                print(Auth.auth().currentUser?.email ?? "")
                print(self.viewModel.myRewardsPrograms)
            })
            .onDisappear {
                if self.viewModel.listener1 != nil {
                    self.viewModel.listener1.remove()
                }
            }
            //.navigationBarTitle("Rewards Programs", displayMode: .inline)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
