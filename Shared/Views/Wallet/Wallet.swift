//
//  Wallet.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct Wallet: View {
    
    //Variables needed for every base view
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    
    //MARK: Setup properties to be passed to detail view
    @State var currentCard: RewardCard?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    
    
    var body: some View {
        //NavigationView {
        if showDetailCard {
            if let currentCard = currentCard {
                DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation: animation)
            }
        } else {
            VStack(alignment: .center, spacing: 0) {
                    PageHeader(isProfileActive: $isProfileActive, pageTitle: "Wallet")
                        .padding(.bottom)
//                    Text("Wallet")
//                        .font(.largeTitle)
//                        .fontWeight(.semibold)
//                        .padding(.top, 80)
                        //.frame(maxWidth: .infinity, alignment: .center)
                
                    //GeometryReader { proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .center, spacing: 0) {
                            
                                //let cardWidth = proxy.size.width
                            
                                //MARK: CARDS
                                ForEach(cards) { rewardcard1 in
                                    Group {
                                        //RewardCardView(rewardcard: rewardcard1)
                                        Image(rewardcard1.cardImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .matchedGeometryEffect(id: rewardcard1.id, in: animation)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color(.gray), lineWidth: 0.2)
                                            )
                                    }
                                        .onTapGesture {
                                            //cardWidth = proxy.size.width
                                            withAnimation (
                                                .easeInOut(duration: 0.35)) {
                                                    currentCard = rewardcard1
                                                    showDetailCard = true
                                            }
                                            
                                            //print(cardWidth)
                                        }
                                        //.frame(height: 270)
                                        .frame(width: UIScreen.main.bounds.width - 40)
                                        .offset(y: -CGFloat(getIndex(RewardCard: rewardcard1) * 170))
                                }
                            }.coordinateSpace(name: "SCROLL")
                            //.offset(y: 30)
                        }
                //}.padding(.horizontal)
                    
                    MyTabView(selectedTab: $selectedTab)
                
            }.ignoresSafeArea()
        }
//        }
//        .ignoresSafeArea()
//        .navigationTitle("")
//        .navigationBarHidden(true)
    }
    
//    //MARK: Card View
//    @ViewBuilder
//    func RewardCardView(rewardcard: RewardCard)-> some View {
//        GeometryReader { proxy in
//
//            let rect = proxy.frame(in: .named("SCROLL"))
//            //let's display some portion of each card
//            let offset =  -rect.minY + CGFloat(getIndex(RewardCard: rewardcard) * (70))
//
//            ZStack(alignment: .bottom) {
//
//                Image(rewardcard.cardImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//
//                //Card details
//                VStack(alignment: .leading, spacing: 10) {
//
//                    Text(rewardcard.name)
//                    Text(rewardcard.cardNumber)
//                }
//                .padding()
//                .padding(.bottom, 10)
//
//
//            }
//            //Making it as a Stack
//            .offset(y: offset)
//        }
//        //Max size
//        .frame(height: 270)
//
//
//    }
    
    // Retrieving index
    func getIndex(RewardCard: RewardCard)->Int{
        return cards.firstIndex { currentCard in
            return currentCard.id == RewardCard.id
        } ?? 0
    }
    
}

//struct Wallet_Previews: PreviewProvider {
//    static var previews: some View {
//        Wallet(selectedTab: .constant(1))
//    }
//}


//MARK: Detail View

struct DetailView: View {
    
    var currentCard: RewardCard
    @Binding var showDetailCard: Bool
    
    //Matched geometry effect
    var animation: Namespace.ID
    
    @State var isShowingCompanyDetails = false
    @State var isShowingHowDoIUseDiscount = false
    
    @State var isLoadingRecommendedItems = false
    
    
    var recommendationsTEMP = ["OPTION 1", "OPTION 2", "OPTION 3"]
    
    //var cardWidth: CGFloat
    
    var body: some View {
        ZStack {
            Color("Background")
            
            GeometryReader { geometry in
                    VStack {
                        //MARK: HEADER
                        HStack {
                            Button {
                                withAnimation(.easeInOut) {
                                    showDetailCard = false
                                }
                            } label : {
                                Text("Done")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            Button {
                                isShowingCompanyDetails.toggle()
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 23, weight: .medium))
                                    .foregroundColor(.black)
                            }.sheet(isPresented: $isShowingCompanyDetails) {
                                CompanyDetailsModal(isShowingCompanyDetails: $isShowingCompanyDetails)
                            }
                            
                        }.padding(.top, 60).padding(.horizontal)
                        
                        //MARK: CARD
                        Image(currentCard.cardImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: currentCard.id, in: animation)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showDetailCard = false
                                    
                                    print("IN THE DETAIL VIEW PRINTING GEOMETRY")
                                    print(geometry.size.width)
                                    print(geometry.size.height)
                                }
                                
                            }
                            .gesture(DragGesture(minimumDistance: 80, coordinateSpace: .local)
                                .onEnded({ value in
                                    if value.translation.height > 0 {
                                        withAnimation(.easeInOut) {
                                            showDetailCard = false
                                        }
                                    }
                                }))
                            .frame(width: UIScreen.main.bounds.width - 40)
                            //.frame(height: UIScreen.main.bounds.width / 1.6)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .zIndex(10)
                            .padding(.top)
                            .padding(.bottom, 8)
                        
                        //MARK: BUTTONS
                        HStack(spacing: 12) {
                            Button {
                                //copy
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Copy code").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                            }
                            
                            Button {
                                //copy
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Visit website").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.white))
                            }
                            
                        }.padding(.horizontal)
                            .padding(.bottom)
                
                        //MARK: HOW DO I USE THIS DISCOUNT
                        Button {
                            //copy
                        } label: {
                            HStack {
                                Text("How do I use this discount?").font(.system(size: 15, weight: .regular)).padding(.vertical)
                                Spacer()
                            }.padding(.leading)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        }.sheet(isPresented: $isShowingHowDoIUseDiscount) {
                            HowToUseDiscountModal(isShowingHowDoIUseDiscount: $isShowingHowDoIUseDiscount)
                        }.padding(.bottom).padding(.horizontal)
                            
                            
                    
                        //MARK: EXTRA CONTENT
                        if isLoadingRecommendedItems {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                        .scaleEffect(2)
                                    Spacer()
                                }
                                Spacer()
                            }.background(Color("Background"))
                        } else {
                            HStack {
                                Text("Popular this month")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                Spacer()
                            }.padding(.horizontal)
                            .padding(.bottom, 4)
                            
                            
                            
                            TabView {
                                RecommendedItem
                                RecommendedItem
                                RecommendedItem
                                RecommendedItem
                            }//.frame(height: UIScreen.main.bounds.height/2)
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                        }
                    
                                    
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            //DO STUFF HERE
            print("need to hook up to real data")
            startLoadingRecommendedItems()
        }
    }
    
    
    func startLoadingRecommendedItems() {
        isLoadingRecommendedItems = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoadingRecommendedItems = false
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
















//SOURCE: https://www.youtube.com/watch?v=JrLhtCSs6z0

//    @ViewBuilder
//    func CardView()->some View {
//        ZStack(alignment: .bottom) {
//
//            Image(currentCard.cardImage)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//
//            //Card details
//            VStack(alignment: .leading, spacing: 10) {
//
//                Text(currentCard.name)
//                Text(currentCard.cardNumber)
//            }
//            .padding()
//            .padding(.bottom, 10)
//
//
//        }
//    }
