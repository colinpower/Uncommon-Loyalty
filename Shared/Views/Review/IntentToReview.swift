//
//  IntentToReview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct IntentToReview: View {
    
    @State var showingReviewProductScreen: Bool = false
    
    //@ObservedObject var itemsViewModel = ItemsViewModel()
    
    var itemObject:Items
    
    var detailsOfReview:[String] = ["3", "30", "200"]
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            
            VStack {
            
            //MARK: "WRITE A REVIEW" AT THE TOP
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: "star.square.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color("ReviewTeal"))
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Review")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark1"))
                    Spacer()
                    
                    //MARK: STARS (EMPTY)
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: "star")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                        Image(systemName: "star")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                        Image(systemName: "star")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                        Image(systemName: "star")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                        Image(systemName: "star")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                    }.padding(.bottom, 2)
                }
            }.padding()
            
            //MARK: PRODUCT IMAGE
            ZStack {
                Color(.white)
                    .frame(height: UIScreen.main.bounds.width/3*2)
                VStack (alignment: .center, spacing: 0) {
                    Image("redshorts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width/3*2)
                }
            }
            
            //MARK: PRODUCT NAME, COMPANY, PRICE
            VStack(alignment: .center) {
                Text("Athleisure LA - Joggers 2.0")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("Gray1"))
                    .padding(.bottom, 8)
                Text("View order")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color.blue)
            }.padding(.bottom, 8)
            
            
            
            
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundColor(.white)
//                .frame(maxHeight: CGFloat(40))
//                .shadow(color: Color(.black).opacity(0.15), radius: 4, x: 0, y: 2)
//                .overlay {
//                    HStack(alignment: .center, spacing: 0) {
////                        Image("Athleisure LA")
////                            .resizable()
////                            .scaledToFill()
////                            .frame(width: 40, height: 40, alignment: .center)
////                            .clipped()
////                            .cornerRadius(10)
////                            .padding(.trailing)
//
////                        VStack(alignment: .leading, spacing: 1) {
//                            Text("Lululemon")
//                                .font(.system(size: 20))
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color("Dark1"))
//                                .padding(.trailing, 3)
//                            Text("Joggers 2.0")
//                                .font(.system(size: 20))
//                                .fontWeight(.regular)
//                                .foregroundColor(Color("Dark1"))
////                        }
//                        Spacer()
//                        Image(systemName: "info.circle")
//                            .font(.system(size: 20, weight: .regular))
//                            //.foregroundColor(.blue)
//                            .foregroundColor(Color("ReviewTeal"))
//                    }
//                    .padding()
//                    .frame(maxHeight: CGFloat(40))
//                }.padding()
                
            
            
            
            
                
            
//            HStack(alignment: .center, spacing: 8) {
//                Spacer()
//                Text("Joggers 2.0")
//                Image(systemName: "circle.fill")
//                    .font(.system(size: 4, weight: .semibold))
//                Text("Athleisure LA")
//            }.foregroundColor(.gray)
//                .padding(.trailing)

            
            List {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.square")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("Questions")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Text("3")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                HStack(spacing: 8) {
                    Label {
                        Text("Questions")
                    } icon: {
                        Image(systemName: "questionmark.square")
                    }
                    Spacer()
                    Text("3")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
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
            
            }.background(Color("Background"))
            MyTabView(selectedTab: $selectedTab)
            
        }
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

//struct IntentToReview_Previews: PreviewProvider {
//    static var previews: some View {
//        IntentToReview(itemObject: <#T##Items#>)
//    }
//}
