//
//  CompanyProfileV2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/29/22.
//

import SwiftUI

//how to download an image from firebase
//https://www.youtube.com/watch?v=PYpTto3iQXU&t=446s


//Necessary hack to show multiple sheets on one page
enum ActiveLoyaltySheet: String, Identifiable {
    case setupCard, viewCards, redeemPoints
    var id: String {
        return self.rawValue
    }
}

struct HistoryObject: Identifiable {
    
    var id = UUID().uuidString
    
    var timestamp: Int
    var type: String
    var discountObject: DiscountCodes
    var referralObject: Referrals
}


struct CompanyProfileV2: View {
    
    //MARK: SET UP VARIABLES
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Listeners - must listen for RewardsProgram, Discounts,
    @ObservedObject var discountCodesViewModel = DiscountCodesViewModel()
    @ObservedObject var ordersViewModel = OrdersViewModel()
    @ObservedObject var referralsViewModel = ReferralsViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()
    
    //Variables received from HomeView
    @Binding var selectedTab: Int
    
    @State var rewardsProgram: RewardsProgram
    
    
    
    //Variables for creating this page
    @State private var activeLoyaltySheet: ActiveLoyaltySheet? = nil
    
    @State var showSheet:Bool = false
    
    var emptyReferralObject = Referrals(card: ReferralsCardStruct(color: 0, companyName: "", customMessage: "", discountCode: "", discountCodeCaseInsensitive: "", itemImage: "", itemTitle: ""), ids: ReferralsIDsStruct(companyID: "", domain: "", graphQLID: "", handle: "", itemID: "", referralID: "", reviewID: "", usedOnOrderID: "", userID: ""), offer: ReferralsOfferStruct(expirationTimestamp: 0, forNewCustomersOnly: false, minimumSpendRequired: 0, rewardAmount: 0, rewardType: "", usageLimit: 0), recipient: ReferralsRecipientStruct(firstName: "", lastName: "", phone: "", email: ""), reward: ReferralsRewardStruct(rewardAmount: 0, rewardType: ""), sender: ReferralsSenderStruct(firstName: "", lastName: "", phone: "", email: ""), status: ReferralsStatusStruct(status: "", timestampCreated: 0, timestampUsed: 0, timestampComplete: 0, timeWaitingForReturnInDays: 0))
    
    var emptyDiscountObject = DiscountCodes(card: DiscountsCardStruct(cardType: "", color: 0, companyName: "", customMessage: "", discountCode: "", discountCodeCaseInsensitive: ""), ids: DiscountsIDsStruct(companyID: "", discountID: "", domain: "", graphQLID: "", usedOnOrderID: "", userID: ""), owner: DiscountsOwnerStruct(firstName: "", lastName: "", phone: "", email: ""), reward: DiscountsRewardStruct(expirationTimestamp: 0, minimumSpendRequired: 0, rewardAmount: 0, rewardType: "", usageLimit: 0, pointsSpent: 0), status: DiscountsStatusStruct(status: "", failedToBeCreated: false, timestampCreated: 0, timestampUsed: 0))
    
    
    @State var selectedDiscount:DiscountCodes = DiscountCodes(card: DiscountsCardStruct(cardType: "", color: 0, companyName: "", customMessage: "", discountCode: "", discountCodeCaseInsensitive: ""), ids: DiscountsIDsStruct(companyID: "", discountID: "", domain: "", graphQLID: "", usedOnOrderID: "", userID: ""), owner: DiscountsOwnerStruct(firstName: "", lastName: "", phone: "", email: ""), reward: DiscountsRewardStruct(expirationTimestamp: 0, minimumSpendRequired: 0, rewardAmount: 0, rewardType: "", usageLimit: 0, pointsSpent: 0), status: DiscountsStatusStruct(status: "", failedToBeCreated: false, timestampCreated: 0, timestampUsed: 0))


    //@State var selectedDiscountCode: DiscountCodes
    
    @State var copyCodeText:String = "Copy code"
    
