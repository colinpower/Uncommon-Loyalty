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
    
    var detailsOfReview:[String] = ["3", "30s", "200"]
    
    var body: some View {
        VStack {
            
            ZStack {
                Color("ThemeLight")
                VStack (alignment: .center, spacing: 0) {
                    Image("redshorts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .shadow(color: Color("ThemePrimary").opacity(0.5), radius: 10, x: 0, y: 4)
                        .overlay {
                            HStack(alignment: .center, spacing: 0) {
                                Image("Athleisure LA")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .clipped()
                                    .cornerRadius(10)
                                    .padding(.trailing)
                                
                                VStack(alignment: .leading, spacing: 1) {
                                    Text("Lululemon")
                                        .font(.system(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("Dark1"))
                                    Text("Joggers 2.0")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .foregroundColor(Color("Dark1"))
                                }
                                Spacer()
                                Image(systemName: "info.circle")
                                    .font(.system(size: 20, weight: .regular))
                                    //.foregroundColor(.blue)
                                    .foregroundColor(Color("ThemeAction"))
                            }
                            .padding()
                        }
                        .frame(maxHeight: CGFloat(72))
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
            }.frame(height: UIScreen.main.bounds.width/3*2+120)
            
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "star.square.fill")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color("ReviewTeal"))
                Text("Write a review")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Dark1"))
            }
                Spacer()
            }.padding()
//            Image("redshorts")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(30)
//                .padding()
//                .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
//                .padding(.vertical, 60)
//                .background(Color("Background").opacity(0.1))
//            VStack(alignment: .center, spacing: 8) {
//                Text("Joggers 2.0")
//                    .font(.system(size: 32))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Dark1"))
//                Text("Lululemon".uppercased())
//                    .kerning(1.1)
//                    .font(.system(size: 20))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color("Gray1"))
//            }
            
            
            
            Spacer()
            
            
            HStack (alignment: .center) {
                Spacer()
                VStack(alignment: .center, spacing: 6) {
                    Text(String(detailsOfReview[0]))
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.blue))
                    Text("Questions".uppercased())
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Gray1"))
                }.frame(width: UIScreen.main.bounds.width/10*3)
                Spacer()
                VStack(alignment: .center, spacing: 6) {
                    Text(String(detailsOfReview[1]))
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.blue))
                    Text("Time Needed".uppercased())
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Gray1"))
                }.frame(width: UIScreen.main.bounds.width/10*3)
                Spacer()
                VStack(alignment: .center, spacing: 6) {
                    Text(String(detailsOfReview[2]))
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.blue))
                    Text("Points".uppercased())
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Gray1"))
                }.frame(width: UIScreen.main.bounds.width/10*3)
                Spacer()
            }.padding(.horizontal).padding(.horizontal)
            
            Spacer()
            
            
            Button(action: {
               showingReviewProductScreen = true
           }) {
               HStack {
                   Spacer()
                   Text("Start Review")
                       .foregroundColor(Color.white)
                       .font(.system(size: 18))
                       .fontWeight(.semibold)
                       .padding(.vertical, 16)
                   Spacer()
               }.background(RoundedRectangle(cornerRadius: 36).fill(Color.blue))
                .padding(.horizontal)
                .padding(.horizontal)   
           }
           Spacer()
        }
        .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
        .navigationBarTitle("TESTING", displayMode: .inline)
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
