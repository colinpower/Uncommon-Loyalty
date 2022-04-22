//
//  LoginView.swift
//  Uncommon Loyalty
//
//  Created by Colin Power on 4/4/22.
//
//how I did auth
//https://www.youtube.com/watch?v=vPCEIPL0U_k&t=626s


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
