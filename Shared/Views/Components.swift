//
//  Components.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 8/4/22.
//

import SwiftUI
import Foundation

struct SheetHeader: View {
    
    var title: String
    var color:Color? = Color("Dark1")
    
    @Binding var isActive: Bool

    
    var body: some View {
        HStack (alignment: .center) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(color)
                //.foregroundColor(color == nil ? Color("Dark1") : color)
            Spacer()
            Button {
                isActive.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(color)
                //    .foregroundColor(color == nil ? Color("Dark1") : color)
                    .font(Font.system(size: 20, weight: .semibold))
            }
        }.padding(.top, 48)
        .padding()
    }
}


struct WidgetSolo: View {
    
    var image: String
    var size: Int? = 48
    var firstLine: String
    var secondLine: String
    var secondLineColor: Color? = Color("Gray2")
    var buttonTitle: String? = ""
    
    @Binding var isActive: Bool
    
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            HStack {
                Image(systemName: image)
                    .foregroundColor(Color("ThemePrimary"))
                    .font(.system(size: CGFloat(size!)))
                VStack(alignment: .leading, spacing: 3) {
                    Text(firstLine)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text(secondLine)
                        .font(secondLineColor! == Color("Gray2") ? .system(size: 16) : .system(size: 14))
                        .fontWeight(secondLineColor! == Color("Gray2") ? .regular : .semibold)
                        .foregroundColor(secondLineColor)
                }
                Spacer()
                if !buttonTitle!.isEmpty {
                    Text(buttonTitle!)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(Color("Background")))

                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("Gray3"))
                        .font(Font.system(size: 15, weight: .semibold))
                }
            }.padding(.horizontal, 12)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        }
        .padding(.horizontal)
    }
}



struct RewardsProgramWidget: View {

    var image: String
    var company: String
    var status: String
    var currentPointsBalance: Int
    
    var body: some View {

        HStack (alignment: .center) {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38, alignment: .center)
                .clipped()
                .cornerRadius(12)
                .padding(.trailing, 6)
//                Image(systemName: "person.crop.circle")
//                    .foregroundColor(.black)
//                    .font(.system(size: 30))
            
            VStack(alignment: .leading) {
                Text(company)
                    .foregroundColor(Color("Dark1"))
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                if status != "None" {
                    //Text(status)
                    Text("GOLD")
                        //.kerning(1.8)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Gray1"))
                }
            }
//            Text("Gold")
//                .font(.system(size: 14))
//                .fontWeight(.semibold)
//                //.foregroundColor(Color("Dark1"))
//                .foregroundColor(Color("Gold1"))
//                .padding(.vertical, 6)
//                .padding(.horizontal, 12)
//                .background(RoundedRectangle(cornerRadius: 22)
//                    //.foregroundColor(Color("Background")))
//                    .foregroundColor(Color("Gold2")))
//                .padding(.leading, 6)
            
            Spacer()
            
            Text(String(currentPointsBalance))
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("Dark1"))
//                .padding(.vertical, 10)
//                .padding(.horizontal, 16)
//                .background(RoundedRectangle(cornerRadius: 22)
//                    //.foregroundColor(Color("Background")))
//                    .foregroundColor(Color("Gold2")))
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
                .padding(.leading, 3)
            
        }.padding(.top)
    }
}

struct WideWidgetHeader: View {

    var title: String
    
    var body: some View {

        HStack {
            Text(title).kerning(1.2)
                .font(.system(size: 13))
                .fontWeight(.medium)
                .foregroundColor(Color("Gray1"))
            Spacer()
        }.padding(.horizontal).padding(.top).padding(.top)
    }
}

struct WideWidgetItem: View {

    var image: String
    var size: Int
    var color: Color? = Color("ThemePrimary")
    var title: String
    var subtitle: String? = ""
    
    var body: some View {

        HStack(alignment: .center) {
            Image(systemName: image)
                .foregroundColor(color)
                .font(.system(size: CGFloat(size)))
                .frame(width: CGFloat(size*9/5))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark1"))
                if !subtitle!.isEmpty {
                    Text(subtitle!)
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Gray2"))
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color("Gray3"))
                .font(Font.system(size: 15, weight: .semibold))
        }
    }
}


struct PromptCard: View {

    var image:String
    var title:String
    var points:Int
    var text: String
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            //Top part / header
            HStack {
                Image(systemName: image)
                    .foregroundColor(Color("Dark1"))
                    .font(Font.system(size: 32, weight: .semibold))
                    .padding(.trailing, 3)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Dark1"))
                    Text("+" + String(points))
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Dark2"))
                }
            }.padding(.bottom)
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color("Dark1"))
                .frame(maxWidth: width-32)
                .lineLimit(3)
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
            .frame(width: width, height: 160)
    }
}