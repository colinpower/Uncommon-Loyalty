//
//  PollAllOptionsUnselected.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct PollAllOptionsUnselected: View {
    
    @Binding var userChoseOption:Int
    
    @Binding var arrayOfNumberOfResponsesForEachOption:[Int]
    
    var arrayOfTitlesForEachOption:[String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            
            ForEach(0..<arrayOfTitlesForEachOption.count) { index in

                PollOptionUnselected(userChoseOption: $userChoseOption, arrayOfNumberOfResponsesForEachOption: $arrayOfNumberOfResponsesForEachOption, title: arrayOfTitlesForEachOption[index], index: index)
                
            }
        }.frame(height: 114)
    }
}
