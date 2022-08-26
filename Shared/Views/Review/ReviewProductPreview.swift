//
//  ReviewProductPreview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 7/19/22.
//

import SwiftUI

struct ReviewProductPreview: View {
    
    var companyID: String
    var email: String
    var itemID: String
    var userID: String
    

    @State var rating: Int = 0
    @State private var title:String = ""
    @State private var details:String = ""
    
    @State var showingReviewProductScreen: Bool = false
    
    @Binding var isActive: Bool
    
    @ObservedObject var viewModel4 = OrdersViewModel()
    
    @ObservedObject var viewModel_Items = ItemsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
                
                VStack(spacing:0) {
                    
                    //MARK: IMAGE SECTION
                    //Background + Image of product (taking up 1/3 of screen)
                    ZStack (alignment: .top) {
                        
                        //CREATE ANIMATED BACKGROUND FOR THIS
                        //https://www.youtube.com/watch?v=YhhGx0pLOnk
                        //AnimatedBackground()
                        Image("ReviewBackground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .center)
                        //MARK: Title, X Button
                        VStack {
                            SheetHeader(title: "Add a Review", isActive: $isActive)
                            Image("AthleisureSweatpants")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width / 4, height: geometry.size.height / 8, alignment: .center)
                                .clipped()
                                .cornerRadius(16)
                                .shadow(color: .gray, radius: 10, x: 4, y: 4)
                                .padding(.vertical)
                        }
                    }
                    
                    //MARK: DETAILS + START REVIEW BUTTON
                    ZStack (alignment: .center) {
                        
                        //Background color
                        Color("Background")
                        
                        //View
                        VStack {
                            
                            //Details section
                            ScrollView(.vertical) {
                                VStack {
                                
                                    //Header
                                    HStack {
                                        Text("Order Details")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("Dark1"))
                                        Spacer()
                                    }.padding(.bottom)
                                    
                                    //FOR EACH DISCOUNT CODE, SHOW IT HERE
                                    
                                    ForEach(viewModel4.oneOrder.prefix(1)) { Order in
                                        VStack(alignment: .leading) {
                                            OrderDetailsForReview(title: "Item", value: Order.item_firstItemTitle)
                                            OrderDetailsForReview(title: "Price", value: String(Order.totalPrice))
                                            OrderDetailsForReview(title: "Size", value: "Medium")
                                            OrderDetailsForReview(title: "Date", value: "Jan 3")
                                        }
                                    }
                                }.padding().padding(.vertical).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                                    .padding()
                                Spacer()
                            }
                            Spacer()
                            VStack {
                                
                                //"Leave points for this review"
                                HStack {
                                    Text("Earn +100 pts by leaving a review")
                                        .font(.body)
                                        .italic()
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "clock.fill")
                                    Text("2m")
                                }.padding(.horizontal, 24).padding(.bottom, 16)
                                
//                                //Button
//                                Button(action: {
//                                   showingReviewProductScreen = true
//                               }) {
//                                   Text("Start Review")
//                                       .foregroundColor(Color.white)
//                                       .font(.body)
//                                       .fontWeight(.semibold)
//                                       .frame(width: geometry.size.width * 0.8, alignment: .center)
//                                       .padding(.vertical, 16)
//                                       .background(RoundedRectangle(cornerRadius: 36)
//                                        .fill(Color.blue))
//                               }.fullScreenCover(isPresented: $showingReviewProductScreen, content: {
//                                   ReviewProductCarousel1(showingReviewProductScreen: $showingReviewProductScreen, companyID: companyID, itemID: itemID, email: email, emailUID: userID)
//                               })
                            }.padding(.bottom, 40)
                        }.padding(.top)
                    }
                    
                }
        }.ignoresSafeArea()
        .onAppear {
            self.viewModel_Items.listenForOneItem(email: email, companyID: companyID, itemID: itemID)
//            self.viewModel4.listenForOneOrder(email: "colinjpower1@gmail.com", companyID: companyID, orderID: "BP1KvlMpXqPry3SLRvAu")
//            print("TRIGGERED THIS")
        }
        .onDisappear{
            print("Review Product Preview disappearing!!")
        }
        
    }
}


struct ReviewProductPreview_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", itemID: "Z3GBvz1xRYuHl8Tj6Z9j", userID: "temp user ID", isActive: .constant(true))
    }
}







