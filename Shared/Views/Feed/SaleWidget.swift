//
//  SaleWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/24/22.
//

import SwiftUI

struct SaleWidget: View {
//    var company: String
//    var points: Int
    
    var body: some View {
        HStack(alignment: .top) {
            Image("Decora")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36, alignment: .center)
                .clipped()
                .cornerRadius(10)
                .padding(.trailing, 12)
            VStack{
                HStack {
                    Text("Decora - Sale")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("10% off")
                        .font(.footnote)
                        .foregroundColor(Color.green)
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.green.opacity(0.3)))
                }
                VStack(alignment: .leading) {
                    Text("Hi Colin! We put our Kool 2.0 joggers on sale for Gold customers only. Use our promo code inside to get the deal!")
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.bottom, 4)
                }
                Image("AthleisureSweatpants")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
            }
        }.padding(.horizontal, 12)
    }
}

struct FeedWidget_Previews: PreviewProvider {
    static var previews: some View {
        SaleWidget()
    }
}




//VStack {
//    Rectangle()
//        .fill(Color.gray)
//        .frame(width: 350, height: 400, alignment: .leading)
//    VStack {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Men's natural run short")
//                    .fontWeight(.medium)
//                Text("Medium gray")
//                Text("$68")
//            }
//            Spacer()
//        }
//        HStack{
//            Spacer()
//            Text("Points").font(.footnote).foregroundColor(Color.black.opacity(0.7))
//        }
//    }.padding(.leading, 32)
//}
//.background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 0.5))
//.padding(.horizontal, 12)
