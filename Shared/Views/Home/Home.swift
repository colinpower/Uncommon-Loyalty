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
    
    @State var isAddCompanyPreviewShown:Bool = false
    @State var x : [CGFloat] = [0, 0, 0, 0, 0, 0]
    @State var colorbg : [Color] = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple]
    @State var endOfCards = false
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    //ScrollView(.horizontal) {
                    if x.count == 0 || endOfCards {
                        EmptyView()
                    } else {
                        ZStack {
                            ForEach(0..<x.count, id: \.self) { i in
                                ReviewOrReferWidget(colorbg: colorbg[i])
                                    .frame(width: geometry.size.width, height: geometry.size.height * 0.2, alignment: .center)
                                    .offset(x: self.x[i])
                                    .gesture(DragGesture()
                                        .onChanged({ value in
                                            if value.translation.width > 0 {
                                                self.x[i] = value.translation.width
                                            } else {
                                                self.x[i] = value.translation.width
                                            }
                                            
                                            
                                        })
                                        .onEnded({ value in
                                            if value.translation.width > 0 {
                                                if value.translation.width > 100 {
                                                    self.x[i] = geometry.size.width
                                                    if i == 0 {
                                                        withAnimation {
                                                            endOfCards = true
                                                        }
                                                        
                                                    }
                                                } else {
                                                    self.x[i] = 0
                                                }
                                            } else {
                                                if value.translation.width < -100 {
                                                    self.x[i] = -geometry.size.width
                                                    if i == 0 {
                                                        withAnimation {
                                                            endOfCards = true
                                                        }
                                                    }
                                                } else {
                                                    self.x[i] = 0
                                                }
                                            }
                                        }))
                            }
                        }
                    }

                    
                    HStack{
                        Text("Rewards").font(.system(size: 24)).foregroundColor(Color.black)
                        //Text("Rewards").font(.system(size: 24)).foregroundColor(Color(red: 0.82, green: 0.72, blue: 0.58))
                        Spacer()
                        Button {
                            isAddCompanyPreviewShown.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                        }


                        
    //                    Image(systemName: "person.crop.circle")
    //                        .foregroundColor(.black)
    //                        .font(.system(size: 30))
                    }.padding()
                        .padding(.horizontal, 12)
                    NavigationLink(destination: ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "", userID: "mhjEZCv9JGdk0NUZaHMcNrDsH1x2")) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                        }
                    ScrollView {
                        VStack {
                            ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
                                
                                
                                NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
                                        RewardsProgramWidget(companyName: RewardsProgram.companyName, image: RewardsProgram.companyName, currentPointsBalance: RewardsProgram.currentPointsBalance, status: RewardsProgram.status)
                                    }
                                
                            }
                        }
                    }
                    TabView(selectedTab: $selectedTab)
                    
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
    }
            
            //.navigationBarTitle("Rewards Programs", displayMode: .inline)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(selectedTab: .constant(1))
    }
}
