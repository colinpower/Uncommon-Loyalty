//
//  VoteWidget.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 3/18/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct VoteWidget: View {
    
    @State var url = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image("SwanSkincare")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.trailing, 12)
                VStack(alignment: .leading) {
                    Text("Swan Skincare")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                    Text("15 min ago")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                Text("Gold exclusive")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.blue)
                    .padding(.all, 6)
                    .background(RoundedRectangle(cornerRadius: 6).fill(.blue.opacity(0.2)))
            }.padding(.bottom, 4)
            Text("We're thinking about making a new travel-sized face wash! Would you be interested?")
                .font(.body)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
                .padding(.bottom, 4)
            HStack {
                Spacer()
                Text("Yes")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.blue)
                Spacer()
            }.padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 6).stroke(Color.blue))
            HStack {
                Spacer()
                Text("No")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.blue)
                Spacer()
            }.padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 6).stroke(Color.blue))
            .padding(.bottom, 12)
            
            if url != "" {
                WebImage(url: URL(string: url)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300, alignment: .center)
                    .clipped()
                    .cornerRadius(50)
                    .padding(.bottom, 2)
            }
//
//            Image("AthleisureSweatpants")
//                .resizable()
//                .scaledToFill()
//                .clipped()
//                .cornerRadius(10)
//                .padding(.bottom, 2)

            HStack{
                Image(systemName: "message")
                    .font(.body)
                Text("40")
                    .font(.body)
                    .padding(.trailing, 12)
                Spacer()
                Text("See comments")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Image(systemName: "arrow.right")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            
            
        }.padding(.horizontal, 12)
        .onAppear {
            let storage = Storage.storage().reference()
            storage.child("AthleisureLA.png").downloadURL { (url, err) in
                if err != nil {
                    print(err?.localizedDescription)
                    return
                } else {
                    self.url = "\(url!)"
                }
            }
        }
    }
}

struct VoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        VoteWidget()
    }
}