    @State var discountIndex:Int = 0
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: MAIN CONTENT (before tabs)
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack(alignment: .center, spacing: 0) {
                    
                    //MARK: LOYALTY CARD NOT SET UP
                    if (rewardsProgramViewModel.oneRewardsProgram.first?.ids.personalCardDiscountID ?? rewardsProgram.ids.personalCardDiscountID) == "" {
                        //show a blank card that needs to be set up
                        
                        Button {
                            
                            activeLoyaltySheet = .setupCard
                            
                        } label: {
                            
                            CardForLoyaltyProgram(cardColor: Color.white, textColor: Color.white, companyImage: "AthleisureLA-Icon-White", companyName: rewardsProgram.card.companyName, currentDiscountAmount: "$0", currentDiscountCode: "Tap to set up", userFirstName: rewardsProgram.owner.firstName, userLastName: rewardsProgram.owner.lastName, userCurrentTier: "", discountCardDescription: "SET UP PERSONAL CARD")
                                .frame(alignment: .center)
                                .padding(.bottom)
                                .padding(.bottom)
                        }
                    }
                    
                    //MARK: NO REWARDS CARDS FOUND
                    else if discountCodesViewModel.myActiveDiscountCodes.isEmpty {
                        //error.. this should never happen!
                    
                    }
                    
                    //MARK: 1 REWARDS CARD
                    else if discountCodesViewModel.myActiveDiscountCodes.count == 1 {
                        //only 1 code available.. don't show a tabview.. just show the 1 card
                        
                        let oneDiscount:DiscountCodes = discountCodesViewModel.myActiveDiscountCodes.first ?? emptyDiscountObject
                        let oneCode = oneDiscount.card.discountCode
                        let oneLink = "https://" + oneDiscount.ids.domain + "/discount/" + oneCode
                        
                        //Height = screenwidth / 1.6 + 18
                        Button {
                            
                            self.activeLoyaltySheet = .viewCards
                            
                        } label: {
                            
                            CardForLoyaltyProgram(cardColor: cardColorOptions[oneDiscount.card.color][0] as! Color, textColor: Color.white, companyImage: oneDiscount.card.companyName, companyName: oneDiscount.card.companyName, currentDiscountAmount: "$" + String(oneDiscount.reward.rewardAmount), currentDiscountCode: oneDiscount.card.discountCode, userFirstName: oneDiscount.owner.firstName, userLastName: oneDiscount.owner.lastName, userCurrentTier: "", discountCardDescription: "Default Card")
                                .frame(alignment: .center)
                                .padding(.vertical, 5)
                                .padding(.bottom)
                            
                        }
                        //Height = 54 + bottom padding
                        
                        if oneDiscount.reward.rewardAmount == 0 {
                            
                            Button {
                                
                                self.activeLoyaltySheet = .redeemPoints
                                
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Add value to this card by redeeming rewards")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(Color("Dark1"))
                                        .padding(.vertical)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color.white))
                                    .padding(.horizontal)
                                    .frame(width: UIScreen.main.bounds.width)
                                    .padding(.bottom)
                                    .padding(.bottom)
                            }
                            
                        } else {
                            
                            Link(destination: URL(string: oneLink)!) {
                                
                                HStack {
                                    Spacer()
                                    
                                    HStack (alignment: .center, spacing: 6) {
                                        Text("Shop using this code")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ThemeAction"))
                                            .padding(.vertical)
                                        Image(systemName: "arrow.up.right")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ThemeAction"))
                                            .padding(.vertical)
                                    }
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color.white))
                                    .padding(.horizontal)
                                    .frame(width: UIScreen.main.bounds.width)
                            }
                            .padding(.bottom)
                            .padding(.bottom)
                        }

                    //MARK: MULTIPLE REWARDS CARDS
                    } else {
                        
                        DiscountCardsHorizontalTabView(activeDiscountCodes: discountCodesViewModel.myActiveDiscountCodes, activeLoyaltySheet: $activeLoyaltySheet)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6 + 130, alignment: .top)
                            .padding(.bottom)
                    
                    }
                            
                    
                    //MARK: QUICK ACTIONS
                    HStack(alignment: .top, spacing: 8) {
                        
                        VStack(alignment: .leading) {
                            
                            //MARK: CURRENT BALANCE -> HISTORY
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Points Balance")
                                        .font(.system(size: 15))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Dark1"))
                                        .padding(.top, 6)
                                    Text("3000")
                                        .font(.system(size: 32, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("Dark1"))
                                        .padding(.vertical, 3)
                                    Text("820 Pending")
                                        .font(.system(size: 15))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Gray1"))
                                        .padding(.bottom, 6)
                                }.padding(.leading, 16)
                                Spacer()
                            }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                
                            //MARK: ACTIVE DISCOUNTS -> DISCOUNTS HALF SHEET
                            Button {
                                //showSheet = true
                                //isFullScreenSheet = false
                                //activeLoyaltySheet = .viewAllDiscounts
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("Available Discounts")
                                            .font(.system(size: 15))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.top, 6)
                                        Text(String(discountCodesViewModel.myActiveDiscountCodes.count) + " available")
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.vertical, 10)
                                    }.padding(.leading, 16)
                                    Spacer()
                                }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                            }
                            
                        }
                        
                        //MARK: REDEEM -> REDEEM FULL SCREEN
                        Button {
                            
                            //isFullScreenSheet = true
                            self.activeLoyaltySheet = .redeemPoints
                            
                            
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        
                                        let currentPointsBalanceVar = rewardsProgram.status.currentPointsBalance
                                        
                                        Text("Points Balance")
                                            .font(.system(size: 15))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.top, 6)
                                            .padding(.bottom, 4)
                                        Text(String(currentPointsBalanceVar))
                                            .font(.system(size: 36, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.vertical, 3)
                                        
                                    }.padding(.leading, 16)
                                    Spacer()
                                }
                                Spacer()
                                    
                                HStack {
                                    Spacer()
                                    Text("Redeem")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 12)
                                    Spacer()
                                }.background(
                                    Capsule()
                                        .strokeBorder(Color.black,lineWidth: 0.3)
                                        .background(Color("ThemePrimary"))
                                        .clipped()
                                )
                                .clipShape(Capsule())
                                .padding()
                                
                            }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))

                        }
                            
                    }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 170)
                    

                    //MARK: Recent Orders
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack {
                            Text("History")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }.padding(.horizontal)
                            .padding(.bottom, 4)
                        
                        
                        //MARK: HISTORY SECTION
                        //note: need to create the right queries so that I am not grabbing all the data.. just the relevant "USED" discount codes and referrals... i guess grab all the orders and reviews though
                        
                        VStack {
                            
                            let array1:[HistoryObject] = discountCodesViewModel.myActiveDiscountCodes.prefix(2).map { HistoryObject(timestamp: $0.status.timestampCreated, type: "DISCOUNT", discountObject: $0.self, referralObject: emptyReferralObject) }    //{["DISCOUNT", $0.discountID, String($0.timestamp_Created)]}
                            
                            let array2:[HistoryObject] = referralsViewModel.snapshotOfAllReferrals.prefix(2).map { HistoryObject(timestamp: $0.status.timestampCreated, type: "REFERRAL", discountObject: emptyDiscountObject, referralObject: $0.self) }    //{["DISCOUNT", $0.discountID, String($0.timestamp_Created)]}
                            
                            var testArray:[HistoryObject] = array1 + array2
                            
                            ForEach(testArray) { item in
                                
                                HStack {
                                    Text(item.type)
                                    Text(String(item.timestamp))
                                }

                            }
                            
                            Divider()
                            
                            
    //                        testArray = array1 + array2
                            
                            let sortedArray:[HistoryObject] = testArray.sorted(by: { $0.timestamp < $1.timestamp })
                            
                            ForEach(sortedArray) { item in
                                
                                HStack {
                                    Text(item.type)
                                    Text(String(item.timestamp))
                                }

                            }
                     
                        }
                    }.padding(.horizontal)
                        .padding(.bottom)
                }
            }
            
            //MARK: TABS
            MyTabView(selectedTab: $selectedTab)
    
        }
        .background(Color("Background"))
        .edgesIgnoringSafeArea([.bottom, .horizontal])
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack {
                        
                        NavigationLink {
                            AboutCompany()
                        } label: {
                            Image(systemName: "chart.bar")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                        }
                        
                        NavigationLink {
                            AboutCompany()
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                        }
                    }
                }
            }
            .sheet(item: $activeLoyaltySheet, onDismiss: { activeLoyaltySheet = nil }) { sheet in

                switch sheet {
                case .redeemPoints:
                    CreateDiscountScreen(rewardsProgram: rewardsProgramViewModel.oneRewardsProgram.first ?? rewardsProgram, activeLoyaltySheet: $activeLoyaltySheet)
                case .viewCards:
                    DiscountCardsDetailView(activeDiscountCodes: discountCodesViewModel.myActiveDiscountCodes)
                case .setupCard:
                    DiscountCardSetup1(rewardsProgram: rewardsProgram, activeLoyaltySheet: $activeLoyaltySheet)
                }
            }
        
        
        
        
