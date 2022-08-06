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
    var orderID: String
    var userID: String
    
    
    @State var rating: Int = 0
    @State private var title:String = ""
    @State private var details:String = ""
    
    @State var showingReviewProductScreen: Bool = false
    
    @Binding var isActive: Bool
    
    @ObservedObject var viewModel4 = OrdersViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing:0) {
                    ZStack (alignment: .center) {
                        
                        
                        //CREATE ANIMATED BACKGROUND FOR THIS
                        //https://www.youtube.com/watch?v=YhhGx0pLOnk
                        //AnimatedBackground()
                        Image("ReviewBackground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .center)
                        Image("AthleisureSweatpants")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 4, alignment: .center)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 10, x: 4, y: 4)
                    }
                    
                    //MARK: Bottom half (details of order)
                    ZStack (alignment: .center) {
                        
                        //Background color
                        Color("Background")
                        
                        //View
                        VStack {
                            
                            //Details section
                            VStack(alignment: .leading) {
                                
                                //Header
                                HStack {
                                    Text("ITEM NAME")
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                }.padding(.bottom)
                                
                                //FOR EACH DISCOUNT CODE, SHOW IT HERE
                                
                                ForEach(viewModel4.oneOrder.prefix(1)) { Order in
                                    VStack(alignment: .leading) {
                                        OrderDetailsForReview(title: "Item", value: Order.item)
                                        OrderDetailsForReview(title: "Price", value: String(Order.totalPrice))
                                        OrderDetailsForReview(title: "Size", value: "Medium")
                                        OrderDetailsForReview(title: "Date", value: "Jan 3")
                                    }
                                }
                                HStack {
                                    Spacer()
                                    Text("See all")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Spacer()
                                }
                            }.padding().padding(.vertical).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                                .padding(.horizontal).padding(.bottom)
                            
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
                                
                                //Button
                                Button(action: {
                                   showingReviewProductScreen = true
                               }) {
                                   Text("Start Review")
                                       .foregroundColor(Color.white)
                                       .font(.body)
                                       .fontWeight(.semibold)
                                       .frame(width: geometry.size.width * 0.8, alignment: .center)
                                       .padding(.vertical, 16)
                                       .background(RoundedRectangle(cornerRadius: 36)
                                        .fill(Color.blue))
                               }.fullScreenCover(isPresented: $showingReviewProductScreen, content: {
                                   ReviewProductCarousel1(showingReviewProductScreen: $showingReviewProductScreen)
                                   //ReviewProduct(companyID: companyID, email: email, orderID: orderID, userID: userID, showingReviewProductScreen: $showingReviewProductScreen)
                               })
                            }.padding(.bottom, 40)
                        }
                    }
                    
                }
                VStack {
                    Button {
                        isActive.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    Text("Kool 2.0 Joggers")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor.black))
                    Text("Athleisure LA")
                        .font(.body)
                        .foregroundColor(Color(red: 135/255, green: 134/255, blue: 135/255))
                }.padding().padding(.horizontal).padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 243/255, green: 241/255, blue: 244/255)).shadow(color: .gray, radius: 10, x: 4, y: 4))
            }
        }.ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            self.viewModel4.listenForOneOrder(email: "colinjpower1@gmail.com", companyID: companyID, orderID: "BP1KvlMpXqPry3SLRvAu")
            print("TRIGGERED THIS")
        }
        
    }
}







//                VStack {
//                    ZStack (alignment: .center) {
//                    Image("ReviewBackground")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .center)
//                    Image("AthleisureSweatpants")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 4, alignment: .center)
//                        .clipped()
//                        .cornerRadius(20)
//                        .shadow(color: .gray, radius: 10, x: 4, y: 4)
//                    }
//                    ZStack (alignment: .center) {
//                        Color.white
//                        VStack {
//                            Spacer()
//                            Text("here123")
//
//                            Spacer()
//
//
//                            //MARK: Submit
////                            Button(action: {
////                                showingReviewProductScreen = true
////                            }) {
////                                Text("Start Review")
////                                foregroundColor(Color.white)
////                                .font(.headline)
////                                .frame(width: geometry.size.width * 0.8, alignment: .center)
////                                .padding(.vertical, 16)
////                                .background(RoundedRectangle(cornerRadius: 36)
////                                    .fill(Color.blue))
////                            }.fullScreenCover(isPresented: $showingReviewProductScreen, content: {
////                                ReviewProductCarousel1(showingReviewProductScreen: $showingReviewProductScreen)
////                                //ReviewProduct(companyID: companyID, email: email, orderID: orderID, userID: userID, showingReviewProductScreen: $showingReviewProductScreen)
////                            })
//
//
//                        }.padding(.bottom, 32)
//
//
//                    }
//
//                }
////                VStack {
////                    Text("Kool 2.0 Joggers")
////                        .font(.title2)
////                        .foregroundColor(Color(UIColor.white))
////        //                        .padding(.bottom, 2)
////                    Text("$89 / M / Delivered")
////                        .font(.subheadline)
////                        .foregroundColor(Color(UIColor.white))
////                }
////                .padding()
////                .padding(.horizontal)
////                .padding(.horizontal)
////                .background(RoundedRectangle(cornerRadius: 36).fill(Color(UIColor.lightGray)))
//
//
//            }
////            HStack {
////                Spacer()
////                Button {
////                    showingReviewProductScreen = false
////                } label: {
////                    Image(systemName: "x.circle")
////                        .font(.title)
////                        .foregroundColor(Color(UIColor.lightGray))
////                        .padding(.horizontal, 24)
////                        .padding(.vertical, 32)
////                }
////
////
////            }
//
//        }.ignoresSafeArea()
//        //.navigationBarTitle("", displayMode: .inline)
//    }
//}

struct ReviewProductPreview_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "temp Order ID", userID: "temp user ID", isActive: .constant(true))
    }
}







