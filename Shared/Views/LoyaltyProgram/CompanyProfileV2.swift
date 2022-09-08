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
enum ActiveLoyaltySheet {
    case redeemPoints, viewAllDiscounts
    var id: Int {
        hashValue
    }
}

struct CompanyProfileV2: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Variables received from HomeView
    var companyID: String
    var companyName: String
    
    //var currentPointsBalance: Int
    var email: String
    var userID: String
    
//    var status: String
    var urlToShopifySite: String = "https://athleisure-la.myshopify.com"
    
    @State private var activeLoyaltySheet: ActiveLoyaltySheet? = nil
    //@State var isFullScreenSheet = true
    
    @State var isCreateDiscountScreenActive: Bool = false
    @State var isRedeemScreenActive: Bool = false
    @State var isDiscount1Active: Bool = false
    @State var isDiscount2Active: Bool = false
    
    
    @State var isProfileShowing:Bool = false
    @State var isHistoryActive:Bool = false
    @State var isNotificationsActive:Bool = false
    
    @State var isReferACompanyActive:Bool = false
    
    @State var isShowingAllOrdersForCompany = false

    
    @State var showSheet:Bool = false
    @State var showSheet2:Bool = false
    @State var showSheetRedeem: Bool = false
    
    @State var isPrompt1Active: Bool = false
    @State var isPrompt2Active: Bool = false
    @State var isPrompt3Active: Bool = false
    @State var isPrompt4Active: Bool = false
    @State var isPrompt5Active: Bool = false
    
    //vars for the current state
    @State var progressValue: Float = 0.6
    @State var isDiscountButtonAvailable: Bool = false
    
    @State var isDiscountCodeCopied:Bool = false
    
    @Binding var selectedTab: Int
    
    
    
    //Listeners - must listen for RewardsProgram, Discounts,
    @ObservedObject var viewModel1 = RewardsProgramViewModel()
    @ObservedObject var viewModel2 = DiscountCodesViewModel()
    @ObservedObject var viewModel3 = TransactionsViewModel()
    //@ObservedObject var ordersViewModel = OrdersViewModel()
    @ObservedObject var viewModel_Items = ItemsViewModel()
    
    @ObservedObject var ordersViewModel = OrdersViewModel()
    
    
    @State private var hasDiscountsCreated = false
    
    var colorToShow: [Color] {
        switch viewModel1.oneRewardsProgram.first?.status {
            case "Gold":
                //Primary Rewards Color, Primary Text on Primary Color, Secondary Text on Primary Color, Button Background, Primary Button Color
                return [Color("Gold1"), Color(.white), Color("Gold2"), Color("Gold2").opacity(0.25), Color("Gold1")]
            case "Silver":
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color("ThemePrimary")]
            default:
                return [Color(.white), Color("Dark1"), Color("Gray1"), Color("Background"), Color("ThemePrimary")]
        }
    }
    
    //Variables for modifying this page
    @State var rewards: Double = 0
        
    

    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            //MARK: CONTENT
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .center) {
                    
                    //MARK: LOYALTY CARD
                    CardForLoyaltyProgram(cardColor: Color("CardTeal"), textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "Personal Card")
                        .frame(alignment: .center)
                        .padding(.bottom)
                    
                    
                    
                    //MARK: QUICK ACTIONS
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading) {
                            
                            //MARK: CURRENT BALANCE -> HISTORY
                            NavigationLink(destination: History(userID: userID, companyID: companyID, isHistoryActive: $isHistoryActive)) {
                                
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
                            }
                            
                            //MARK: ACTIVE DISCOUNTS -> DISCOUNTS HALF SHEET
                            Button {
                                showSheet = true
                                //isFullScreenSheet = false
                                activeLoyaltySheet = .viewAllDiscounts
                            } label: {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("Available Discounts")
                                            .font(.system(size: 15))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.top, 6)
                                        Text(String(viewModel2.myDiscountCodes.count) + " available")
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
                            showSheet = true
                            //isFullScreenSheet = true
                            activeLoyaltySheet = .redeemPoints
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("Redeem Points")
                                            .font(.system(size: 15))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Dark1"))
                                            .padding(.top, 6)
                                            .padding(.bottom, 4)
                                        Text("You have $30 available right now.")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("Gray1"))
                                            .multilineTextAlignment(.leading)
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
//
//                        .fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
//                            CreateDiscountScreen(isCreateDiscountScreenActive: $isCreateDiscountScreenActive, companyID: companyID, companyName: companyName, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0).navigationTitle("").navigationBarHidden(true)
//                        })
                            
                    }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 170)
                    
                    

                    
                    //MARK: Recommended Actions v2 (IF ANY)
                    //Handle empty state
                    if viewModel_Items.myReviewableItemsForCompany.isEmpty {
                        Text("No recommended actions")
                    }
                    //Show the recommended actions
                    else {
                        RecommendedActions(reviewableItems: viewModel_Items.myReviewableItemsForCompany)
                            .padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width, height: 180)
                    }
                    
                    //MARK: Recent Orders
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack {
                            Text("Recent Orders")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }.padding(.horizontal)
                            .padding(.bottom, 4)

                        //For each recent order, show an item
                        VStack(alignment: .center, spacing: 0) {
                            ForEach(ordersViewModel.snapshotOfOrders.prefix(7)) { Order in
                                
                                NavigationLink(destination: Item(itemID: Order.itemIDs.first ?? "")) {
                                    RecentOrdersWidget(item: Order.item_firstItemTitle, timestamp: Order.timestamp, reviewID: Order.orderID, colorToShow: colorToShow[4])
                                    
                                }
                            }
                            Button {
                                isShowingAllOrdersForCompany = true
                            } label: {
                                Text("See All")
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("ThemePrimary"))
                                    .padding(.vertical, 11)
                                    .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                            }.fullScreenCover(isPresented: $isShowingAllOrdersForCompany) {
                                AllOrdersForCompany(userID: userID, companyID: companyID, isShowingAllOrdersForCompany: $isShowingAllOrdersForCompany)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                         
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
                    NavigationLink {
                        AboutCompany()
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 18))
                            .foregroundColor(Color("Dark1"))
                    }
                }
            }
        .halfSheet(showSheet: $showSheet) {
            
            if self.activeLoyaltySheet == .viewAllDiscounts {
            
                //my half sheet view
                HStack {
                    
                    if (viewModel2.myDiscountCodes.isEmpty) {
                        // if no discount codes, show the empty state
                        TabView {
                            
                            
                            CardForLoyaltyProgram(cardColor: Color("Gold1"), textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "0", currentDiscountCode: "NONE AVAILABLE", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "Default Card")
                                .frame(alignment: .center)
                            
                            
    //                                    ZStack {
    //
    //                                        RoundedRectangle(cornerRadius: 16).foregroundColor(.clear)
    //                                            .frame(width: geometry.size.width, height: CGFloat(Int(geometry.size.width) / 8 * 5))
    //
    //                                        Image("AthleisureLA-No-Discount")
    //                                            .resizable()
    //                                            .aspectRatio(contentMode: .fit)
    //                                            .layoutPriority(-2)
    //
    //                                    }.padding(.bottom)
                        }.tabViewStyle(.page(indexDisplayMode: .always))
                            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        
                    } else {
                        TabView {
                            ForEach(viewModel2.myDiscountCodes.prefix(5)) { discountcode in
                                VStack {

                                    //MARK: BUTTONS

                                    CardForLoyaltyProgram(cardColor: Color("Gold1"), textColor: Color.white, companyImage: "Athleisure LA", companyName: "Athleisure LA", currentDiscountAmount: "$20", currentDiscountCode: "COLIN123", userFirstName: "Colin", userLastName: "Power", userCurrentTier: "Gold", discountCardDescription: "Default Card")
                                        .frame(alignment: .center)
                                    
                                    
                                    HStack(spacing: 12) {
                                        Button {
                                            //copy
                                        } label: {
                                            HStack {
                                                Spacer()
                                                Text("Copy code").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                                Spacer()
                                            }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("Background")))
                                        }
                                        
                                        Button {
                                            //copy
                                        } label: {
                                            HStack {
                                                Spacer()
                                                Text("Visit website").font(.system(size: 18, weight: .semibold)).foregroundColor(.black).padding(.vertical)
                                                Spacer()
                                            }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("Background")))
                                        }
                                        
                                    }.padding(.horizontal)
                                    .padding(.bottom)
                                    
                                }
                                
                            }
                        }//.frame(height: UIScreen.main.bounds.height/2)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    
                }
                .edgesIgnoringSafeArea([.all])
                    .background(Color.white)
            } else if self.activeLoyaltySheet == .redeemPoints {
                HStack {
                    Spacer()
                    CreateDiscountScreen(showSheet: $showSheet, companyID: companyID, companyName: companyName, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0)
                    Spacer()
                }
                .edgesIgnoringSafeArea([.all])
                    .background(Color.white)
            }
            
        } onEnd : {
            activeLoyaltySheet = nil
            showSheet = false
            print("Dismissed")
        }
    
        .onAppear {
            self.viewModel1.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel2.listenForMyDiscountCodes(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel3.listenForMyTransactions(email: "colinjpower1@gmail.com", companyID: companyID)
            self.viewModel_Items.listenForMyReviewableItemsForCompany(email: email, companyID: companyID)
            
            //self.ordersViewModel.listenForMyOrders(email: "colinjpower1@gmail.com", companyID: companyID)
            
            self.ordersViewModel.snapshotOfOrders(userID: userID, companyID: companyID)
        }
        .onDisappear {
            if self.viewModel1.listener2 != nil {
                print("REMOVING LISTENER 2")
                self.viewModel1.listener2.remove()
            }
            if self.viewModel2.listener_DiscountCodes != nil {
                print("REMOVING LISTENER_DISCOUNTCODES")
                self.viewModel2.listener_DiscountCodes.remove()
            }
            if self.viewModel3.listener_Transactions != nil {
                print("REMOVING LISTENER_TRANSACTIONS")
                self.viewModel3.listener_Transactions.remove()
            }
            if self.ordersViewModel.listener_MyOrders != nil {
                print("REMOVING LISTENER_ORDERS")
                self.ordersViewModel.listener_MyOrders.remove()
            }
            if self.viewModel_Items.listener_MyReviewableItemsForCompany != nil {
                print("REMOVING LISTENER_ITEMS")
                self.viewModel_Items.listener_MyReviewableItemsForCompany.remove()
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


//// Custom UIHostingController for halfSheet...
//class CustomHostingController2<Content: View>: UIHostingController<Content> {
//    
//    override func viewDidLoad() {
//        
//        view.backgroundColor = .clear
//        
//        //setting presentation controller properties...
//        if let presentationController2 = presentationController as? UISheetPresentationController{
//            
//            presentationController2.detents = [
//                .large()
//            ]
//            
//            //to show grabber
//            presentationController2.prefersGrabberVisible = false
//        }
//    }
//}