//        .halfSheet(showSheet: $showSheet) {
//
//            //MARK: DISCOUNT CARDS IN HALF SHEET
//            if self.activeLoyaltySheet == .viewCard {
//
//                HStack {
//
//                        TabView {
//                            ForEach(discountCodesViewModel.myActiveDiscountCodes.prefix(5)) { discountcode in
//                                VStack {
//
//                                    //MARK: BUTTONS
//
//                                    CardForLoyaltyProgram(cardColor: Color("Gold1"), textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "Default Card")
//                                        .frame(alignment: .center)
//
//
//                                    HStack(spacing: 12) {
//                                        Button {
//                                            //copy
//                                        } label: {
//                                            HStack {
//                                                Spacer()
//                                                Text("Copy code").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
//                                                Spacer()
//                                            }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("Background")))
//                                        }
//
//                                        Button {
//                                            //copy
//                                        } label: {
//                                            HStack {
//                                                Spacer()
//                                                Text("Visit website").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
//                                                Spacer()
//                                            }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("Background")))
//                                        }
//
//                                    }.padding(.horizontal)
//                                    .padding(.bottom)
//
//                                }
//
//                            }
//                        }//.frame(height: UIScreen.main.bounds.height/2)
//                        .tabViewStyle(.page(indexDisplayMode: .always))
//                        .indexViewStyle(.page(backgroundDisplayMode: .always))
//
//                }
//                .edgesIgnoringSafeArea([.all])
//                .background(RoundedRectangle(cornerRadius: 32).fill(Color.white))
//            }
//
//            //MARK: REDEEM IN HALF SHEET
//            else if self.activeLoyaltySheet == .redeemPoints {
//                HStack(alignment: .bottom) {
//                    Spacer()
//                    CreateDiscountScreen(showSheet: $showSheet, rewardsProgram: rewardsProgramViewModel.oneRewardsProgram.first ?? rewardsProgram)
//                    Spacer()
//                }
//                .edgesIgnoringSafeArea([.all])
//                .background(RoundedRectangle(cornerRadius: 32).fill(.white))
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
//            }
//
//        } onEnd : {
//            activeLoyaltySheet = nil
//            showSheet = false
//            print("Dismissed the half sheet")
//        }
        .onAppear {
            
            //listeners
            self.discountCodesViewModel.listenForMyActiveDiscountCodes(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID)
            self.rewardsProgramViewModel.listenForOneRewardsProgram(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID)
            
            //snapshots
            self.ordersViewModel.snapshotOfOrders(userID: rewardsProgram.ids.userID, companyID: rewardsProgram.ids.companyID)
            self.referralsViewModel.getSnapshotOfAllReferrals(userID: rewardsProgram.ids.userID)
            
            //set rewardsProgram based on the listener
            self.rewardsProgram = rewardsProgramViewModel.oneRewardsProgram.first ?? self.rewardsProgram
            
//            self.selectedDiscountCode = emptyDiscountObject
            
        }
        .onDisappear {
            
            //remove listeners
            if self.discountCodesViewModel.listener_MyActiveDiscountCodes != nil {
                print("Removing listener_MyActiveDiscountCodes")
                self.discountCodesViewModel.listener_MyActiveDiscountCodes.remove()
            }
            
            if self.rewardsProgramViewModel.listener_OneRewardsProgram != nil {
                print("Removing listener_OneRewardsProgram")
                self.rewardsProgramViewModel.listener_OneRewardsProgram.remove()
            }
            
        }
    }
}






