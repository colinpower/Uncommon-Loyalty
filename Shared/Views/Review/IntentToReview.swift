//
//  IntentToReview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

//Notes for future:
//  - should have 5 stars empty, and tapping them automatically triggers the review prompt
//  - ...


import SwiftUI

struct IntentToReview: View {
    
    //ViewModels
    @ObservedObject var itemsViewModel = ItemsViewModel()
    
    //State
    @State var showingReviewProductScreen: Bool = false
    @State var isShowingItemSheet:Bool = false
    
    //Binding
    @Binding var selectedTab: Int
    
    //Required variables
    var itemObject:Items
    
    var body: some View {
            
        VStack(spacing: 0) {
        
            //MARK: HEADER (STAR + "REVIEW" AT THE TOP)
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 38, height: 38)
                        .foregroundColor(.white)
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(Color("ReviewTeal"))
                }
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Review")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color("Dark1"))
                    Spacer()
                }
            }.padding([.horizontal, .top])
        
            //MARK: CONTENT
            List {
                
                //MARK: EMPTY REVIEW SECTION
                Section {
                    
                    //empty review
                    HStack(alignment: .center) {
                        
                        //image
                        Image("redshorts")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                            .cornerRadius(32)
                            .padding(.trailing).padding(.trailing)
                        
                        //empty review
                        VStack(alignment: .leading, spacing: 0) {
                            Text(itemObject.title)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                            
                            Text("SKU, PRICE")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(.bottom)
                            
                            HStack(alignment: .center) {
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                            }.font(.system(size: 18))
                            .foregroundColor(.gray)

                        }
                    }
                    
                    //order details
                    Button {
                        isShowingItemSheet.toggle()
                    } label: {
                        Text("Order details")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                    }.sheet(isPresented: $isShowingItemSheet) {
                        isShowingItemSheet = false
                    } content: {
                        Item(itemID: itemObject.itemID)
                    }
                    
                }
                
                
                //MARK: VIEW COMPANY SECTION
                Section {
                    //company -> about us page
                    NavigationLink {
                        ProfileTEMP()
                    } label: {
                        HStack {

                            Image("Athleisure LA")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 28, height: 28, alignment: .center)
                                .clipped()
                                .cornerRadius(7)
                                .padding(.horizontal, 2)

                            Text("Athleisure LA")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            Spacer()

                        }

                    }
                }
                
                
                //MARK: POINTS, TIME, QUESTIONS
                Section(header: Text("Review details")) {
                    
                    //questions
                    ReviewDetailsSectionRow(image: "questionmark.circle", title: "Length", description: "3 questions")
                    
                    //time
                    ReviewDetailsSectionRow(image: "clock", title: "Time", description: "30 seconds")
                    
                    //points
                    ReviewDetailsSectionRow(image: "star.circle", title: "Earn", description: "300 points")
                    
                }
            }
            

            Spacer()
        
        
            Button(action: {
                showingReviewProductScreen = true
            }) {
               HStack {
                   Spacer()
                   Text("Let's go")
                       .foregroundColor(Color.white)
                       .font(.system(size: 18))
                       .fontWeight(.semibold)
                       .padding(.vertical, 16)
                   Spacer()
               }.background(RoundedRectangle(cornerRadius: 36).fill(Color("ReviewTeal")))
                .padding(.horizontal)
                .padding(.horizontal)
            }
                .padding(.bottom)
                .padding(.bottom)
            
            
            MyTabView(selectedTab: $selectedTab)
            
        }.background(Color("Background"))
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $showingReviewProductScreen, content: {
            ReviewProductCarousel1(showingReviewProductScreen: $showingReviewProductScreen, itemObject: itemObject)
        })
//       .onAppear {
//           self.itemsViewModel.getSnapshotOfItem(itemID: itemObject.itemID)
//       }
        
    }
}
