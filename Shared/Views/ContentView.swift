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
    
    @ObservedObject var usersViewModel = UsersViewModel()
    
    @AppStorage("shouldShowFirstRunExperience")
    private var shouldShowFirstRunExperience: Bool = true
    
    @AppStorage("hasEnteredNameAndPhone")
    private var hasEnteredNameAndPhone: Bool = false
    
    //Add state var if it needs to be readable and passed across all screens. For example, a live workout in the Liftin' app is accessible anywhere
    @State var selectedTab:Int = 0
    
    //Can I move these variables to the Login view instead?
    @State private var email: String = ""
    @State private var alertItem: AlertItem? = nil
    @State var isShowingCheckEmailView: Bool = false
    
    func getUser () {
        
        viewModel.listen()
        
      }
    
    
    var body: some View {
        
        
        Group {
            
            let currentSessionUID = viewModel.session?.uid ?? ""
            let currentSessionEmail = viewModel.session?.email ?? ""
            
            if (currentSessionUID != "" && currentSessionEmail != "") {
            
                if (!hasEnteredNameAndPhone) {
                    
                    FREGetName(email: currentSessionEmail, userID: currentSessionUID, hasEnteredNameAndPhone: $hasEnteredNameAndPhone)
                    
                } else {
                    
                    switch selectedTab {
                    case 0:
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Purchases(selectedTab: $selectedTab) //, email: viewModel.email!, userID: viewModel.userID!)
                        }
                        .fullScreenCover(isPresented: $shouldShowFirstRunExperience, content: {
                            FirstRunExperience(shouldShowFirstRunExperience: $shouldShowFirstRunExperience)
                        })
                        
                    case 1:
                        ReferralTracker(selectedTab: $selectedTab)
                    case 2:
                        Rewards(selectedTab: $selectedTab)
                    case 3:
                        Profile(selectedTab: $selectedTab)
                    default:
                        Profile(selectedTab: $selectedTab)
                    }
                }

            } else {
                
                LoginView(email: $email, alertItem: $alertItem, isShowingCheckEmailView: $isShowingCheckEmailView)
                
            }
        }
        .onAppear {
            
            viewModel.listen()
            
            //usersViewModel.listenForOneUser(userID: viewModel.session?.uid ?? "")
            
        }
        .onOpenURL { url in
            let link = url.absoluteString
            
            if Auth.auth().isSignIn(withEmailLink: link) {
                viewModel.passwordlessSignIn(email1: email, link1: link) { result in
                    switch result {
                    
                        
                    case let .success(user):
                        print("inside the switch statement ")
                        print("successful !! but now starting the listener")
                        viewModel.listen()
                        
//                        Auth.auth().addStateDidChangeListener { auth, user1 in
//                           if let user1 = user1 {
//                               print("\(user1.uid) login")
//                               viewModel.signedIn = user1.isEmailVerified
//                               isShowingCheckEmailView = false
//
//                           } else {
//                               print("not login")
//                           }
//                        }
                        
                    case let .failure(error):
                        print("inside the switch statement ")
                        print("error")
                        
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




//NOTE TO SELF:
//https://www.youtube.com/watch?v=qY1oJvtaEYA
//good tutorial on userdefaults vs. appstorage
