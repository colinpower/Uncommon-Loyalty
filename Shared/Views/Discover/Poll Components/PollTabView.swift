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
            Text(arrayOfTitlesForEachOption[0]).background(.red)
            Text(arrayOfTitlesForEachOption[1]).background(.red)
            Text(arrayOfTitlesForEachOption[2]).background(.red)
                

        }.frame(height: UIScreen.main.bounds.height/2)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        
    }
}
//
//struct PollTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollTabView()
//    }
//}