struct TemporaryCardViewFromBottom: View {
    
    var body: some View {
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
                
                Button {
                    UIPasteboard.general.string = "lasdkjfa" //DiscountCode.code
                } label: {
                    HStack {
                        Spacer()
                        Text("Copy code")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.white))
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeAction")))
                    .padding(.horizontal)
                    .padding(.horizontal)
                }
                
            }
                
                
            Spacer()
        }.background(.white)
        
        
        
        
    }
    
    
    
}

struct DiscountCodeSolo: View {
    
    var image: String
    var size: Int? = 48
    var firstLine: String
    var secondLine: String
    var secondLineColor: Color? = Color("Gray2")
    var buttonTitle: String? = ""
    var status: String
    var code: String
    
    @Binding var isActive: Bool
    
    
    var body: some View {
            HStack {
                Image("Athleisure LA")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48, alignment: .center)
                    .clipped()
                    .cornerRadius(24)
                    .padding(.trailing, 6)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Discount Created")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Dark1"))
                    Text(secondLine)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ThemePrimary"))
                }
                Spacer()
                Text("Use")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 16)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("ThemePrimary")))
            }.padding(.horizontal)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
            .padding(.horizontal)
    }
}

struct DiscountCodeSolo1: View {
    
    var image: String
    var size: Int? = 48
    var firstLine: String
    var secondLine: String
    var secondLineColor: Color? = Color("Gray2")
    var buttonTitle: String? = ""
    var status: String
    var code: String
    
