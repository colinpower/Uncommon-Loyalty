//
//  FeedWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 1/24/22.
//

import SwiftUI

struct FeedWidget: View {
//    var company: String
//    var points: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 350, height: 400, alignment: .leading)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Men's natural run short")
                            .fontWeight(.medium)
                        Text("Medium gray")
                        Text("$68")
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text("Points").font(.footnote).foregroundColor(Color.black.opacity(0.7))
                }
            }.padding(.leading, 32)
        }
        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray, lineWidth: 0.5))
        .padding(.horizontal, 12)
    }
}

struct FeedWidget_Previews: PreviewProvider {
    static var previews: some View {
        FeedWidget()
    }
}
