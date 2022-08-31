//
//  SuggestAShopPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/2/22.
//

import SwiftUI
import FirebaseAuth

struct SuggestAShopPreview: View {
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    
    @State var isSuggestAShopActive:Bool = false
    
    @Binding var isShowingDetailView:Bool
    
    var body: some View {
        NavigationView {
//        ZStack(alignment: .top) {
//            Color("Background")
//
            VStack {
                ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    //Title
                    HStack {
                        Text("Top Suggestions")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Dark1"))
                        Spacer()
                        Button {
                            isSuggestAShopActive.toggle()
                        } label: {
                            Text("Add one")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 16)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color(red: 244/255, green: 244/255, blue: 244/255)))
                        }.fullScreenCover(isPresented: $isSuggestAShopActive) {
                            SuggestAShop(isSuggestAShopActive: $isSuggestAShopActive)
                        }
                    }.padding(.top)
                        .padding(.horizontal)
                    
                    //Body
                    
                    Text("here's the button")
                    Button {
                        isShowingDetailView.toggle()
                    } label: {
                        Text("CLICK HERE")
                    }
                    
                    VStack {
                        Text("use a table here for formatting!!!")
                        HStack {
                            Image(systemName: "link")
                                .foregroundColor(.blue)
                            Text("Company")
                            Spacer()
                            Text("15")
                            Image(systemName: "arrow.up")
                                .foregroundColor(.blue)
                            Spacer()
                            Image(systemName: "arrow.up.circle")
                                .foregroundColor(.black)
                        }
//                        //FOR EACH LOYALTY PROGRAM, SHOW IT HERE
//                        ForEach(viewModel1.myRewardsPrograms) { RewardsProgram in
//
//                            NavigationLink(destination: CompanyProfileV2(companyID: RewardsProgram.companyID, companyName: RewardsProgram.companyName, email: RewardsProgram.email, userID: RewardsProgram.userID)) {
//                                RewardsProgramWidget(image: RewardsProgram.companyName, company: RewardsProgram.companyName, status: RewardsProgram.status, currentPointsBalance: RewardsProgram.currentPointsBalance).padding(.bottom, 8)
//                            }
//                        }
                    }.padding()

                }
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                .padding()
                }//.ignoresSafeArea()
            }//.padding(.top, 96)//.ignoresSafeArea()
        //}
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
//        .navigationBarItems(leading:
//            Button {
//            isShowingDetailView.toggle()
//        } label: {
//            Image(systemName: "arrow.left")
//        })
        
    }
        //.ignoresSafeArea()
        //.navigationBarTitle("Suggest a Shop", displayMode: .inline)
//        .onAppear(perform: {
//                self.viewModel1.listenForMyRewardsPrograms(email: Auth.auth().currentUser?.email ?? "")
//                print("CURRENT USER IS")
//                print(Auth.auth().currentUser?.email ?? "")
//                print(self.viewModel1.myRewardsPrograms)
//            })
//        .onDisappear {
//                print("DISAPPEAR")
//                if self.viewModel1.listener1 != nil {
//                    print("REMOVING LISTENER")
//                    self.viewModel1.listener1.remove()
//                }
//        }
    }
}

struct SuggestAShopPreview_Previews: PreviewProvider {
    static var previews: some View {
        SuggestAShopPreview(isShowingDetailView: .constant(true))
    }
}
