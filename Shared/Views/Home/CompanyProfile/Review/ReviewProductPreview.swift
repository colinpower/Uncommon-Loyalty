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
    
    @ObservedObject var viewModel4 = ReviewsViewModel()
    
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
                    ZStack (alignment: .center) {
                        Color(red: 253/255, green: 251/255, blue: 255/255)
                            //.frame(width: geometry.size.width / 2, height: geometry.size.height / 4, alignment: .center)
                        VStack {
                            Spacer()
                            HStack {
                                Text("Order Details")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Spacer()
                            }.padding(.leading, 24)
                            HStack {
                                Spacer()
                                //MARK: SIZE
                                VStack(alignment: .center) {
                                    Text("Size")
                                        .font(.title3)
                                        .padding(.bottom, 8)
                                        .foregroundColor(Color(red: 135/255, green: 134/255, blue: 135/255))
                                    Text("M")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                }.frame(width: geometry.size.width/4)
                                    .padding(.vertical, 16)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 243/255, green: 241/255, blue: 244/255)))
                                
                                Spacer()
                                
                                //MARK: PRICE
                                VStack(alignment: .center) {
                                    Text("Price")
                                        .font(.title3)
                                        .padding(.bottom, 8)
                                        .foregroundColor(Color(red: 135/255, green: 134/255, blue: 135/255))
                                    Text("$89")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                }.frame(width: geometry.size.width/4)
                                    .padding(.vertical, 16)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 243/255, green: 241/255, blue: 244/255)))
                                
                                Spacer()
                                
                                //MARK: DELIVERY
                                VStack(alignment: .center) {
                                    Text("Delivered")
                                        .font(.title3)
                                        .padding(.bottom, 8)
                                        .foregroundColor(Color(red: 135/255, green: 134/255, blue: 135/255))
                                    Text("Apr 14")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                }.frame(width: geometry.size.width/4)
                                    .padding(.vertical, 16)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 243/255, green: 241/255, blue: 244/255)))
                                
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Text("Earn +100 pts by leaving a review")
                                    .font(.body)
                                    .italic()
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "clock.fill")
                                Text("2m")
                            }.padding(.horizontal, 24)
                                .padding(.bottom, 16)
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
                VStack {
                    Text("Kool 2.0 Joggers")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor.black))
                    Text("Athleisure LA")
                        .font(.body)
                        .foregroundColor(Color(red: 135/255, green: 134/255, blue: 135/255))
                }
                .padding()
                .padding(.horizontal)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 24).fill(Color(red: 243/255, green: 241/255, blue: 244/255)).shadow(color: .gray, radius: 10, x: 4, y: 4))
                
                
            }
        }.ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
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
        ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "temp Order ID", userID: "temp user ID")
    }
}







