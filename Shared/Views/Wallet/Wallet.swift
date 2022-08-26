//
//  Wallet.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct Wallet: View {
    
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    //MARK: Animation properties
    @State var expandCards: Bool = false
    
    //MARK: Detail View Properties
    @State var currentCard: RewardCard?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    
    var body: some View {
        
        if showDetailCard {
            if let currentCard = currentCard {
                DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation: animation)
            }
        } else {
        VStack(alignment: .center, spacing: 0) {
                //PageHeader(isProfileActive: $isProfileActive, pageTitle: "Wallet")
                Text("Wallet")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
                    .overlay(alignment: .trailing) {
                        
                        //MARK: close button
                        Button {
                            //Closing cards
                            withAnimation(
                                .interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                                    expandCards = false
                                }
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue, in: Circle())
                        }
                        .rotationEffect(.init(degrees: expandCards ? 40 : 0))
                        .offset(x: expandCards ? 10 : 15)
                        .opacity(expandCards ? 1 : 0)
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 15)
            
            
            
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        
                        //MARK: CARDS
                        ForEach(cards) { rewardcard in
                            Group {
                                //If you don't want this here.. you can just remove the if.. else...
                                if currentCard?.id == rewardcard.id && showDetailCard {
                                    RewardCardView(rewardcard: rewardcard)
                                        .opacity(0)
                                } else {
                                    RewardCardView(rewardcard: rewardcard)
                                        .matchedGeometryEffect(id: rewardcard.id, in: animation)
                                }
                                    
                            }
                            .onTapGesture {
                                withAnimation (
                                    .easeInOut(duration: 0.35)) {
                                        currentCard = rewardcard
                                        showDetailCard = true
                                }
                            }
                        }
                    }
                    .overlay {
                        //To avoid scrolling
                        Rectangle()
                            .fill(.black.opacity(expandCards ? 0 : 0.01))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    expandCards = true
                                }
                            }
                    }
                    .padding(.top, expandCards ? 30 : 0)
                }.coordinateSpace(name: "SCROLL")
                .offset(y: expandCards ? 0 : 30)
                
                
                //MyTabView(selectedTab: $selectedTab)
            
            
            
        }
        .padding(.horizontal)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea()
        }
//        .overlay {
//            if let currentCard = currentCard {
//                DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation: animation)
//            }
//        }
        
        
    }
    
    //MARK: Card View
    @ViewBuilder
    func RewardCardView(rewardcard: RewardCard)-> some View {
        GeometryReader { proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            //let's display some portion of each card
            let offset = CGFloat(getIndex(RewardCard: rewardcard) * (expandCards ? 10 : 70))
            
            ZStack(alignment: .bottom) {
                
                Image(rewardcard.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                //Card details
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(rewardcard.name)
                    Text(rewardcard.cardNumber)
                }
                .padding()
                .padding(.bottom, 10)
                
                
            }
            //Making it as a Stack
            .offset(y: expandCards ? offset : -rect.minY + offset)
        }
        //Max size
        .frame(height: 270)
        
        
    }
    
    // Retrieving index
    func getIndex(RewardCard: RewardCard)->Int{
        return cards.firstIndex { currentCard in
            return currentCard.id == RewardCard.id
        } ?? 0
    }
    
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet(selectedTab: .constant(1))
    }
}


//MARK: Deatil View

struct DetailView: View {
    
    var currentCard: RewardCard
    @Binding var showDetailCard: Bool
    
    //Matched geometry effect
    var animation: Namespace.ID
    
    //Delaying expenses view
    @State var showExpenseView:Bool = false
    
    var body: some View {
        
        VStack {
            CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 270)
                .onTapGesture {
                    //closing expenses view first
                    withAnimation(.easeInOut) {
                        showExpenseView = false
                    }
                    //Then wait 200ms, then close the card
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showDetailCard = false
                        }
                    }
                    
                }
                .zIndex(10)
            
            GeometryReader { proxy in
                
                let height = proxy.size.height + 50
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        Text("Expense 1").padding(.vertical, 25)
                        Text("Expense 2").padding(.vertical, 25)
                        Text("Expense 3").padding(.vertical, 25)
                    }.padding()
                    
                }.frame(maxWidth: .infinity)
                    .background(Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .ignoresSafeArea()
                    )
                    .offset(y: showExpenseView ? 0 : height)
                
            }.padding([.horizontal, .top])
                .zIndex(-10)
            
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            //.background(Color("Background").ignoresSafeArea())
            .onAppear {
                withAnimation(.easeInOut.delay(0.1)){
                    showExpenseView = true
                }
            }
        //.ignoresSafeArea()
    }
    
    @ViewBuilder
    func CardView()->some View {
        ZStack(alignment: .bottom) {
            
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            //Card details
            VStack(alignment: .leading, spacing: 10) {
                
                Text(currentCard.name)
                Text(currentCard.cardNumber)
            }
            .padding()
            .padding(.bottom, 10)
            
            
        }
    }
}
