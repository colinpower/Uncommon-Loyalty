//
//  PollOptionUnselected.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct PollOptionUnselected: View {
    
    @Binding var userChoseOption: Int
    @Binding var arrayOfNumberOfResponsesForEachOption:[Int]
    
    var title:String
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
        HStack(alignment: .center, spacing: 12) {
            Button {
                
                arrayOfNumberOfResponsesForEachOption[index] += 1
                userChoseOption = index
                
                
            } label : {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            Text(title)
                .font(.system(size: 20, weight: .regular))
                .padding(.vertical, 2)
            Spacer()
        }.frame(height: 30)
    }
}

