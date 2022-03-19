//
//  CompanyProfile.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/17/22.
//
//

//Use a ZStack to format the background view of this page
//https://levelup.gitconnected.com/background-color-with-swiftui-415fc661b31f
//maybe have a switcher struct in the top of this page to format based on a loyalty tier


import SwiftUI

struct CompanyProfile: View {
    
 
    //@Binding var showingRewardsScreen: Bool
    
    
    //Variables received from HomeView
    var company: String
    var status: String
    
    @Binding var showingDiscountScreen: Bool
    
    //vars for the current state
    @State var progressValue: Float = 0.6
    @State var isDiscountButtonAvailable: Bool = false
    
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    @ObservedObject var viewModel3 = TransactionsViewModel()
    
    
    //Variables for modifying this page
    @State var rewards: Double = 0
    
    
    let discounts: [String] = ["COLIN-GOLD-1", "COLIN-GOLD-2", "COLIN-REFER"]
    let history: [String] = ["T shirt", "Sweatshirt", "Watch"]

    
    // largeTitle, title, headline, body, caption
    // https://developer.apple.com/documentation/swiftui/foreach
    
    var body: some View {
            ScrollView {
                VStack {
                    //MARK: Status
                    RewardsView(progressValue: $progressValue)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(red: 0.82, green: 0.72, blue: 0.58), lineWidth: 2))
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.2)))
                        
                        .padding(.all, 24)
                    
                    
                    //MARK: Section for actually creating rewards discounts
                    VStack {
                        HStack {
                            Text("Convert points to discounts")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Spacer()
                        }.padding(.bottom, 12)
                        VStack {
                            ForEach(viewModel1.oneRewardsProgram) { RewardsProgram in
                                AvailablePointsToConvert(showingDiscountScreen: $showingDiscountScreen, currentPointsForView: RewardsProgram.currentPoints, company: RewardsProgram.company)
                            }

                        }
                    }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    
                    
                    
                    
                    
                    //MARK: Available discount codes
                    VStack {
                        HStack {
                            Text("My discounts")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Spacer()
                        }.padding(.bottom, 12)
                        VStack {
                            ForEach(viewModel2.myDiscountCodes) { discountcode in
                                AvailableDiscountCode(shortDescription: String(discountcode.dollarAmount), discountCode: discountcode.code)
                            }

                        }
                    }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    //MARK: Send a referral code
                    VStack {
                        HStack {
                            Text("Refer a friend")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .padding(.trailing, 2)
                            Text("?")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                                .padding(.all, 6)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.opacity(0.15)))
                            Spacer()
                        }.padding(.bottom, 12)
                        VStack {
                            HStack {
                                Text("$10 off with code")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .frame(minWidth: 150, alignment: .leading)
                                Text("SOIVJSLKJER")
                                    .font(.footnote)
                                    .frame(maxWidth: 100)
                                    .lineLimit(1)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 5)
                                                    .strokeBorder(Color.black.opacity(0.7)))
                                    .padding(.trailing,12)
                                Text("Copy")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.blue))
                                    .onTapGesture(count: 2) {
                                        UIPasteboard.general.string = "SOIVJSLKJER"
                                    }
                            }
                        }
                    }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
                        
//                        //MARK: Sales available for your tier
//                        Divider()
//                        HStack {
//                            Text("DEALS & OFFERS").font(.caption).foregroundColor(.gray).padding(.leading, 12)
//                            Spacer()
//                        }
//                        ScrollView (.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(0...5, id: \.self) { index in
//                                    Rectangle()
//                                        .fill(Color.gray)
//                                        .frame(width: 100, height: 180, alignment: .leading)
//                                }
//                            }
//                        }.frame(height: 200)
                        
                    //MARK: Transaction History
                    VStack {
                        HStack {
                            Text("History")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Spacer()
                        }.padding(.bottom, 12)
                        VStack {
                            ForEach(viewModel3.myTransactions) { transaction in
                                TransactionHistory(item: transaction.item, amount: transaction.price, note: "NONE")
                            }

                        }
                    }.padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    
                    //MARK: My Deals
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(0..<3) { index in
                                Image("AthleisureLA")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 36, alignment: .center)
                                    .clipped()
                                    .cornerRadius(10)
                                    .padding(.trailing, 12)
                                //CircleView(label: "\(index)")
                            }
                        }.padding(.leading, 24)
                    }
                    

                }
            }.navigationBarTitle(company, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center) {
                        Text("")
                        Link(destination: URL(string: "https://hello-vip.myshopify.com")!) {
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
                self.viewModel1.listenForOneRewardsProgram(user: "colinjpower1@gmail.com", company: company)
                self.viewModel2.listenForMyDiscountCodes(user: "colinjpower1@gmail.com", company: company)
                self.viewModel3.listenForMyTransactions(user: "colinjpower1@gmail.com", company: company)
            }
    }
}

//MARK: REWARDS CARD AT THE TOP
//This struct creates the gold/silver rewards card at the top of the page
struct RewardsView: View {
    
