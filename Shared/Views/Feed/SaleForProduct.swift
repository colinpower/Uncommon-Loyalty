//
//  SaleForProduct.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/24/22.
//

import SwiftUI

struct SaleForProduct: View {
    var body: some View {
        VStack {
//            Divider()
//            ScrollView(.horizontal) {
//                HStack(spacing: 10) {
//                    ForEach(0..<5) { index in
//                        Rectangle()
//                            .fill(Color.gray)
//                            .frame(width: 350, height: 400, alignment: .leading)
//                    }
//                }.padding()
//            }.frame(height: 100)
//            Divider()
//            Spacer()
            Rectangle()
                .fill(Color.gray)
                .frame(width: 350, height: 400, alignment: .leading)
            Text("T Shirt")
            Text("Bonobos USA")
            HStack {
                Text("$68")
                Text("now $50")
                Spacer()
            }
            HStack{
                Text("Discount code: COLIN123")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
                Image(systemName: "doc.on.doc")
                    .font(.body)
                    .foregroundColor(.black)
            }
            HStack {
                Spacer()
                Text("Visit Bonobos Site")
                    .foregroundColor(Color.blue)
                Spacer()
            }
        }
    }
}

struct SaleForProduct_Previews: PreviewProvider {
    static var previews: some View {
        SaleForProduct()
    }
}
