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
    @Binding var showingDiscountScreen: Bool
    
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
                    //MARK: Point balance
                    VStack {
                        //Retrieve current points
                        ForEach(viewModel1.oneRewardsProgram) { RewardsProgram in
                            VStack{
                                Text(String(RewardsProgram.currentPoints)).font(.largeTitle)
                                Text(String("AVAILABLE POINTS"))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                //Show buttons
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        //link to site
                                    }) {
                                        Text("View Store").font(.body)
                                    }
                                    Spacer()
                                    Button(action: {
                                        showingDiscountScreen = true
                                    }) {
                                        Text("Convert Points").font(.body)
                                    }.disabled(RewardsProgram.currentPoints==0)
                                    .sheet(isPresented: $showingDiscountScreen, content: {
                                            CreateDiscountScreen(showingDiscountScreen: $showingDiscountScreen, company: company, availablePoints: RewardsProgram.currentPoints)
                                    })
                                    Spacer()
                                }
                                .padding(.top, 36)
                            }
                        }
                    }.padding(.top, 60)
                    .padding(.bottom, 24)
                    
                    VStack {
                        //MARK: Status Progress
                        Divider()
                        HStack {
                            Text("STATUS").font(.caption).foregroundColor(.gray).padding(.leading, 12)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue)
                            .frame(width: 300, height: 20, alignment: .leading)
                        
                        
                        //MARK: Available discount codes
                        Divider()
                        HStack {
                            Text("ACTIVE CODES").font(.caption).foregroundColor(.gray).padding(.leading, 12)
                            Spacer()
                        }
                        VStack {
                            ForEach(viewModel2.myDiscountCodes) { discountcode in
                                AvailableDiscountCode(shortDescription: "$10", discountCode: discountcode.code)
                            }

                        }.padding(.horizontal)
                        
                        //MARK: Sales available for your tier
                        Divider()
                        HStack {
                            Text("DEALS & OFFERS").font(.caption).foregroundColor(.gray).padding(.leading, 12)
                            Spacer()
                        }
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0...5, id: \.self) { index in
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 180, alignment: .leading)
                                }
                            }
                        }.frame(height: 200)
                        
                        //MARK: Transaction History
//                        Divider()
//                        Text("HISTORY").font(.caption).foregroundColor(.gray).padding(.leading, 12)
//                        VStack {
//                            ForEach(viewModel3.myTransactions) { transaction in
//                                TransactionHistory(item: transaction.item, amount: "$"+String(transaction.price), note: "Discount code COLIN-GOLD applied")
//                            }
//
//                        }.padding(.horizontal)
                        
                        
                    }
                    Spacer()

                }
            }.navigationBarTitle(company, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack {
                        Text("")
                        NavigationLink(
                            destination: CompanyRewardsProgramDetails(),
                            label: {
                                Text("View Tiers")
                            })
                        
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


//MARK: FORMAT DISCOUNT CODES
//This struct formats the discount codes that are available
struct AvailableDiscountCode: View {
    var shortDescription: String
    var discountCode: String
    //var description: String
    
    var body: some View {
        HStack{
            VStack (alignment: .leading, spacing: 4){
                Text(shortDescription).font(.headline)
//                Text(description)
//                    .font(.caption).foregroundColor(Color.gray)
            }
            Spacer()
            HStack {
                Text(discountCode)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                Image(systemName: "doc.on.doc")
                    .font(.body)
                    .foregroundColor(.black)
                Image(systemName: "trash")
                    .font(.body)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

//MARK: FORMAT TRANSACTIONS
// This struct formats the user's transaction history
struct TransactionHistory: View {
    var item: String
    var amount: String
    var note: String
    
    var body: some View {
            HStack{
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                VStack{
                    HStack {
                        Text(item).font(.headline)
                        Spacer()
                        Text(amount).font(.headline)
                    }
                    HStack {
                        Text(note).font(.caption).foregroundColor(Color.gray)
                        Spacer()
                        Text("+500 points").font(.caption).foregroundColor(Color.blue)
                    }
                    Text("Write a review (+100 pts)").font(.caption).foregroundColor(Color.blue)
                    
                }
            }.padding(.horizontal)
            .padding(.bottom, 8)
    }
}





//struct CompanyProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyProfile(company: "TEST COMPANY", showingDiscountScreen: false)
//    }
//}



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
