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


struct ContentView: View {
    
    //Add a state var here if it needs to be readable and passed across all screens. Otherwise not necessary. For example, a live workout in the Liftin' app is accessible anywhere
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var email: String = ""
    @State private var isPresentingSheet = false
    
    //This causes an alert when non null
    @State private var alertItem: AlertItem? = nil
    
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Auth with email").padding(.bottom)
                
                CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "person.circle.fill")
                
                CustomStyledButton(title: "Send Sign In Link", action: sendSignInLink).disabled(email.isEmpty)

                Spacer()
                
            }.padding()
                .navigationBarTitle("Passwordless Login")
        }
        .onOpenURL { url in
            let link = url.absoluteString
            
            if Auth.auth().isSignIn(withEmailLink: link) {
                passwordlessSignIn(email: email, link: link) { result in
                    switch result {
                    case let .success(user):
                        isPresentingSheet = user?.isEmailVerified ?? false
                    case let .failure(error):
                        isPresentingSheet = false
                        alertItem = AlertItem(title: "An auth error occurred.", message: error.localizedDescription)
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingSheet) {
            LoginSuccessView(email: email)
        }
        
        .alert(item: $alertItem) { alert -> Alert in    // *
            Alert(
              title: Text(alert.title),
              message: Text(alert.message)
            )
          }
    }
    
    
    private func passwordlessSignIn(email: String, link: String,
                                      completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, link: link) { result, error in
          if let error = error {
            print("ⓧ Authentication error: \(error.localizedDescription).")
            completion(.failure(error))
          } else {
            print("✔ Authentication was successful.")
            completion(.success(result?.user))
          }
        }
      }
    
    
    private func sendSignInLink() {
       let actionCodeSettings = ActionCodeSettings()
       actionCodeSettings.url = URL(string: "https://uncommonloyalty.page.link/open")
       actionCodeSettings.handleCodeInApp = true
       actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

       Auth.auth().sendSignInLink(toEmail: email,
                                  actionCodeSettings: actionCodeSettings) { error in   // 2
         if let error = error {
           alertItem = AlertItem(
             title: "The sign in link could not be sent.",
             message: error.localizedDescription
           )
         }
       }
     }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct AlertItem: Identifiable {    // *
  var id = UUID()
  var title: String
  var message: String
}

struct CustomStyledTextField: View {
  @Binding var text: String
  let placeholder: String
  let symbolName: String

  var body: some View {
    HStack {
      Image(systemName: symbolName)
        .imageScale(.large)
        .padding(.leading)

      TextField(placeholder, text: $text)
        .padding(.vertical)
        .accentColor(.orange)
        .autocapitalization(.none)
    }
    .background(
      RoundedRectangle(cornerRadius: 16.0, style: .circular)
        .foregroundColor(Color(.secondarySystemFill))
    )
  }
}

/// A custom styled button with a custom title and action.
struct CustomStyledButton: View {
  let title: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      /// Embed in an HStack to display a wide button with centered text.
      HStack {
        Spacer()
        Text(title)
          .padding()
          .accentColor(.white)
        Spacer()
      }
    }
    .background(Color.orange)
    .cornerRadius(16.0)
  }
}


//VStack {
//            if viewModel.signedIn {
//                Home()
//
//            } else {
//                LoginView()
//            }
//        }.preferredColorScheme(.light)
////        }.navigationTitle("")
////            .navigationBarHidden(true)
//        .onAppear {
//            viewModel.signedIn = viewModel.isSignedIn
//            print("the sign in state is...  \(String(viewModel.isSignedIn))")
////            AuthStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
////                if user == nil {
////                    //we are not signed in
////                    print("not signed in yet")
////
////                } else {
////                    //we do have a signed in user
////                }
////            })
//
//        }
