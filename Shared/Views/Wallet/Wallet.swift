//
//  Wallet.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct Wallet: View {
    
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                PageHeader(isProfileActive: $isProfileActive, pageTitle: "Wallet")
                
                Text("alsdkfjasf")
                
                Spacer()
                
                MyTabView(selectedTab: $selectedTab)
            }
            
            
            
        }.ignoresSafeArea()
    }
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet(selectedTab: .constant(1))
    }
}
