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
        
        
        
            
        if userSelectedThisOption {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                ZStack(alignment: .leading) {
                    Capsule().frame(width: (UIScreen.main.bounds.width/2), height: CGFloat(15))
                    .foregroundColor(.white)
                    //check if the total array is 0
                    Capsule().frame(width: CGFloat(Double(numberOfVotes) / Double(totalNumberOfVotes) * Double(UIScreen.main.bounds.width) / Double(2)), height: CGFloat(15))
                        .foregroundColor(.blue)
                }
                Spacer()
            }.frame(height: 30)
        } else {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                ZStack(alignment: .leading) {
                    Capsule().frame(width: (UIScreen.main.bounds.width/2), height: CGFloat(15))
                        .foregroundColor(.white)
                    Capsule().frame(width: CGFloat(Double(numberOfVotes) / Double(totalNumberOfVotes) * Double(UIScreen.main.bounds.width) / Double(2)), height: CGFloat(15))
                        .foregroundColor(.gray)
                }
                Spacer()
            }.frame(height: 30)
        }
    }
}

