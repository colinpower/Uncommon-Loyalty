//
//  Earn.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI


struct Earn: View {
    
    //Required for any tab
    @ObservedObject var viewModel = AppViewModel()
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    //Data for this view
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    //Variables for this view
    @State var isShowingTempTabView = false
    
    
    @State var isShowingContactsList:Bool = false
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
//                Button {
//                    isShowingTempTabView = true
//                } label: {
//                    Text("show temp tabview")
//                }.fullScreenCover(isPresented: $isShowingTempTabView) {
//                    TEMPTabview(isShowingTempTabView: $isShowingTempTabView)
//                }
                
//                RecommendedActions()
//                    .frame(width: 200, height: 200)
                
                //MARK: CONTENT
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        
                        //MARK: TOP SECTION
                        VStack(alignment: .leading) {
                            
                            Divider().padding(.leading)
                            
                            
                            
                            
                            HStack {
                                Text("Here's what's happening, Colin")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Dark1"))
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: UIScreen.main.bounds.width / 3)
                            }.padding(.leading)
                                .padding(.vertical)
                            .padding(.bottom)
                            .padding(.bottom)
                            
                            Text("Suggested for you")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading)
                                .padding(.bottom, 5)
                            
                            Divider()
                                .padding(.bottom)
                        }
                        
                        
                        Button {
                            isShowingContactsList.toggle()
                        } label: {
                            Text("SHOW CONTACTS")
                        }.sheet(isPresented: $isShowingContactsList) {
                            ContactsView()
                        }
                        
                        //MARK: REVIEWS SECTION - TITLE AND DESCRIPTION
                        VStack(alignment: .leading, spacing: 8) {
                            //Title
                            HStack(alignment: .center) {
                                Image(systemName: "star.square.fill")
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(Color("ReviewTeal"))
                                Text("Review")
                                    .font(.system(size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
//                                Text("See All")
//                                    .font(.system(size: 16))
//                                    .fontWeight(.regular)
//                                    .foregroundColor(.blue)
                            }.padding(.vertical)
                            
                            //Description
//                            Text("Earn points for reviews and referrals")
//                                .font(.system(size: 16))
//                                .fontWeight(.regular)
//                                .foregroundColor(Color("Dark1"))
//                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)
                        
                        //MARK: REVIEWS SECTION - CONTENT
                        VStack(alignment: .center, spacing: 24) {
                            ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(3)) { item in
                                                                
                                LargeItemReviewWidget(item: item, selectedTab: $selectedTab)

                            }
                        }.padding(.vertical)
                        
                        Divider().padding(.vertical).padding(.top).padding(.leading)
                        
                        //MARK: REFERRALS SECTION - TITLE AND DESCRIPTION
                        VStack(alignment: .leading, spacing: 8) {
                            //Title
                            HStack(alignment: .center) {
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(Color("ReferPurple"))
                                Text("Refer")
                                    .font(.system(size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
//                                Text("See All")
//                                    .font(.system(size: 16))
//                                    .fontWeight(.regular)
//                                    .foregroundColor(.blue)
                            }.padding(.vertical)
                        }
                        .padding(.horizontal)
                        
                        //MARK: REFERRALS SECTION - CONTENT
                        VStack(alignment: .center, spacing: 24) {
                            
                            ForEach(itemsViewModel.snapshotOfReviewableItems.prefix(3)) { item in
                                
                                LargeItemReferWidget(item: item, selectedTab: $selectedTab)
                                
                            }
                                
                        }.padding(.vertical)
                        
                        Divider().padding(.vertical).padding(.top).padding(.leading)
                        
                        //MARK: ALL ITEMS SECTION - TITLE AND DESCRIPTION
                        VStack(alignment: .leading, spacing: 8) {
                            //Title
                            HStack(alignment: .center) {
                                Text("All recent purchases")
                                    .font(.system(size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Dark1"))
                                Spacer()
                            }.padding(.vertical)
                        }
                        .padding(.horizontal)
                        
                        //MARK: ALL ITEMS SECTION - CONTENT
                        NavigationLink {
                            ItemsAndOrders()
                        } label: {
                            Text("click here")
                        }
                    }

                }
                
                //MARK: TABS
                MyTabView(selectedTab: $selectedTab)
                
            }
            
            
            
            .background(.white)
            //.background(Color("Background"))
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            //.ignoresSafeArea()                     //Note: need to ignoreSafeArea, set nav title to "", set barHidden to true in order not to break when returning from a navigationViewChild
            .navigationTitle("Earn").font(.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //this is a hack to get a navigationlink inside a toolbarItem
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            isProfileActive.toggle()
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color("Dark1"))
                        }.fullScreenCover(isPresented: $isProfileActive) {
                            Profile(isProfileActive: $isProfileActive)
                        }
                    }
                }
            }
            
            
            
            //.background(Color(.white))
            //.navigationBarTitleDisplayMode(.inline)
            //.navigationBarTitle("")
            //.navigationBarHidden(true)
            .onAppear {
                self.itemsViewModel.getSnapshotOfReviewableItems(userID: viewModel.userID ?? "")
                //print(self.itemsViewModel.snapshotOfReviewableItems)
            }
        }
    }
    
    struct LargeItemReviewWidget: View {
        
        var item: Items
        
        @Binding var selectedTab: Int
        
        var body: some View {
            
            //Link to the Review Interceptor page
        
            NavigationLink {
                IntentToReview(selectedTab: $selectedTab, itemObject: item)
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
                IntentToRefer(selectedTab: $selectedTab, itemObject: item)
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
    

struct Earn_Previews: PreviewProvider {
    static var previews: some View {
        Earn(selectedTab: .constant(0))
    }
}
