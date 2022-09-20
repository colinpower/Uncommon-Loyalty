//
//  ContentView.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

//create onboarding flow
//https://www.youtube.com/watch?v=cpg7f4pVzFw

//passwordless auth with swiftui
//https://medium.com/firebase-developers/using-firebase-auths-email-link-login-with-swiftui-dd2462412163

//environnment variable for tracking auth status
//https://stackoverflow.com/questions/67067007/how-do-i-refresh-view-in-swiftui

//phone auth walkthrough
//https://www.youtube.com/watch?v=P4avA9K9r1U


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var viewModel_Users = UsersViewModel()
    
    //Add state var if it needs to be readable and passed across all screens. For example, a live workout in the Liftin' app is accessible anywhere
    @State var selectedTab:Int = 0
    
    //Can I move these variables to the Login view instead?
    @State private var email: String = ""
    @State private var alertItem: AlertItem? = nil
    @State var isShowingCheckEmailView: Bool = false
    
    
    var body: some View {
        VStack {
            if viewModel.signedIn {
                
                switch selectedTab {
                case 0:
                    Home(selectedTab: $selectedTab)
                    
                case 1:
                    Influence(selectedTab: $selectedTab)
                    //AllOrders(selectedTab: $selectedTab)
                case 2:
                    Discover(selectedTab: $selectedTab)
                    //Home(selectedTab: $selectedTab)
                case 3:
                    Profile(selectedTab: $selectedTab)
                default:
                    Home(selectedTab: $selectedTab)
                }

            } else {
                //MARK: TESTING ONLY - MUST DELETE WHEN SHIPPING
                LoginView(email: $email, alertItem: $alertItem, isShowingCheckEmailView: $isShowingCheckEmailView)
                //LoginViewTesting()
            }
        }
        .onAppear {
            //UNCOMMENT THIS LINE WHEN SUBMITTING!
            viewModel.signedIn = viewModel.isSignedIn
        }
        .onOpenURL { url in
            let link = url.absoluteString
            
            if Auth.auth().isSignIn(withEmailLink: link) {
                viewModel.passwordlessSignIn(email: email, link: link) { result in
                    switch result {
                    
                    case let .success(user):
                        viewModel.signedIn = user?.isEmailVerified ?? false //viewModel.isSignedIn
                        isShowingCheckEmailView = false
                    case let .failure(error):
                        alertItem = AlertItem(title: "An auth error occurred.", message: error.localizedDescription)
                    }
                }
            }
        }
        .alert(item: $alertItem) { alert -> Alert in
            Alert(
              title: Text(alert.title),
              message: Text(alert.message)
            )
          }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//NOTE TO SELF:
//https://www.youtube.com/watch?v=qY1oJvtaEYA
//good tutorial on userdefaults vs. appstorage
