//
//  ContentView.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI


struct ContentView: View {
    
    //Add a state var here if it needs to be readable and passed across all screens. Otherwise not necessary. For example, a live workout in the Liftin' app is accessible anywhere
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
      }
    
    //Use this var to determine which tab is default
    @State private var defaultTab = 1
    
    var body: some View {
        TabView(selection: $defaultTab) {
            Home()
                .tabItem {
                    Image(systemName: "house")
                        .renderingMode(.template)
                    Text("Home")
                }.tag(1)
            Feed()
                .tabItem {
                    Image(systemName: "newspaper")
                        .renderingMode(.template)
                    Text("Feed")
                }.tag(2)
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                        .renderingMode(.template)
                    Text("Profile")
                }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