    @Binding var progressValue: Float
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center){
                Text("Gold Status")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                Spacer()
                NavigationLink(
                    destination: CompanyRewardsProgramDetails(),
                    label: {
                        Text("See tiers")
                            .font(.footnote)
                            .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                            .padding(.all, 4)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.3)))
                    })
            }.padding(.all, 12)
            ProgressBar(value: $progressValue).frame(height: 12)
                .padding(.horizontal, 12)
                .padding(.top, 12)
            HStack {
                Spacer()
                Text("1000 points to Platinum")
                    .font(.footnote)
                    .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
            }.padding(.trailing, 12)
                .padding(.bottom, 12)

            HStack {
                VStack(alignment: .center) {
                    Text("1500")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                    Text(String("Total points"))
                        .font(.footnote)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("2")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                    Text(String("Referrals"))
                        .font(.footnote)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("4")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                    Text(String("Reviews"))
                        .font(.footnote)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                }
            }.padding(.horizontal, 12)
                .padding(.bottom, 12)
        }
        .padding()
        
        
    }
    
    
}




//MARK: FORMAT POINTS AND DISCOUNT BUTTON
//This struct formats the available points and the "Convert" button
struct AvailablePointsToConvert: View {
    @Binding var showingDiscountScreen: Bool
    var currentPointsForView: Int
    var company: String
    
    var body: some View {
        HStack {
            Text(String(currentPointsForView) + " available")
                .font(.title)
                .foregroundColor(Color.blue)
        Spacer()
        Button(action: {
            showingDiscountScreen = true
        }) {
            Text("Convert points")
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue))
        }.disabled(currentPointsForView==0)
            .sheet(isPresented: $showingDiscountScreen, content: {
                    CreateDiscountScreen(showingDiscountScreen: $showingDiscountScreen, company: company, availablePoints: currentPointsForView)
            })
        }
    }
    
}



//MARK: MY DISCOUNTS
//This struct formats the discount codes that are available
struct AvailableDiscountCode: View {
    var shortDescription: String
    var discountCode: String
    //var description: String
    
    var body: some View {
        HStack {
            if(shortDescription.isEmpty){
                Text("No discounts created yet!")
            } else {
                Text("$" + shortDescription + " off")
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(minWidth: 100, alignment: .leading)
                Spacer()
                Text(discountCode)
                    .font(.footnote)
                    .frame(maxWidth: 100)
                    .lineLimit(1)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(Color.black.opacity(0.7)))
                    .padding(.trailing, 12)
                Text("Copy")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.blue))
                    .onTapGesture(count: 2) {
                        UIPasteboard.general.string = "SOIVJSLKJER"
                    }
            }
        }
    }
}



//MARK: FORMAT TRANSACTIONS
// This struct formats the user's transaction history
struct TransactionHistory: View {
    var item: String
    var amount: Int
    var note: String
    
    var body: some View {
        HStack(alignment: .center){
            Image("AthleisureLA")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36, alignment: .center)
                .clipped()
                .cornerRadius(10)
                .padding(.trailing, 12)
            VStack(alignment: .leading){
                Text(item)
                    .font(.body)
                    .foregroundColor(.black)
                Text("Add a review")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(amount*100))
                    .font(.body)
                    .foregroundColor(.black)
                Text("$" + String(amount))
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.7))
            }
        }
    }
}


//MARK: Progress Bar
struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(red: 0.82, green: 0.72, blue: 0.58))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(red: 0.82, green: 0.72, blue: 0.58))
            }.cornerRadius(45.0)
        }
    }
}





struct CompanyProfile_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfile(company: "TEST COMPANY", status: "Gold", showingDiscountScreen: .constant(false))
    }
}



////MARK: Header
//HStack {
//    Text("Profile").font(.system(size: 30))
//    Spacer()
//    Button(action: {
//        showingRewardsScreen.toggle()
//    }) {
//        Image(systemName: "xmark.circle")
//            .foregroundColor(.black)
//            .font(.system(size: 30))
//    }
//}



    //                        Text("\(rewards, specifier: "%.0f") points for $\(rewards / 10, specifier: "%.0f") dollars")


//
////MARK: Slider
////make the slider collapsible https://www.youtube.com/watch?v=po4lRojJXdA
//VStack {
//    HStack {
//        Slider(
//            value: $rewards,
//            in: 0...currentRewards,
//            step: 50,
//            onEditingChanged: { (_) in
//                // nil here
//            },
//            minimumValueLabel: Text(""),
//            maximumValueLabel: Text(rewards == 0 ? "" : "$\(rewards/10, specifier: "%.0f")"),
//            label: {
//                Text("")
//            })
//            .padding(.trailing, 12)
//        Button(action: {
//            currentRewards = currentRewards - rewards
//            viewModel2.addCode(dollars: Int(rewards), user: "colinjpower1@gmail.com", company: company)
//            rewards = 0
//        }) {
//            Text("Create discount")
//                .font(.body)
//                .foregroundColor(rewards == 0 ? Color.gray : Color.white)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 5).fill(rewards == 0 ? Color.gray.opacity(0.4) : Color.blue))
//        }.disabled(rewards==0)
//    }.padding()
//}.padding(.top, 12)
