//
//  CompanyProfileV2.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/29/22.
//

import SwiftUI


//how to download an image from firebase
//https://www.youtube.com/watch?v=PYpTto3iQXU&t=446s


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
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                //MARK: ZStack Layer 1 - Background
                Color("Background")
                
                //MARK: ZStack Layer 2 - Content
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //MARK: VStack Section (for ScrollView)
                    VStack(alignment: .leading) {
                        
                        
                        
                        //MARK: TOP CARD
                        VStack(alignment: .leading) {
                        
                            //MARK: TOP CARD - CURRENT BALANCE & INFO
                            HStack (alignment: .top) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("My Points Balance")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                    Text(String(viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? -1))
                                        .font(.system(size: 48))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[1])
                                }
                                Spacer()
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("ThemeBright"))
                                    .padding(.top, 4)
                            }.padding(.bottom).padding(.bottom)
                            
                            //MARK: TOP CARD - BUTTONS
                            HStack (alignment: .center, spacing: 20) {
                                
                                //MARK: TOP CARD - BUTTONS - REDEEM
                                
                                Button {
                                    isCreateDiscountScreenActive.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Redeem")
                                            .font(.system(size: 16))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }.padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("ThemeBright")))
                                }.fullScreenCover(isPresented: $isCreateDiscountScreenActive, content: {
                                    CreateDiscountScreen(isCreateDiscountScreenActive: $isCreateDiscountScreenActive, companyID: companyID, companyName: companyName, currentPointsBalance: viewModel1.oneRewardsProgram.first?.currentPointsBalance ?? 0).navigationTitle("").navigationBarHidden(true)
                                })
                        
                                //MARK: TOP CARD - BUTTONS - VISIT
                                Button {
                                    //open website
                                } label: {
                                    HStack {
                                        Spacer()
                                        Link(destination: URL(string: urlToShopifySite)!) {
                                            Text("Open website")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color("Dark1"))
                                        }
                                        Spacer()
                                    }.padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 32).foregroundColor(Color("Background")))
                                }
                            }
                        }.padding()
                            .background(RoundedRectangle(cornerRadius: 24).foregroundColor(.white))
                            .padding()
                        
                        
                        //MARK: DISCOUNT CODES
                        if !viewModel1.oneRewardsProgram.isEmpty {
                            
                            //MARK: DISCOUNT CODES - IF THEY EXIST
                            //see if you need to list a 2+ of them
                            //if viewModel2.myDiscountCodes.count == 1 {
                                //then, you need to represent it as a WidgetFloating
                                ForEach(viewModel2.myDiscountCodes.prefix(1)) { DiscountCode in
                                    
                                    
                                    Button {
                                        showSheet = true
                                    } label: {
                                        DiscountCodeSolo(image: "dollarsign.circle.fill", size: 38, firstLine: "Discount Available", secondLine: "$" + String(DiscountCode.dollarAmount) + " off any item", secondLineColor: Color("ThemeBright"), buttonTitle: "Use", status: DiscountCode.status, code: DiscountCode.code, isActive: $isDiscount1Active)
                                    }.halfSheet(showSheet: $showSheet) {
                                        //my half sheet view
                                        HStack {
                                            Spacer()
                                            VStack {
                                                VStack(alignment: .center, spacing: 4) {
                                                    Text("$" + String(DiscountCode.dollarAmount) + " Discount")
                                                        .font(.system(size: 19))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color("Dark1"))
                                                    Text("You can use this discount on any purchase.")
                                                        .font(.system(size: 17))
                                                        .fontWeight(.regular)
                                                        .foregroundColor(Color("Gray1"))
                                                }.padding(.top, 48)
                                                
                                                Spacer()
                                                Text(DiscountCode.code)
                                                    .font(.system(size: 60))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("ThemePrimary"))
                                                Spacer()

                                                
                                                
                                                Button {
                                                    UIPasteboard.general.string = DiscountCode.code
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
                                                
                                                Button {
                                                    
                                                } label: {
                                                    Text("How do I use this discount code?")
                                                        .font(.system(size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color("ThemePrimary"))
                                                        .padding()
                                                }
                                                
                                                Divider()
                                                Button {
                                                    showSheet = false
                                                } label: {
                                                    Text("Close sheet")
                                                        .font(.system(size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color("Dark1"))
                                                        .padding()
                                                }.padding(.bottom)

                                            }
                                            Spacer()
                                        }
                                        .edgesIgnoringSafeArea(.all)
                                            .background(Color.white)
                                        
                                    } onEnd : {
                                        print("Dismissed")
                                    }
                                }
                                
                            
                        //MARK: DISCOUNT CODES - IF NONE
                        } else {
                            
                            
                        }
                        
                        //MARK: RECOMMENDED ACTIONS (IF ANY)
                        //If empty, show the empty state
                        
                        //Handle empty state
                        if viewModel_Items.myReviewableItemsForCompany.isEmpty {
                            Text("No recommended actions")
                        }
                        //Show the recommended actions
                        else {
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack{
                                    
                                    
                                    ForEach(viewModel_Items.myReviewableItemsForCompany.prefix(3)) { item in
                                        
                                        NavigationLink {
                                            IntentToReview(itemObject: item)
                                        } label: {
                                            PromptCard(image: "Athleisure LA", title: "Write a review", points: 100, itemID: item.itemID)
                                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                                        }
                                    }
                                }.padding(.horizontal)
                                    .padding(.vertical)
                            }
                        }
                        
                        //MARK: Recent Orders
                        VStack(alignment: .leading) {
                            
                            //Header
                            HStack {
                                Text("Recent Orders")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                            }
                            
                            //For each recent order, show an item
                            
                            ForEach(ordersViewModel.snapshotOfOrders.prefix(5)) { Order in
                                
                                NavigationLink(destination: OneOrder(email: email, companyID: companyID, orderID: Order.orderID)) {
                                    MyRecentOrdersItem(item: Order.item_firstItemTitle, timestamp: Order.timestamp, reviewID: Order.orderID, colorToShow: colorToShow[4])
                                }
                            }
                            HStack {
                                Spacer()
                                Button {
                                    isShowingAllOrdersForCompany = true
                                } label: {
                                    Text("See all")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorToShow[4])
                                }.fullScreenCover(isPresented: $isShowingAllOrdersForCompany) {
                                    AllOrdersForCompany(userID: userID, companyID: companyID, isShowingAllOrdersForCompany: $isShowingAllOrdersForCompany)
                                }
                                
                                Spacer()
                            }
                        }.padding()
                            .padding(.vertical)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        

                        
                        //Links + Additional info
                        //MARK: Settings
                        WideWidgetHeader(title: "MORE")
                        VStack {
                            
                            //Item 1: Name
                            
                            NavigationLink(destination: History(userID: userID, companyID: companyID, isHistoryActive: $isHistoryActive)) {
                                WideWidgetItem(image: "clock.fill", size: 20, color: Color("Dark1"), title: "History").padding(.bottom).padding(.bottom)
                            }
                            
                            Button {
                                isHistoryActive.toggle()
                            } label: {
                                WideWidgetItem(image: "clock.fill", size: 20, color: Color("Dark1"), title: "History").padding(.bottom).padding(.bottom)
                            }.fullScreenCover(isPresented: $isHistoryActive) {
                                History(userID: userID, companyID: companyID, isHistoryActive: $isHistoryActive)
                            }
                            
                            
                            //Item 2: Email
                            WideWidgetItem(image: "envelope.fill", size: 20, color: Color("Dark1"), title: "Contact").padding(.bottom).padding(.bottom)
                            
                            //Item 3: Notifications
                            Button {
                                isNotificationsActive.toggle()
                            } label: {
                                WideWidgetItem(image: "bell.fill", size: 20, color: Color("Dark1"), title: "Notifications").padding(.bottom).padding(.bottom)
                            }.fullScreenCover(isPresented: $isNotificationsActive) {
                                Notifications(companyID: companyID, email: email, isNotificationsActive: $isNotificationsActive)
                            }
                            
                            
                            //Item 4: Get help
                            WideWidgetItem(image: "questionmark.circle.fill", size: 20, color: Color("Dark1"), title: "Get help").padding(.bottom)
                            
                            //Item 5: About
                            WideWidgetItem(image: "questionmark.circle.fill", size: 20, color: Color("Dark1"), title: "About").padding(.bottom)
                            
                        }.padding().background(.white).padding(.bottom).padding(.bottom)
                        
                    }.padding(.vertical)
                }
                
            }
                    

        }
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle(viewModel1.oneRewardsProgram.first?.companyName ?? "", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            isReferACompanyActive.toggle()
                        } label: {
                            Text("Get $20")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("ThemeAction"))
                                .padding(.vertical, 6)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("ThemeLight")))
                        }.fullScreenCover(isPresented: $isReferACompanyActive) {
                            ReferAFriend(companyID: companyID, companyName: "alsdkfjsad", isReferCompanyActive: $isReferACompanyActive)
                        }
                        
                        
                        
                    }
                }
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
            
            //isPresenting
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
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
                .medium(),
                .large()
            ]
            
            //to show grabber
            presentationController.prefersGrabberVisible = true
        }
    }
}
