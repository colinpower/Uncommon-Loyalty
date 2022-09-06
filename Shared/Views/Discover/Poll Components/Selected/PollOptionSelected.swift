//
//  PollOptionSelected.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct PollOptionSelected: View {
    
    var numberOfVotes:Int
    
    var totalNumberOfVotes: Int
    
    var title:String
    
    var userSelectedThisOption: Bool
    
    
    var body: some View {
        
        
        
            
        if userSelectedThisOption {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                ZStack(alignment: .leading) {
                    Capsule().frame(width: (UIScreen.main.bounds.width/2), height: CGFloat(15))
                    .foregroundColor(.gray)
                    //check if the total array is 0
                    Capsule().frame(width: CGFloat(Double(numberOfVotes) / Double(totalNumberOfVotes) * Double(UIScreen.main.bounds.width) / Double(2)), height: CGFloat(15))
                        .foregroundColor(.blue)
                }
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }.frame(height: 40)
        } else {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                ZStack(alignment: .leading) {
                    Capsule().frame(width: (UIScreen.main.bounds.width/2), height: CGFloat(15))
                        .foregroundColor(.gray)
                    Capsule().frame(width: CGFloat(Double(numberOfVotes) / Double(totalNumberOfVotes) * Double(UIScreen.main.bounds.width) / Double(2)), height: CGFloat(15))
                        .foregroundColor(.black)
                }
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }.frame(height: 40)
        }
    }
}

