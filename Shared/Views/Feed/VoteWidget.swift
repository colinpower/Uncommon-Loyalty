//
//  VoteWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI

struct VoteWidget: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("SwanSkincare")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36, alignment: .center)
                .clipped()
                .cornerRadius(10)
                .padding(.trailing, 12)
            VStack{
                HStack {
                    Text("Swan Skincare - Vote!")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Hi Colin! We're thinking about making a new travel-sized face wash. Would you be interested?")
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
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
                HStack(alignment: .center){
                    Text("I'm interested!")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.blue)
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue))
                    Text("No thanks")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.blue)
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.blue))
                }
                Text("View conversation ->")
                    .font(.footnote)
                    .foregroundColor(Color.blue)
            }
        }.padding(.horizontal, 12)
    }
}

struct VoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        VoteWidget()
    }
}
