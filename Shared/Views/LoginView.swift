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




//if i decide to do email / pw / verification email
//https://www.youtube.com/watch?v=UZ9s_20Hk3U


import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    
    let auth = Auth.auth()
    
    @Published var signedIn = false

    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
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
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            guard result != nil, error == nil else {
                print(error)
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
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        VStack {
            Image(systemName: "pencil.circle")
                .font(.system(size: 150))
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text("Sign In")
                        .frame(width: 200, height: 50, alignment: .center)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                }
                
                NavigationLink("Create account", destination: SignUpView())

            }
        }
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        VStack {
            Image(systemName: "pencil.circle")
                .font(.system(size: 150))
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                
                Button {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                } label: {
                    Text("Create Account")
                        .frame(width: 200, height: 50, alignment: .center)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                }

            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
