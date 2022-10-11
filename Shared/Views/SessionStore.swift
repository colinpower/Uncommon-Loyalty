////
////  SessionStore.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 10/4/22.
////
//
//import Foundation
//import SwiftUI
//import FirebaseAuth
//import Combine
//
//class SessionStore : ObservableObject {
//    var didChange = PassthroughSubject<SessionStore, Never>()
//    var session: User? { didSet { self.didChange.send(self) }}
//    var handle: AuthStateDidChangeListenerHandle?
//
//    func listen () {
//        // monitor authentication changes using firebase
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            if let user = user {
//                // if we have a user, create a new user model
//                print("Got user: \(user)")
//                self.session = User(
//                    uid: user.uid,
//                    email: user.email
//                )
//            } else {
//                // if we don't have a user, set our session to nil
//                self.session = nil
//            }
//        }
//    }
//
//    // additional methods (sign up, sign in) will go here
//
//    func signUp(
//         email: String,
//         password: String,
//         handler: @escaping
//         ) {
//         Auth.auth().createUser(withEmail: email, password: password, completion: handler)
//     }
//
//     func signIn(
//         email: String,
//         password: String,
//         handler: @escaping AuthDataResult
//         ) {
//         Auth.auth().signIn(withEmail: email, password: password, completion: handler)
//     }
//
//     func signOut () -> Bool {
//         do {
//             try Auth.auth().signOut()
//             self.session = nil
//             return true
//         } catch {
//             return false
//         }
//     }
//
//    func unbind () {
//            if let handle = handle {
//                Auth.auth().removeStateDidChangeListener(handle)
//            }
//        }
//
//
//}
//
//
//
//
//class User {
//    var uid: String
//    var email: String?
//
//    init(uid: String, email: String?) {
//        self.uid = uid
//        self.email = email
//    }
//
//}
