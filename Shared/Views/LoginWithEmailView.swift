////
////  LoginWithEmailView.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 7/20/22.
////
//
//import SwiftUI
//import FirebaseAuth
//
//class AppViewModel: ObservableObject {
//    
//    
//    let auth = Auth.auth()
//    
//    @Published var signedIn = false
//
//    
//    var isSignedIn: Bool {
//        return auth.currentUser != nil
//    }
//    
//    func signOut() {
//        try? auth.signOut()
//        self.signedIn = false
//    }
//    
////    func signIn(email: String, password: String) {
////        auth.signIn(withEmail: email, password: password) { [weak self]
////            result, error in
////            guard result != nil, error == nil else {
////                return
////            }
////            DispatchQueue.main.async {
////                //Success
////                self?.signedIn = true
////            }
////
////        }
////    }
//    
//    func signInWithEmailLink(email: String, link: String) {
//        print("HERE... email is \(email) and link is \(link)")
//        print(UserDefaults.standard.value(forKey: "Link") as? String ?? "")
//        Auth.auth().signIn(withEmail: email, link: link as? String ?? "") { (result, err) in
//            guard result != nil, err == nil else {
//                print(err?.localizedDescription)
//                return
//            }
//
//            DispatchQueue.main.async {
//                //Success
//                self.signedIn = true
//                print("signed IN!!!")
//                //self.navigationController!.popViewController(animated: true)
//            }
//        }
//    }
//    
//    
////    func signInWithEmail(email: String, completion: @escaping (Bool) -> Void) {
////
////        let actionCodeSettings = ActionCodeSettings()
////        actionCodeSettings.url = URL(string: "https://uncommonloyalty.page.link")
////        actionCodeSettings.handleCodeInApp = true
////        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
////
////        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { (error) in
////            if let error = error {
////                print(error.localizedDescription)
////                completion(false)
////                return
////            }
////
////            UserDefaults.standard.set(email, forKey: "Email")
////
////            completion(true)
////        }
////    }
//
//}
//
//
//
//struct LoginWithEmailView: View {
//    @State private var email = ""
//    
//    @State private var signInButtonEnabled = false
//    
//    
//    @EnvironmentObject var viewModel: AppViewModel
//    
//    var link: String!
//    
//    
//    var body: some View {
//        VStack {
//            TextField("Email Address", text: $email)
//                .padding()
//            
//            Button {
//                guard !email.isEmpty else {
//                    return
//                }
//                
//                let actionCodeSettings = ActionCodeSettings()
//                //actionCodeSettings.url = URL(string: "https://uncommon-loyalty.firebaseapp.com/login?email=\(email)")
//                actionCodeSettings.handleCodeInApp = true
//                actionCodeSettings.url = URL(string: String(format: "https://uncommonloyalty.page.link/?email=%@", self.email))
//                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
//                
//                Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    }
//                    
//                    print("the url being sent is \(actionCodeSettings.url) and the email is \(email)")
//                    
//                    UserDefaults.standard.set(email, forKey: "Email")
//                    print("we just set the userdefaults to include \(UserDefaults.standard.string(forKey: "Email"))")
//                    
//                    print("check your email for the link")
//                }
//
//            } label: {
//                Text("Get magic link")
//                    .frame(width: 200, height: 50, alignment: .center)
//                    .cornerRadius(8)
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//            }.padding(.bottom, 30)
//            
//            Button {
//                guard !email.isEmpty else {
//                    return
//                }
//                
//                viewModel.signInWithEmailLink(email: email, link: self.link) //replaced "self.link" for this... UserDefaults.standard.value(forKey: "Link") as? String ?? "")
//                
//
//                } label: {
//                Text("Sign in")
//                    .frame(width: 200, height: 50, alignment: .center)
//                    .cornerRadius(8)
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                }.disabled(!signInButtonEnabled)
//
//        }.onAppear {
//            self.email = UserDefaults.standard.value(forKey: "Email") as? String ?? ""
//            if let link = UserDefaults.standard.value(forKey: "Link") as? String {
//                  self.signInButtonEnabled = true
//            }
//        }
//    }
//}
//
//struct LoginWithEmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginWithEmailView()
//    }
//}
