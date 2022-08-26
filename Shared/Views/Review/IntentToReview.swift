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
            
            Image("redshorts")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30)
                .padding()
                .frame(width: UIScreen.main.bounds.width/3*2, height: UIScreen.main.bounds.height/3)
                .padding(.vertical, 60)
                .background(Color("Background").opacity(0.1))
            VStack(alignment: .center, spacing: 8) {
                Text("Joggers 2.0")
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
                Text("Lululemon".uppercased())
                    .kerning(1.1)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Gray1"))
            }
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
//        IntentToReview()
//    }
//}
