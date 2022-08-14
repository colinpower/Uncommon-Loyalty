//
//  ReviewWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI

struct ReviewWidget: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("AthleisureLA")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36, alignment: .center)
                .clipped()
                .cornerRadius(10)
                .padding(.trailing, 12)
            VStack{
                HStack {
                    Text("Athleisure LA - Review")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("+100 points")
                        .font(.footnote)
                        .foregroundColor(Color(red: 114/255, green: 101/255, blue: 82/255))
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.82, green: 0.72, blue: 0.58).opacity(0.3)))
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Hi Colin! We delivered your new Kool 2.0 joggers last week. Can you tell us how you like them?")
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.bottom, 4)
                    }
                    Spacer()
                    Image("AthleisureSweatpants")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .cornerRadius(10)
                }
            }
        }.padding(.horizontal, 12)
    }
}

struct ReviewWidget_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWidget()
    }
}

