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
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Button {
                
                arrayOfNumberOfResponsesForEachOption[index] += 1
                userChoseOption = index
                
                
            } label : {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
            }
            Text(title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }.frame(height: 40)
    }
}

