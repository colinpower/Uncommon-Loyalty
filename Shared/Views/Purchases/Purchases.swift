//
//  YourBag.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI


struct Purchases: View {
    
    //Required for any tab
    @ObservedObject var viewModel = AppViewModel()
    @Binding var selectedTab:Int
    
    @State var isProfileActive:Bool = false
    
    //Data for this view
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    //Variables for this view
    @State var isShowingTempTabView = false
    
    
    @State var isShowingContactsList:Bool = false
    
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 0, alignment: nil),
        GridItem(.fixed(UIScreen.main.bounds.width / 2), spacing: 0, alignment: nil)
    ]
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                //MARK: CONTENT
                ScrollView {
                    
                    VStack(alignment: .center, spacing: 0) {
                        
                        
                        
                        
                        //MARK: MOST POPULAR REFERRALS
                        VStack(alignment: .leading) {
                            
                            //header
                            Text("Where you're most influential")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            
                            //divider
                            Divider().padding(.leading)
                            
                            
                            //content
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 20) {

                                    if itemsViewModel.snapshotOfItemsWithMultipleReferrals.isEmpty {
                                     
                                        ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 11)
                                                .stroke(Color("Background"), lineWidth: 1) //.blur(radius: 2)
                                                .shadow(color: Color.white, radius: 3, x: -4, y: -4)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .clipped()
                                            
                                            Text("You haven't referred any friends yet")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color("Gray2"))
                                                .multilineTextAlignment(.center)
                                                .padding().padding(.horizontal)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 11)
                                                        .stroke(Color("Background"), lineWidth: 3) //.blur(radius: 2)
                                                        .shadow(color: Color("Gray2"), radius: 3, x: 3, y: 3)
                                                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                        .clipped()
                                                )
                                            
                                        }.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                            .clipShape(RoundedRectangle(cornerRadius: 11))
                                        
                                        
                                    } else {
                                        
                                        ForEach(itemsViewModel.snapshotOfItemsWithMultipleReferrals.prefix(10)) { item in
                                            
                                            TopReferralsWidget(item: item)
                                                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                                                .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                            
                                        }
                                    }
                                }.offset(x: 20)
                                .padding(.vertical)
                                .padding(.vertical)
                                .padding(.trailing, 40)
                            }
                            
                        }.padding(.top).padding(.top)
                        
                        
                        //MARK: MORE PRODUCTS YOU BELIEVE IN (5 STAR REVIEWS -> READY FOR REFERRAL)
                        VStack(alignment: .leading) {
                            
                            //header
                            Text("Favorites you haven't referred")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            
                            //divider
                            Divider().padding(.leading)
                            
                            //content
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 20) {
                                    
                                    if itemsViewModel.snapshotOfItemsWith5StarsAndNoReferrals.isEmpty {
                                     
                                        ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 11)
                                                .stroke(Color("Background"), lineWidth: 1) //.blur(radius: 2)
                                                .shadow(color: Color.white, radius: 3, x: -4, y: -4)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .clipped()
                                                
                                            
                                            Text("You haven't written any reviews yet")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color("Gray2"))
                                                .multilineTextAlignment(.center)
                                                .padding().padding(.horizontal)
                                                .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 11)
                                                        .stroke(Color("Background"), lineWidth: 3) //.blur(radius: 2)
                                                        .shadow(color: Color("Gray2"), radius: 3, x: 3, y: 3)
                                                        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                                        .clipped()
                                                )
                                            
                                        }.frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width / 4)
                                            .clipShape(RoundedRectangle(cornerRadius: 11))
                                        
                                        
                                    } else {
                                                                                    
                                        ForEach(itemsViewModel.snapshotOfItemsWith5StarsAndNoReferrals.prefix(10)) { item in
                                            
                                            FiveStarReviewsWidget(item: item)
                                                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 + 32, alignment: .top)
                                                .background(RoundedRectangle(cornerRadius: 11).foregroundColor(.white).shadow(radius: CGFloat(11)))
                                            
                                        }

                                    }

                                    
                                }.offset(x: 20)
                                .padding(.vertical)
                                .padding(.vertical)
                                .padding(.trailing, 40)
                            }
                            
                        }.padding(.top).padding(.top)
                        
                        
                        //MARK: YOUR RECENT PURCHASES
                        VStack(alignment: .leading) {
                            
                            //header
                            HStack(alignment: .center, spacing: 0) {
                                Text("All of your purchases")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding(.leading)
                                    .padding(.bottom, 5)
                                
                                Spacer()
                                
                                Button {
                                    //create a fake order
                                    
                                    itemsViewModel.createFakeItemForDemo(email: viewModel.email!, userID: viewModel.userID!)
                                    
                                } label: {
                                    
                                    Text("Create a fake order")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("ReferPurple"))
                                        .padding(.trailing)
                                }
                                
                            }
                            
                            
                            //content
                            LazyVGrid(columns: columns, spacing: 0) {
                                
                                ForEach(itemsViewModel.snapshotOfItems.prefix(10)) { item in
                                    
                                    LazyVGridWidget(item: item)
                                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 + 32)
                                        .background(.white)
                                        .clipShape(Rectangle())
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color("Gray3"), lineWidth: 0.5)
                                        )
                                    
                                }
                                
                            }
                            
                        }.padding(.top).padding(.top)
                        
                        
                        
                        
