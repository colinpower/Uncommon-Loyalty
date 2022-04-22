//
//  CompanyProfileV2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/29/22.
//

import SwiftUI

struct CompanyProfileV2: View {
    
    
    //Variables received from HomeView
    var companyID: String
    var companyName: String
    var currentPointsBalance: Int
    var email: String
    var userID: String
//    var status: String
    var urlToShopifySite: String = "https://athleisure-la.myshopify.com"
    
    @State var showingDiscountScreen: Bool = false
    
    //vars for the current state
    @State var progressValue: Float = 0.6
    @State var isDiscountButtonAvailable: Bool = false
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    @ObservedObject var viewModel3 = TransactionsViewModel()
    
    @State private var hasDiscountsCreated = false
    
    var colorToShow: Color {
        switch viewModel1.oneRewardsProgram.first?.status {
            case "Gold":
                return Color(red: 114/255, green: 101/255, blue: 82/255)
            case "Silver":
                return Color.gray
            default:
                return Color.blue
        }
        
    }
    
    
    
    //Variables for modifying this page
    @State var rewards: Double = 0
    
    
    let discounts: [String] = ["COLIN-GOLD-1", "COLIN-GOLD-2", "COLIN-REFER"]
    let history: [String] = ["T shirt", "Sweatshirt", "Watch"]

    
    // largeTitle, title, headline, body, caption
    // https://developer.apple.com/documentation/swiftui/foreach
    
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeader(companyID: companyID, companyName: companyName, email: email, userID: userID)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                VStack {
                    Divider()
                    ProfileRewardsBalance(progressValue: $progressValue, currentPointsBalance: currentPointsBalance, companyName: "Athleisure LA", companyID: companyID, showingDiscountScreen: $showingDiscountScreen)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 12)
                    MyDiscounts(shortDescription: "Use this code at checkout for $10 off any item", discountCode: "COLIN123")
                        .padding(.horizontal, 24)
                        .padding(.bottom, 12)
                    Divider()
                    
                }.background(RoundedRectangle(cornerRadius: 1).fill(.gray.opacity(0.05)))
                ForEach(viewModel3.myTransactions) { myTransaction in
                    MyHistoryItem(type: myTransaction.type, timestamp: myTransaction.timestamp, pointsEarnedOrSpent: myTransaction.pointsEarnedOrSpent)
                }
            }
        }.navigationBarTitle(companyName, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center) {
                        Text("")
                        Link(destination: URL(string: urlToShopifySite)!) {
                            Text("Visit site")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                                .padding(.all, 6)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.15)))
                        }
                    }
                }
            }
        .onAppear {
            self.viewModel1.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel2.listenForMyDiscountCodes(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            print(self.viewModel3.myTransactions)
        }
        
    }
}

//MARK: PROFILE HEADER
//This struct formats the header
struct ProfileHeader: View {
    
    var companyID: String
    var companyName: String
    var email: String
    //var orderID: String // need to get the orderID when in the ReviewsHistory widget
    var userID: String
    
    var body: some View {
        VStack {
            //NAME, MEMBER STATUS, VIDEO
            HStack{
                VStack(alignment: .leading) {
                    Text("Hi Colin!")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    Text("Silver Member")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image("AthleisureSweatshirt")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48, alignment: .center)
                    .clipped()
                    .cornerRadius(48)
            }.padding(.bottom, 18)
            
            //REFERRALS, HISTORY, TIERS
            HStack(alignment: .top) {
                NavigationLink(
                    destination: ReferAFriend(companyID: companyID, companyName: companyName),
                    label: {
                        HStack(alignment: .center) {
                            Image("Rewards")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Refer")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }.padding(.trailing, 18)
                    })
                NavigationLink(
                    destination: ReviewHistory(companyID: companyID, email: email, userID: userID),
                    label: {
                        HStack(alignment: .center) {
                            Image("History")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Review")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                    })
                Spacer()
                NavigationLink(
                    destination: VoteOnProduct(),
                    label: {
                        HStack(alignment: .center) {
                            Image("Diamond")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                                .clipped()
                                .cornerRadius(8)
                            Text("Tiers")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                    })
            }
        }
    }
    
}

//MARK: REWARDS BALANCE
//This struct handles your points, and how you earn... see animations tutorial
//https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions
struct ProfileRewardsBalance: View {
    
    @Binding var progressValue: Float
    @State private var showDetail = false
    
    var currentPointsBalance: Int
    var companyName: String
    var companyID: String
    
    @Binding var showingDiscountScreen: Bool
    
    var body: some View {
        VStack {
            //Point balance and "how you earn"
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(String(currentPointsBalance))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("Point balance")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button {
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    HStack(alignment: .center) {
                        Text("How points work")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.8))
                        Label("Graph", systemImage: "chevron.down")
                            .foregroundColor(.black.opacity(0.8))
                            .labelStyle(.iconOnly)
                            .imageScale(.medium)
                            .rotationEffect(.degrees(showDetail ? -180 : 0))
                    }
                }
            }
            
            if showDetail {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Redeem points for discount codes")
                                .font(.headline)
                            Text("$5 discount for every 500 points")
                                .font(.footnote)
                                .foregroundColor(.black.opacity(0.75))
                        }
                        Spacer()
                    }.padding(.bottom, 12)
                    HStack(alignment: .center) {
                        Text("10")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(minWidth: 50, maxWidth: 50, alignment: .trailing)
                            .padding(.trailing, 12)
                        Text("Points for every $1 you spend")
                            .font(.footnote)
                    }.padding(.bottom, 2)
                    HStack(alignment: .center) {
                        Text("250")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(minWidth: 50, maxWidth: 50, alignment: .trailing)
                            .padding(.trailing, 12)
                        Text("Points for leaving a review")
                            .font(.footnote)
                    }.padding(.bottom, 2)
                    HStack(alignment: .center) {
                        Text("2000")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(minWidth: 50, maxWidth: 50, alignment: .trailing)
                            .padding(.trailing, 12)
                        Text("Points for referring a friend")
                            .font(.footnote)
                    }
                }.padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(.blue.opacity(0.1)))
            }
            
