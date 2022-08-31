//
//  TEMPTabview.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/31/22.
//

import SwiftUI

struct TEMPTabview: View {
    
    @Binding var isShowingTempTabView: Bool
    
    var body: some View {
        TabView {
            Text("page 1")
            Text("page 2")
        }//.frame(height: UIScreen.main.bounds.height/2)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct TEMPTabview_Previews: PreviewProvider {
    static var previews: some View {
        TEMPTabview(isShowingTempTabView: .constant(true))
    }
}
