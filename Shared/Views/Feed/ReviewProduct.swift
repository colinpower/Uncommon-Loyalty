//
//  ReviewProduct.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI

struct ReviewProduct: View {
    var body: some View {
        VStack {
            HStack {
                Image("AthleisureSweatpants")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Hi Colin! We delivered your new Kool 2.0 joggers last week. Can you tell us how you like them?")
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.bottom, 4)
                }
            }
            
            //MARK: Give a rating
            VStack {
                HStack {
                    Text("Give a rating")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("+5 points")
                        .font(.footnote)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.3)))
                }
                HStack{
                    Image("AthleisureSweatpants")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50, alignment: .center)
                    Image("AthleisureSweatpants")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50, alignment: .center)
                    Image("AthleisureSweatpants")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
            //MARK: Title
            HStack {
                Text("TITLE")
                Spacer()
                Text("+10 points")
                    .font(.footnote)
                    .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                    .padding(.all, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.3)))
            }
            HStack {
                Text("DESCRIPTION")
                Spacer()
                Text("+25 points")
                    .font(.footnote)
                    .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                    .padding(.all, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.3)))
            }
            //MARK: How did it fit?
            VStack {
                Text("how did it fit?")
            }
            
            //MARK: Add a photo
            Text("Add a photo")
            
            //MARK: Submit
            Text("Submit")
            
        }
    }
}

struct ReviewProduct_Previews: PreviewProvider {
    static var previews: some View {
        ReviewProduct()
    }
}
