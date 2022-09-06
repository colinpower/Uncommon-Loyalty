//
//  PollAllOptionsSelected.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/5/22.
//

import SwiftUI

struct PollAllOptionsSelected: View {
    
    
    
    var arrayOfNumberOfResponsesForEachOption:[Int]
    @Binding var animatedArray:[Int]
    
    
    var arrayOfTitlesForEachOption:[String]
    
    var userChoseOption:Int
    
    
    
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 12) {
                
                ForEach(0..<arrayOfTitlesForEachOption.count) { index in
                    
                    if userChoseOption == index {
                        PollOptionSelected(numberOfVotes: animatedArray[index], totalNumberOfVotes: arrayOfNumberOfResponsesForEachOption.reduce(0, +), title: arrayOfTitlesForEachOption[index], userSelectedThisOption: true, index: index)
                    } else {
                        PollOptionSelected(numberOfVotes: animatedArray[index], totalNumberOfVotes: arrayOfNumberOfResponsesForEachOption.reduce(0, +), title: arrayOfTitlesForEachOption[index], userSelectedThisOption: false, index: index)
                    }
                    
                }
            
            }.frame(height: CGFloat(arrayOfTitlesForEachOption.count * (30 + 12) - 12))   //each option will be 40 in height, then 12 spacing between [Num of options] - 1
            
        }.onAppear {
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                //withAnimation(.linear(duration: 0.4)) {
                    
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    animatedArray = arrayOfNumberOfResponsesForEachOption
                }
            }
        }
    }
}