    @Binding var isActive: Bool
    
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            HStack {
                Image(systemName: image)
                    .foregroundColor(Color("ThemePrimary"))
                    .font(.system(size: CGFloat(size!)))
                VStack(alignment: .leading, spacing: 3) {
                    Text(firstLine + " " + status)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(secondLine + " " + code)
                        .font(secondLineColor! == Color("Gray2") ? .system(size: 16) : .system(size: 14))
                        .fontWeight(secondLineColor! == Color("Gray2") ? .regular : .semibold)
                        .foregroundColor(secondLineColor)
                }
                Spacer()
                if !buttonTitle!.isEmpty {
                    Text(buttonTitle!)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))

                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Gray2"))
                        .font(Font.system(size: 15, weight: .semibold))
                }
            }.padding(.horizontal, 12)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        }
        .padding(.horizontal)
    }
}



//MARK: HALF SHEET
//for creating the half sheet https://www.youtube.com/watch?v=rQKT7tn4uag
extension View {
    
    //Binding show variable
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView, onEnd: @escaping ()->())-> some View {
        
        //use .overlay because it will automatically use hte swiftui frame size only
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet, onEnd: onEnd)
            )
    }
    
    
}

//UI KIt integration
struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    @Binding var showSheet:Bool
    //var isFullScreenSheet:Bool
    
    var onEnd: () -> ()
    
    
    let controller = UIViewController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        if showSheet {
            
            //if isFullScreenSheet {
                //isPresenting
//                let sheetController = CustomHostingController2(rootView: sheetView)
//                sheetController.presentationController?.delegate = context.coordinator
//                uiViewController.present(sheetController, animated: true)
            //} else {
                //isPresenting
                let sheetController = CustomHostingController(rootView: sheetView)
                sheetController.presentationController?.delegate = context.coordinator
                uiViewController.present(sheetController, animated: true)
            //}
            
        }
        else {
            // closing view when showSheet toggled again...
            uiViewController.dismiss(animated: true)
        }
    }
    
    //on Dismiss
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
    
}

// Custom UIHostingController for halfSheet...
class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        
        //setting presentation controller properties...
        if let presentationController = presentationController as? UISheetPresentationController{
            
            presentationController.detents = [
                .medium() //,
                //.large()
            ]
            
            //to show grabber
            presentationController.prefersGrabberVisible = true
        }
    }
}