//
//                        //MARK: REFERRALS SECTION - TITLE AND DESCRIPTION
//                        VStack(alignment: .leading, spacing: 8) {
//                            //Title
//                            HStack(alignment: .center) {
//                                Image(systemName: "paperplane.fill")
//                                    .font(.system(size: 28, weight: .semibold))
//                                    .foregroundColor(Color("ReferPurple"))
//                                Text("Refer")
//                                    .font(.system(size: 28))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color("Dark1"))
//                                Spacer()
////                                Text("See All")
////                                    .font(.system(size: 16))
////                                    .fontWeight(.regular)
////                                    .foregroundColor(.blue)
//                            }.padding(.vertical)
//                        }
//                        .padding(.horizontal)
//
//                        //MARK: REFERRALS SECTION - CONTENT
//                        VStack(alignment: .center, spacing: 24) {
//
//                            ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(3)) { item in
//
//                                LargeItemReferWidget(item: item, selectedTab: $selectedTab)
//
//                            }
//
//                        }.padding(.vertical)
//
//                        Divider().padding(.vertical).padding(.top).padding(.leading)
//
//                        //MARK: REVIEWS SECTION - TITLE AND DESCRIPTION
//                        VStack(alignment: .leading, spacing: 8) {
//                            //Title
//                            HStack(alignment: .center) {
//                                Image(systemName: "star.square.fill")
//                                    .font(.system(size: 28, weight: .semibold))
//                                    .foregroundColor(Color("ReviewTeal"))
//                                Text("Review")
//                                    .font(.system(size: 28))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color("Dark1"))
//                                Spacer()
////                                Text("See All")
////                                    .font(.system(size: 16))
////                                    .fontWeight(.regular)
////                                    .foregroundColor(.blue)
//                            }.padding(.vertical)
//
//                            //Description
////                            Text("Earn points for reviews and referrals")
////                                .font(.system(size: 16))
////                                .fontWeight(.regular)
////                                .foregroundColor(Color("Dark1"))
////                                .multilineTextAlignment(.leading)
//                        }
//                        .padding(.horizontal)
//
//                        //MARK: REVIEWS SECTION - CONTENT
//                        VStack(alignment: .center, spacing: 24) {
//                            ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(3)) { item in
//
//                                LargeItemReviewWidget(item: item, selectedTab: $selectedTab)
//
//                            }
//                        }.padding(.vertical)
//
//
//
                        
