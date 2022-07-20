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
        ZStack {
            VStack {
                Image("ReviewBackground")
                    .resizable()
                    .scaledToFill()
                Color.white
            }
            VStack(alignment: .leading) {
                Spacer()
                Image("AthleisureSweatpants")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 250, alignment: .center)
                    .clipped()
                    .cornerRadius(20)
                Spacer()
                VStack {
                    Text("Kool 2.0 Joggers")
                        .font(.headline)
                        .foregroundColor(Color.black)
                    Text("M / $89 / Delivered")
                        .font(.body)
                        .foregroundColor(Color.black)
                }
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 36).fill(Color.gray))
               
                
                //MARK: Submit
                Button(action: {
                    showingReviewProductScreen = true
                }) {
                    Text("Start Review")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 36).fill(Color.blue))
                }.sheet(isPresented: $showingReviewProductScreen, content: {
                    
                    ReviewProduct(companyID: companyID, email: email, orderID: orderID, userID: userID, showingReviewProductScreen: $showingReviewProductScreen)
                })
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
        }
        .ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
        
    }
}

struct ReviewProductPreview_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProductPreview(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "temp Order ID", userID: "temp user ID")
    }
}
