//
//  ContentView.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth

//create onboarding flow
//https://www.youtube.com/watch?v=cpg7f4pVzFw


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    //Add a state var here if it needs to be readable and passed across all screens. Otherwise not necessary. For example, a live workout in the Liftin' app is accessible anywhere
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
      }
    
    //Use this var to determine which tab is default
    @State var selectedTab: Int = 1
    
    var body: some View {
        VStack {
            if viewModel.signedIn {
                Home()
                
            } else {
                LoginView()
            }
        }.preferredColorScheme(.light)
//        }.navigationTitle("")
//            .navigationBarHidden(true)
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
            print("the sign in state is...  \(String(viewModel.isSignedIn))")
//            AuthStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
//                if user == nil {
//                    //we are not signed in
//                    print("not signed in yet")
//
//                } else {
//                    //we do have a signed in user
//                }
//            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
