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
import Combine

//
class UserObject {
    var uid: String
    var email: String?

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}


class AppViewModel: ObservableObject {
    
    @Published var signedIn = false

    let auth = Auth.auth()
    
    //do I need to do guard let here??
    let email = Auth.auth().currentUser?.email
    
    let userID = Auth.auth().currentUser?.uid
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    @Published var currentUser: Users?
    
    
    var didChange = PassthroughSubject<AppViewModel, Never>()
    @Published var session: UserObject? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    //need to remove the listener so you're not constantly listening
    func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    
    
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth1, user1) in
            if let user1 = user1 {
                // if we have a user, create a new user model
                
                print("we have a session.. setting it to UserObject of the current user")
                print("Got user: \(user1)")
                
                print(String(user1.uid))
                print(user1.email ?? "")
                
                self.session = UserObject(
                    uid: user1.uid,
                    email: user1.email
                )
                
                print("printing the UserObject which is self.session")
                print(self.session)
                
                
            } else {
                print("we don't have a session.. setting it to nil")
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
//    func listen() {
//        Auth.auth().addStateDidChangeListener { auth, user1 in
//            if let user1 = user1 {
//                print("CALLED THE LISTENER!!")
//                print("\(user1.uid) login")
//                self.signedIn = user1.isEmailVerified
//                //self.isShowingCheckEmailView = false
//
//            } else {
//
//                print("CALLED THE LISTENER BUT HIT AN ERROR!!")
//
//                print("not login")
//            }
//        }
//    }
    

    func passwordlessSignIn(email1: String, link1: String,
                                      completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email1, link: link1) { result1, error1 in
          if let error1 = error1 {
            print("Authentication error: \(error1.localizedDescription).")
            completion(.failure(error1))
          } else {
            print(result1?.user.uid)
            print("Authentication was successful.")
            completion(.success(result1?.user))
          }
        }
      }
    
    //MARK: TESTING ONLY - MUST DELETE WHEN SHIPPING
    //COMMENT THIS FUNCTION.. ONLY FOR TESTING
//    func signIn(email: String, password: String) {
//            auth.signIn(withEmail: email, password: password) { [weak self]
//                result, error in
//                guard result != nil, error == nil else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    //Success
//                    self?.signedIn = true
//                }
//
//            }
//        }
    
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.signedIn = false
            self.session = nil
            
            return true
            
        } catch {
            
            return false
            
        }
        
    }
    
}



struct LoginView: View {
    
    //@EnvironmentObject var viewModel: AppViewModel
    
    @Binding var email: String
    @Binding var alertItem: AlertItem?
    
    @Binding var isShowingCheckEmailView: Bool
    
    
    
    
    var body: some View {
        if isShowingCheckEmailView {
            CheckYourEmail(isShowingCheckEmailView: $isShowingCheckEmailView, email: $email)
                .onDisappear{
                    isShowingCheckEmailView = false
                    email = ""
                }
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
                    Text("You are influential. Get rewarded!")
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
                VStack (alignment: .leading, spacing: 8) {
                    Text("ENTER YOUR EMAIL ADDRESS")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    TextField("", text: $email)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.white)
                        .frame(height: 48)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(red: 98/255, green: 123/255, blue: 253/255)))
                        .onSubmit {
                            sendSignInLink()
                            withAnimation {
                                isShowingCheckEmailView = true
                            }
                        }
                        .submitLabel(.done)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .padding(.bottom, 8)
                    
                    Button {
                        sendSignInLink()
                        isShowingCheckEmailView = true
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Continue")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(email.isEmpty ? Color(.lightGray) : Color("bg"))
                                .frame(height: 48)
                            Spacer()
                        }.background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.white))
                        
                    }.disabled(email.isEmpty)
                        .fullScreenCover(isPresented: $isShowingCheckEmailView) {
                            CheckYourEmail(isShowingCheckEmailView: $isShowingCheckEmailView, email: $email)
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
            }.padding(.horizontal)
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





