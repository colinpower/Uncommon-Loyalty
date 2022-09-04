//
//  CreateACard.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/3/22.
//

import SwiftUI

struct CreateACard: View {
    var body: some View {
        GeometryReader { geometry in

            ZStack(alignment: .center) {
            Image("AthleisureLA-Gold-Discount")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                .clipped()
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)
                
                Text("alsdkfjasldfk")
            }

        }.padding(.horizontal)
        .frame(height: UIScreen.main.bounds.width / 1.6)
    }
}

struct CreateACard_Previews: PreviewProvider {
    static var previews: some View {
        CreateACard()
    }
}
