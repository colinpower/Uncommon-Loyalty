//
//  ContentView.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    //Add a state var here if it needs to be readable and passed across all screens. Otherwise not necessary. For example, a live workout in the Liftin' app is accessible anywhere
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
      }
    
    //Use this var to determine which tab is default
    @State private var defaultTab = 1
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
            
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
                    Messages()
                        .tabItem {
                            Image(systemName: "message")
                                .renderingMode(.template)
                            Text("Messages")
                        }.tag(3)
                    Profile()
                        .tabItem {
                            Image(systemName: "person.fill")
                                .renderingMode(.template)
                            Text("Profile")
                        }.tag(4)
                }
            } else {
                LoginView()
            }
        }.navigationTitle("")
            .navigationBarHidden(true)
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
