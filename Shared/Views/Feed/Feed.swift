//
//  Feed.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI

struct Feed: View {
    
    //@State private var showingRewardsScreen: Bool = false
    //@ObservedObject var viewModel = PostInFeedViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("Feed").font(.system(size: 30)).foregroundColor(Color.black.opacity(0.7))
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                }.padding(.horizontal, 12)
                ScrollView {
                    VStack {
                        NavigationLink(destination: SaleForProduct()) {
                            FeedWidget()
                        }
                        NavigationLink(destination: VoteOnProduct()) {
                            FeedWidget()
                        }
//                        ForEach(viewModel.myPostsInFeed) { PostInFeed in
//
//                            NavigationLink(destination: SaleForProduct(company: PostInFeed.company)) {
//                                FeedWidget(company: RewardsProgram.company, points: RewardsProgram.currentPoints)
//                            }
//                        }
                    }
                }
                
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
            }.navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
