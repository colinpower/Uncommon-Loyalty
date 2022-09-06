//
//  Discover.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/24/22.
//

import SwiftUI

struct Discover: View {
    
    @Binding var selectedTab:Int
    @State var isProfileActive:Bool = false
    
    @State var isShowingDetailView = false
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                WideWidgetHeader(title: "HELP US IMPROVE")
                    
                NavigationLink(destination: SuggestAShopPreview(isShowingDetailView: $isShowingDetailView).navigationBarTitle("", displayMode: .inline).navigationBarHidden(true), isActive: $isShowingDetailView) {
                    WideWidgetItem(image: "lightbulb.circle.fill", size: 40, title: "Suggestions", subtitle: "What should we work on next?")
                }
                
                
                Text("alsdkfjasf")
                
                Spacer()
                MyTabView(selectedTab: $selectedTab)
            }
            .background(.white)
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationTitle("Discover").font(.title)
            .onAppear {
                // stuff goes here
            }

        }
    }
}

struct Discover_Previews: PreviewProvider {
    static var previews: some View {
        Discover(selectedTab: .constant(2))
    }
}
