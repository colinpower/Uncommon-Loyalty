//
//  FeaturedWidget1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/8/22.
//

import SwiftUI

struct FeaturedWidget1: View {
    
    var namespace: Namespace.ID
    
    @Binding var isFeaturedWidget1Active:Bool
    
    var category: String
    var title: String
    var subtitle: String
    var backgroundImage: String
    var foregroundImage: String
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text(category.uppercased())
                    .font(.system(size: 16))
                    .kerning(1.1)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Gray1"))
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                    .padding(.bottom, 6)
                Text(title)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                Text(subtitle)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color("Dark1"))
                    .lineLimit(1)
                    .matchedGeometryEffect(id: "text", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
                .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
            .foregroundStyle(.white)
            .background(
                Image(foregroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image", in: namespace)
            )
            .background(
                Image(backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background", in: namespace)
            ).mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            )
            .frame(height: 300)
            .padding(20)
    }
}

struct FeaturedWidget1_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        FeaturedWidget1(namespace: namespace, isFeaturedWidget1Active: .constant(true), category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure")
    }
}