            //Progress bar for rewards
//            GeometryReader { geometry in
//                ZStack(alignment: .leading) {
//                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
//                        .opacity(0.3)
//                        .foregroundColor(.blue)
//
//                    Rectangle().frame(width: min(CGFloat(progressValue)*geometry.size.width, geometry.size.width), height: geometry.size.height)
//                        .foregroundColor(.blue)
//                }.cornerRadius(45.0)
//            }
//            .padding(.top, 12)
            
            
            HStack(alignment: .center) {
                Button(action: {
                    showingDiscountScreen = true
                }) {
                    HStack(alignment: .center) {
                        Text("Convert points")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.blue))
                            .padding(.trailing, 8)
                    }
                    
                }.sheet(isPresented: $showingDiscountScreen, content: {
                    CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: currentPointsBalance, showingDiscountScreen: $showingDiscountScreen)
                })
                
//                NavigationLink(
//                    destination: CreateDiscountScreen(companyID: companyID, companyName: companyName, availablePoints: currentPointsBalance),
//                    label: {
//
//                    })
                
                NavigationLink(
                    destination: VoteOnProduct(),
                    label: {
                        HStack(alignment: .center) {
                            Text("See history")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.black))
                        }
                    })
                Spacer()
            }.padding(.top, 6)
        }
    }
    
}

//MARK: MY DISCOUNTS
//This struct formats the discount codes that are available
struct MyDiscounts: View {
    var shortDescription: String
    var discountCode: String
    
    @State private var buttonText: String = "Copy code"
    @State private var buttonColor: Color = Color.blue
    @State private var isShowing = true
    //var description: String
    
    var body: some View {
        VStack (alignment: .leading) {
            if(shortDescription.isEmpty){
                EmptyView()
            } else {
                VStack {
                    HStack {
                        Image("AthleisureLA")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                        Spacer()
                        Text("$10")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                    Text("COLIN-DISCOUNT-005")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 36)
                        .padding(.top, 12)
                    HStack {
                        Spacer()
                        Text("Active")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(isShowing ? 1 : 0)
                    }.padding(.trailing, 12)
                    .padding(.bottom, 12)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(.cyan.opacity(0.7)))
                
                VStack (alignment: .leading) {
                    Text(shortDescription)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    HStack {
                        Text(buttonText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 16)
                                            .fill(buttonColor))
                            .padding(.trailing, 8)
                            .onTapGesture(count: 1) {
                                //need to switch to DispatchQueue here
                                //https://stackoverflow.com/questions/59682446/how-to-trigger-action-after-x-seconds-in-swiftui
                                buttonText = "Copied"
                                buttonColor = Color.green
                                UIPasteboard.general.string = discountCode
                            }
                        NavigationLink(
                            destination: VoteOnProduct(),
                            label: {
                                HStack(alignment: .center) {
                                    Text("See all")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color.black))
                                }
                            })
                    }
                }.padding(.all, 12)
            }
        }.padding(.top, 24)
        .onAppear(perform: pulsateText)
    }
    
    private func pulsateText() {
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isShowing.toggle()
            }
        }
}

//MARK: MY HISTORY
//This struct formats the discount codes that are available
struct MyHistoryItem: View {
    
    var type: String
    var timestamp: Int
    var pointsEarnedOrSpent: Int
    
    //var description: String
    
    var body: some View {
        HStack {
            Text(type)
            Spacer()
            Text(String(timestamp))
            Spacer()
            Text(String(pointsEarnedOrSpent))
        }
    
    }
}




struct CompanyProfileV2_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileV2(companyID: "zKL7SQ0jRP8351a0NnHM", companyName: "Athleisure LA", currentPointsBalance: 1000, email: "colinjpower1@gmail.com", userID: "temp user ID here")
    }
}


