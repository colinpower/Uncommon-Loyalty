//
//  FeaturedView1.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/8/22.
//

import SwiftUI

struct FeaturedView1: View {
    var namespace: Namespace.ID
    
    @Binding var isFeaturedWidget1Active: Bool
    
    var category: String
    var title: String
    var subtitle: String
    var backgroundImage: String
    var foregroundImage: String
    
    var height: CGFloat
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                VStack {
                    Text("1234o2u03413245")
                        .frame(height: 100)
                    Text("1234o2u03413245")
                        .frame(height: 100)
                    Text("1234o2u03413245")
                        .frame(height: 100)
                    Text("1234o2u03413245")
                        .frame(height: 100)
                }//.padding(.top, 48)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    )
                    .offset(y:125)
                    .padding(20)
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isFeaturedWidget1Active.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(Color("Gray1"))
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .padding(.top, 40)
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
    
    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
            .foregroundStyle(.black)
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
            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            )
            .overlay(
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(category.uppercased())
                            .font(.system(size: 16))
                            .kerning(1.1)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Gray1"))
                            .font(.footnote.weight(.semibold))
                            .matchedGeometryEffect(id: "subtitle", in: namespace)
                            .padding(.bottom, 8)
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
                            .lineLimit(nil)
                            .matchedGeometryEffect(id: "text", in: namespace)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        Divider()
                        HStack {
                            Image("Athleisure LA")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .cornerRadius(16)
                                .padding(8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(style: StrokeStyle(lineWidth: 0.5)))
                            Text("Athleisure LA")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Dark1"))
                            Spacer()
                        }
                    }.padding()
                        .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .matchedGeometryEffect(id: "blur", in: namespace)
                    )
                    .offset(y:250)
                    .padding(20)
                }
            )
        }
}

struct FeaturedView1_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        FeaturedView1(namespace: namespace, isFeaturedWidget1Active: .constant(true), category: "Discover", title: "Athleisure's Design Inspiration", subtitle: "After 24 years, how does Athleisure keep reinventing their brand and their iconic look?", backgroundImage: "YellowAthleisure", foregroundImage: "FeaturedAthleisure", height: 800)
    }
}
