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
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("Rewards").font(.system(size: 24)).foregroundColor(Color.black)
                    //Text("Rewards").font(.system(size: 24)).foregroundColor(Color(red: 0.82, green: 0.72, blue: 0.58))
                    Spacer()
                    NavigationLink(destination: AddCompanyPreview()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                        }
                    
//                    Image(systemName: "person.crop.circle")
//                        .foregroundColor(.black)
//                        .font(.system(size: 30))
                }.padding()
                .padding(.horizontal, 12)
                ScrollView {
                    VStack {
                        ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in

//                            NavigationLink(destination: CompanyProfile(company: RewardsProgram.company, status: RewardsProgram.status, showingDiscountScreen: $showingDiscountScreen)) {
//                                RewardsProgramWidget(company: RewardsProgram.company, image: RewardsProgram.image, points: RewardsProgram.currentPoints, status: RewardsProgram.status)
//                            }
                            //Need
                            
                            
                            NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                    RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
                                }
                            
                        }
                    }
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                    self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
                    print("CURRENT USER IS")
                    print(Auth.auth().currentUser?.email ?? "")
                    print(self.viewModel1.myRewardsPrograms)
                })
            .onDisappear {
                    print("DISAPPEAR")
                    if self.viewModel1.listener1 != nil {
                        print("REMOVING LISTENER")
                        self.viewModel1.listener1.remove()
                    }
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
