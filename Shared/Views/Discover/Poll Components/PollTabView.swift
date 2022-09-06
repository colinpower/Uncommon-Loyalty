//
//  PollTabView.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct PollTabView: View {
    
    @Binding var arrayOfImagesForEachOption:[String]
    @Binding var arrayOfTitlesForEachOption:[String]
    
    var body: some View {
        
        TabView {
            
            ForEach(0..<arrayOfTitlesForEachOption.count) { index in
                
                PollImageView(title: arrayOfTitlesForEachOption[index], image: arrayOfImagesForEachOption[index], index: index)
                    .padding(.horizontal, UIScreen.main.bounds.width / 3)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3+30, alignment: .center)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
    }
}



struct PollImageView: View {
    
    var title:String
    var image:String
    var index:Int
        
    var icon:String {
        switch index {
        case 0:
            return "01.circle"
        case 1:
            return "02.circle"
        case 2:
            return "03.circle"
        default:
            return "01.circle"
        }
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.height/3 - 30, height: UIScreen.main.bounds.height/3 - 30)
                    .shadow(color: .black.opacity(0.4), radius: 15, x: 0, y: 0)
                    
                Image("redshorts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height/3 - 30, height: UIScreen.main.bounds.height/3 - 30)
                
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.top).padding(.leading)
            }
            Spacer()
        }.padding(.all, 15)
        .frame(width: UIScreen.main.bounds.height/3, height: UIScreen.main.bounds.height/3)
    }
}