//                        Divider().padding(.vertical).padding(.top).padding(.leading)
//
//                        //MARK: ALL ITEMS SECTION - TITLE AND DESCRIPTION
//                        VStack(alignment: .leading, spacing: 8) {
//                            //Title
//                            HStack(alignment: .center) {
//                                Text("All recent purchases")
//                                    .font(.system(size: 28))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color("Dark1"))
//                                Spacer()
//                            }.padding(.vertical)
//                        }
//                        .padding(.horizontal)
//
//                        //MARK: ALL ITEMS SECTION - CONTENT
//                        NavigationLink {
//                            ItemsAndOrders()
//                        } label: {
//                            Text("click here")
//                        }
                    }

                }
                
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            
            
            
            .background(Color("Background"))
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Your Purchases")
            
            //.ignoresSafeArea()
            //Note: need to ignoreSafeArea, set nav title to "", set barHidden to true in order not to break when returning from a navigationViewChild
            
            //.navigationBarTitleDisplayMode(.inline)
            //.navigationBarTitle("")
            //.navigationBarHidden(true)
            .onAppear {
                self.itemsViewModel.getSnapshotOfItems(userID: viewModel.userID ?? "")
                self.itemsViewModel.getSnapshotOfItemsWithMultipleReferrals(userID: viewModel.userID ?? "")
                self.itemsViewModel.getSnapshotOfItemsWith5StarsAndNoReferrals(userID: viewModel.userID ?? "")
                
                self.itemsViewModel.listenForMyItems(userID: viewModel.userID ?? "")
                //print(self.itemsViewModel.snapshotOfReviewableItems)
            }
            .onDisappear {
                
                if self.itemsViewModel.listener_MyItems != nil {
                    print("REMOVING LISTENER FOR MYITEMS")
                    self.itemsViewModel.listener_MyItems.remove()
                }
                
            }
        }
    }
    

    
    struct LargeItemReviewWidget: View {
        
        var item: Items
        
        @Binding var selectedTab: Int
        
        var body: some View {
            
            //Link to the Review Interceptor page
        
            NavigationLink {
                IntentToReview(itemObject: item)
            } label: {

                //Stack the following: a white card with the shadow, then the content of the card, then the overlaid "250 POINTS" and the review icon
                ZStack(alignment: .center) {
                    
                    //Background Color
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        //.frame(width: geometry.size.width, height: geometry.size.height)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    GeometryReader { geometry in
                        
                        ZStack (alignment: .top) {
                            
                            //MARK: THE IMAGE AND DESCRIPTION
                            VStack(spacing: 0) {

                                Image("redshorts")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(30)
                                    .padding()
                                    .frame(width: geometry.size.width, height: geometry.size.height - 90)
                                
                                Divider()
                                HStack(alignment: .center, spacing: 0) {
                                    Image("Athleisure LA")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 48, height: 48, alignment: .center)
                                        .clipped()
                                        .cornerRadius(12)
                                        .padding(.trailing)
                                    
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text("Lululemon")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Joggers 2.0")
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Dark1"))
                                    }
                                    Spacer()
                                    
                                    VStack(alignment: .center, spacing: 0) {
                                        Text("Review".uppercased())
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.gray.opacity(0.15)))
                                            .padding(.top, 14)
                                        HStack(alignment: .center, spacing: 4) {
                                            Image(systemName: "clock")
                                                .font(.system(size: 7, weight: .regular))
                                                .foregroundColor(Color("Gray1"))
                                            Text("30 SECONDS")
                                                .font(.system(size: 9, weight: .regular))
                                                .foregroundColor(Color("Gray1"))
                                        }.padding(.top, 4)
                                    }
                                    
                                    
                                }
                                .padding()
                                .padding(.bottom, 2)
                                .frame(width: geometry.size.width, height: CGFloat(90))
                                .background(.gray.opacity(0.05), in: Rectangle())
                            }
                            
                            //MARK: THE CALLOUT TO BE OVERLAID
                            VStack(alignment: .center, spacing: 0) {
                                HStack(alignment: .top, spacing: 0) {
                                    Text("+250 POINTS")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                        .background(RoundedCornersShape(corners: [.topLeft, .bottomRight], radius: 16)
                                            .foregroundColor(Color("ReviewTeal")))
                                    
                                    Spacer()
                                    Image(systemName: "star.circle")
                                        .font(.system(size: 32, weight: .medium))
                                        .padding(.all)
                                        .foregroundColor(Color("ReviewTeal"))
                                }
                                Spacer()
                                
                                
                            }
                            
                        
//                        //Object GOES HERE
                        }
                    }.frame(height: UIScreen.main.bounds.width - 24 + 32 + 24)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("ReviewTeal"), lineWidth: 4)
                    )
                    
                    
                    
                    
                    //.shadow(color: .black, radius: 30, x: 0, y: 0)
                }   //minus side padding, plus bottom icon size, plus bottom icon vertical padding
                .padding(.horizontal)
                
            }
        }
    }
    
    struct LargeItemReferWidget: View {
        
        var item: Items
        
        @Binding var selectedTab: Int
        
        var body: some View {
            
            //Link to the Review Interceptor page
            NavigationLink {
                IntentToRefer(itemObject: item)
            } label: {

                //Stack the following: a white card with the shadow, then the content of the card, then the overlaid "250 POINTS" and the review icon
                ZStack(alignment: .center) {
                    
                    //Background Color
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        //.frame(width: geometry.size.width, height: geometry.size.height)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    GeometryReader { geometry in
                        
                        ZStack (alignment: .top) {
                            
                            //MARK: THE IMAGE AND DESCRIPTION
                            VStack(spacing: 0) {

                                Image("redshorts")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(30)
                                    .padding()
                                    .frame(width: geometry.size.width, height: geometry.size.height - 90)
                                
                                Divider()
                                HStack(alignment: .center, spacing: 0) {
                                    Image("Athleisure LA")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 48, height: 48, alignment: .center)
                                        .clipped()
                                        .cornerRadius(12)
                                        .padding(.trailing)
                                    
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text("Lululemon")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Text("Joggers 2.0")
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color("Dark1"))
                                    }
                                    Spacer()
                                    
                                    VStack(alignment: .center, spacing: 0) {
                                        Text("Refer".uppercased())
                                            .font(.system(size: 16))
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.gray.opacity(0.15)))
                                            .padding(.top, 14)
                                        HStack(alignment: .center, spacing: 4) {
                                            Image(systemName: "clock")
                                                .font(.system(size: 7, weight: .regular))
                                                .foregroundColor(Color("Gray1"))
                                            Text("45 SECONDS")
                                                .font(.system(size: 9, weight: .regular))
                                                .foregroundColor(Color("Gray1"))
                                        }.padding(.top, 4)
                                    }
                                    
                                    
                                }
                                .padding()
                                .padding(.bottom, 2)
                                .frame(width: geometry.size.width, height: CGFloat(90))
                                .background(.gray.opacity(0.05), in: Rectangle())
                            }
                            
                            //MARK: THE CALLOUT TO BE OVERLAID
                            VStack(alignment: .center, spacing: 0) {
                                HStack(alignment: .top, spacing: 0) {
                                    Text("+20K POINTS")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                        .background(RoundedCornersShape(corners: [.topLeft, .bottomRight], radius: 16)
                                            .foregroundColor(Color("ReferPurple")))
                                    
                                    Spacer()
                                    Image(systemName: "paperplane.circle")
                                        .font(.system(size: 32, weight: .medium))
                                        .padding(.all)
                                        .foregroundColor(Color("ReferPurple"))
                                }
                                Spacer()
                                
                                
                            }
                            
                        
