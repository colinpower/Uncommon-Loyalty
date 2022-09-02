//
//  AboutCompany.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/2/22.
//

import SwiftUI

struct AboutCompany: View {
    var body: some View {
        VStack(spacing: 0) {
            
//            ZStack(alignment: .top) {
//                Image("BlueGoldenRatio")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
//                    .layoutPriority(-1)
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .red.opacity(0.4)]), startPoint: .top, endPoint: .bottom))
//                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
//            }.padding(.horizontal)
//                .shadow(color: .gray, radius: 10, x: 0, y: 0)
            
            Image("BlueGoldenRatio")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
                .layoutPriority(-1)
                .padding(.horizontal)
                .shadow(color: .gray, radius: 10, x: 0, y: 0)
            
            
            
            
            
            
            //.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width / 1.6)
                
            
            
//            ZStack(alignment: .bottomLeading) {
//                Color.white
//                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
//                    .mask(Image("AthleisureFounder")
//                        .resizable()
//                        .scaledToFit()
//                        ).frame(width: UIScreen.main.bounds.width).cornerRadius(15)
                
//                Image("AthleisureFounder")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: UIScreen.main.bounds.width)
//                    .overlay {
//                        LinearGradient(colors: <#T##[Color]#>, startPoint: <#T##UnitPoint#>, endPoint: <#T##UnitPoint#>)
//                    }
//                HStack(alignment: .bottom) {
//                    ZStack(alignment: .center) {
//                        Rectangle().foregroundColor(.white)
//                        Image("Athleisure LA")
//                            .resizable()
//                            .scaledToFit()
//                    }.frame(width: 60, height: 60)
//                    .cornerRadius(16)
//                    .padding(.trailing)
//
//                    Text("Athleisure LA")
//                        .font(.system(size: 32, weight: .bold))
//                        .foregroundColor(Color.white)
//
//                    Spacer()
//
//                }.padding()
//                .background(.ultraThinMaterial)
//            }
            
            Spacer()
            
            
            
            
            
        }.ignoresSafeArea()
        
        
        
    
    }
}

//struct AboutCompany_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutCompany()
//    }
//}
