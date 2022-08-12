//
//  LoginView.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//
//how I did auth
//https://www.youtube.com/watch?v=vPCEIPL0U_k&t=626s

//create onboarding experience
//https://www.youtube.com/watch?v=cpg7f4pVzFw

//email verification
//https://firebase.google.com/docs/auth/ios/email-link-auth#verify_link_and_sign_in
//https://firebase.google.com/docs/auth/ios/email-link-auth#swift_2

//helful videos for magic link
//https://www.youtube.com/watch?v=iSC5ed6OowA
//https://www.youtube.com/watch?v=KLBjAg6HvG0
//https://firebase.google.com/docs/auth/ios/passing-state-in-email-actions#configuring_firebase_dynamic_links
//https://github.com/firebase/quickstart-ios/blob/0d895bbe987378546f9fe5d72bb6a751cc9748a4/authentication/LegacyAuthQuickstart/AuthenticationExampleSwift/AppDelegate.swift
//https://github.com/firebase/quickstart-ios/blob/0d895bbe987378546f9fe5d72bb6a751cc9748a4/authentication/LegacyAuthQuickstart/AuthenticationExampleSwift/PasswordlessViewController.swift#L43-L53
//



//https://www.youtube.com/watch?v=7QyybtL9G78
//https://www.youtube.com/watch?v=Bb66vdrS454


//really helpful series from Rebeloper on how to do this
//https://www.youtube.com/watch?v=CXClHeZNlAE&list=PL_csAAO9PQ8aanonTKCoEB7J4YoxPdz2G&index=2



//if i decide to do email / pw / verification email
//https://www.youtube.com/watch?v=UZ9s_20Hk3U


import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    @Published var signedIn = false

    let auth = Auth.auth()
    
    //do I need to do guard let here??
    let email = Auth.auth().currentUser?.email
    
    let userID = Auth.auth().currentUser?.uid
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    
    func passwordlessSignIn(email: String, link: String,
                                      completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, link: link) { result, error in
          if let error = error {
            print("Authentication error: \(error.localizedDescription).")
            completion(.failure(error))
          } else {
            print("Authentication was successful.")
            completion(.success(result?.user))
          }
        }
      }
    
    //MARK: TESTING ONLY - MUST DELETE WHEN SHIPPING
    //COMMENT THIS FUNCTION.. ONLY FOR TESTING
    func signIn(email: String, password: String) {
            auth.signIn(withEmail: email, password: password) { [weak self]
                result, error in
                guard result != nil, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    //Success
                    self?.signedIn = true
                }
                
            }
        }
    
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
}



struct LoginView: View {
    
    //@EnvironmentObject var viewModel: AppViewModel
    
    @Binding var email: String
    @Binding var alertItem: AlertItem?
    
    @Binding var isShowingCheckEmailView: Bool
    
    
    var body: some View {
        if isShowingCheckEmailView {
            CheckYourEmail(isShowingCheckEmailView: $isShowingCheckEmailView)
        } else {
        
            ZStack {
            Color("bg")
            
            VStack(alignment: .leading) {
                
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Text("Uncommon App")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("The easiest way to be loyal!")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                }
                Spacer()
                Spacer()
//                Text("Enter the email you use when you shop.")
//                    .foregroundColor(Color("ThemeLight"))
//                    .font(.system(size: 16))
//                    .fontWeight(.regular)
//                    .lineLimit(2)
//                    .padding(.bottom, 16)
                HStack (alignment: .center) {
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Enter your email", text: $email)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("ThemePrimary"))
                            .frame(height: 60)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                            .onSubmit {
                                sendSignInLink()
                                withAnimation {
                                    isShowingCheckEmailView = true
                                }
                            }
                            .submitLabel(.send)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                    }
                    
                    Button {
                        sendSignInLink()
                        isShowingCheckEmailView = true
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 40, weight: .bold))
                            .padding(.horizontal)
                            .frame(height: 48)
                            .foregroundColor(.white)
                    }.disabled(email.isEmpty)
                        .fullScreenCover(isPresented: $isShowingCheckEmailView) {
                            CheckYourEmail(isShowingCheckEmailView: $isShowingCheckEmailView)
                        }
                }
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Text("(No passwords needed, ever)")
                        .foregroundColor(Color("ThemeLight"))
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                    Spacer()
                }
                Spacer()
            }.padding(.horizontal).padding(.horizontal)
        }.edgesIgnoringSafeArea(.all)
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