//                        //Object GOES HERE
                        }
                    }.frame(height: UIScreen.main.bounds.width - 24 + 32 + 24)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("ReferPurple"), lineWidth: 4)
                    )
                    
                    
                    
                    
                    //.shadow(color: .black, radius: 30, x: 0, y: 0)
                }   //minus side padding, plus bottom icon size, plus bottom icon vertical padding
                .padding(.horizontal)
                
            }
        }
    }
    
    struct RoundedCornersShape: Shape {
        let corners: UIRectCorner
        let radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
}


struct TopReferralsWidget: View {
    
    var item: Items
    
    var body: some View {
        
        //Link to the Review Interceptor page
        NavigationLink {
            Item(item: item)
            
        } label: {

            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Image("redshorts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                        .padding(.vertical, 20)
                    Text(item.order.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(item.order.companyName)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.bottom, 20)
                    Text(item.referrals.count == 1 ? String(item.referrals.count) + " Referral" : String(item.referrals.count) + " Referrals")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("ReferPurple"))
                        .padding(.bottom, 20)
                }
                Spacer()
            }
            
        }
    }
}

struct FiveStarReviewsWidget: View {
    
    var item: Items
    
    var body: some View {
        
        //Link to the Review Interceptor page
        NavigationLink {
            Item(item: item)
            
        } label: {
            ZStack(alignment: .top) {
                
                //the content of the widget
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Image("redshorts")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .padding(.top, 20)
                            .padding(.vertical, 20)
                        Text(item.order.title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                            .padding(.bottom, 8)
                        Text(item.ids.companyID)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("Gray1"))
                            .padding(.bottom, 20)
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Spacer()
                        }.font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.yellow)
                            .frame(height: 12)
                            .padding(.bottom, 20)
                    }
                    Spacer()
                }.frame(height: UIScreen.main.bounds.width / 6 + 134)
                
                //the overlaid callout showing bonus points
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        Text("+20,000")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .padding(.vertical, 5)
                            .padding(.horizontal, 14)
                            .foregroundColor(.white)
                            .background(RoundedCornersShape(corners: [.topLeft, .bottomRight], radius: 11)
                                .foregroundColor(Color("ReferPurple")))
                        
                        Spacer()
                    }
                    Spacer()
                }.frame(height: UIScreen.main.bounds.width / 6 + 134)
            }
            .frame(height: UIScreen.main.bounds.width / 6 + 134)
        }
    }
    
    struct RoundedCornersShape: Shape {
        let corners: UIRectCorner
        let radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
}

struct LazyVGridWidget: View {
    
    var item: Items
    
    var body: some View {
        
        //Link to the Review Interceptor page
        NavigationLink {
            Item(item: item)
            
        } label: {

            HStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Image("redshorts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                        .padding(.vertical, 20)
                    Text(item.order.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Dark1"))
                        .padding(.bottom, 8)
                    Text(item.ids.companyID)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray1"))
                        .padding(.bottom, 20)
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(0..<5) { i in
                            if i < item.review.rating {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        
//                        Image(systemName: "star")
//                        Image(systemName: "star")
//                        Image(systemName: "star")
//                        Image(systemName: "star")
                        Spacer()
                    }.font(.system(size: 12, weight: .regular))
                        .frame(height: 12)
                        .padding(.bottom, 20)
                    Text(item.referrals.count == 1 ? String(item.referrals.count) + " Referral" : String(item.referrals.count) + " Referrals")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(item.referrals.count == 0 ? "Gray2" : "ReferPurple"))
                        .padding(.bottom, 20)
                }
                Spacer()
            }
            
        }
    }
}


