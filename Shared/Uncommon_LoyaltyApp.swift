//
//  Uncommon_LoyaltyApp.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

import SwiftUI
import Firebase

// handling notification deeplinking
//https://stackoverflow.com/questions/68144739/how-can-i-deep-link-from-a-notification-to-a-screen-in-swiftui

//for implementing crashlytics.. need to force a crash. then it should be sent to Firebase
//https://www.youtube.com/watch?v=l-iN0kY_bmg

final class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    return true
  }
}

@main
struct Uncommon_LoyaltyApp: App {
    
    //need this line here to handle push notifications or other
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
