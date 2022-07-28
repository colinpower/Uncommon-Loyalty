//
//  Feed.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI

struct Feed: View {
    
    @Binding var selectedTab: Int
    //@State private var showingRewardsScreen: Bool = false
    //@ObservedObject var viewModel = PostInFeedViewModel()
    
    var body: some View {
            VStack {
                HStack{
                    Text("For you").font(.system(size: 24)).foregroundColor(Color.black)
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                }.padding()
                .padding(.horizontal, 12)
                ScrollView {
                    VStack {
//                        NavigationLink(destination: ReviewProduct(companyID: <#String#>, email: <#String#>, orderID: <#String#>, userID: <#String#>)) {
//                            ReviewWidget()
//                        }.padding(.vertical, 12)
                        Divider()
                        NavigationLink(destination: VoteOnProduct()) {
                            VoteWidget()
                        }.padding(.vertical, 12)
                        Divider()
                        NavigationLink(destination: SaleForProduct()) {
                            SaleWidget()
                        }.padding(.vertical, 12)
//                        ForEach(viewModel.myPostsInFeed) { PostInFeed in
//
//                            NavigationLink(destination: SaleForProduct(company: PostInFeed.company)) {
//                                FeedWidget(company: RewardsProgram.company, points: RewardsProgram.currentPoints)
//                            }
//                        }
                    }
                }
                TabView(selectedTab: $selectedTab)
                
            }
            .onAppear(perform: {
//                self.viewModel.listenForMyRewardsPrograms(user: "colinjpower1@gmail.com")
//                print("EXECUTED")
//                print(self.viewModel.myRewardsPrograms)
            })
            .onDisappear {
//                if self.viewModel.listener1 != nil {
//                    self.viewModel.listener1.remove()
//                }
//            }.navigationTitle("")
//            .navigationBarHidden(true)
            }
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(selectedTab: .constant(2))
    }
}
