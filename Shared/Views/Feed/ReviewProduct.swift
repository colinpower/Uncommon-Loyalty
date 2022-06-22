//
//  ReviewProduct.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI


//how to upload an image to firebase
//https://www.youtube.com/watch?v=5inXE5d2MUM

struct ReviewProduct: View {
    
    var companyID: String
    var email: String
    var orderID: String
    var userID: String
    
    
    @State var rating: Int = 0
    @State private var title:String = ""
    @State private var details:String = ""
    
    @ObservedObject var viewModel4 = ReviewsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("AthleisureSweatpants")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.trailing, 12)
                    Text("We delivered your new Kool 2.0 joggers last week. Can you tell us how you like them?")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                .padding(.bottom, 8)
                Text("Earn points as you fill out this form! You can earn up to 250 points for submitting a review.")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.bottom, 36)
                
                HStack(alignment: .center) {
                    Text("Rating (25)")
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 120, alignment: .leading)
                    Spacer()
                    RatingView(rating: $rating)
                }.padding(.bottom, 24)
                
                HStack(alignment: .center) {
                    Text("Title (25)")
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 120, alignment: .leading)
                    Spacer()
                    TextField("Add a title", text: $title)
                        .frame(width: 120)
                        .multilineTextAlignment(.trailing)
                        
                }.padding(.bottom, 24)
                
                VStack(alignment: .leading) {
                    Text("Details (50)")
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 120, alignment: .leading)
                    TextEditor(text: $details)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 100, maxHeight: 100)
                        .border(.gray)
                }.padding(.bottom, 24)
                
                //MARK: Add a photo
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Upload a favorite photo (150)")
                            .font(.body)
                            .fontWeight(.medium)
                            .padding(.bottom, 4)
                        Text("We might use your photo in an future marketing campaign!")
                            .font(.footnote)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 50, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                            .foregroundColor(.indigo)
                        Text("Upload")
                    }
                    .frame(width: 80, height: 80, alignment: .center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(.black.opacity(0.3)))
                }.padding(.bottom, 36)
                
                
                
                //MARK: Submit
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel4.addReview(companyID: companyID, reviewDetails: details, email: "colinjpower1@gmail.com", orderID: orderID, reviewRating: rating, reviewTitle: title, userID: userID)
                    }) {
                        Text("Submit")
                            .foregroundColor(rating == 0 ? Color.white.opacity(0.4) : Color.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 36).fill(rating == 0 ? Color.blue.opacity(0.4) : Color.blue))
                    }
                    .disabled(rating==0)
                    Spacer()
                }
                Spacer()
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
        }
        .navigationBarTitle("Review", displayMode: .inline)
    }
}




struct ReviewProduct_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProduct(companyID: "zKL7SQ0jRP8351a0NnHM", email: "colinjpower1@gmail.com", orderID: "temp Order ID", userID: "temp user ID")
    }
}
