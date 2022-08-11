//
//  Uncommon_LoyaltyApp.swift
//  Shared
//
//  Created by Colin Power on 1/17/22.
//

// handling notification deeplinking
//https://stackoverflow.com/questions/68144739/how-can-i-deep-link-from-a-notification-to-a-screen-in-swiftui

//for implementing crashlytics.. need to force a crash. then it should be sent to Firebase
//https://www.youtube.com/watch?v=l-iN0kY_bmg



import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDynamicLinks



final class AppDelegate: NSObject, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        //UIApplication.shared.delegate?.application?(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
}

@main
struct Uncommon_LoyaltyApp: App {
    
    //need this line here to handle push notifications or other
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        let viewModel = AppViewModel()
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
            

        }
    }
}
    





//                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: onWebBrowserActivity)
//                .onOpenURL {
//                    url in
//                    print("incoming URL parameter is \(url)")
//                    let linkHandled = FIRDynamicLinks.dynamicLinks().handleUniversalLink(<#T##NSURL#>, completion: <#T##FIRDynamicLinkUniversalLinkHandler#>)





//    //@available(iOS 9.0, *)
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
//        print("this function OPEN URL OPTIONS KEY was called")
//        print(url)
//        return self.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: "")
//    }
//
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        guard DynamicLinks.dynamicLinks() != nil else {
//            print("failed guard let dynamicLinks")
//            return false
//        }
//        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
//          // handle the error?
//            //code example: https://github.com/TheAshtonaught/FastPlaylistMaker/blob/63e16d28da22e83919406da7bbc62e1f1d922248/Fast%20Playist%20Maker/AppDelegate.swift
//        }
//
//      return handled
//    }
//
//
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        print("this function SOURCEAPPLICATION was called")
//        print(url)
//
//        return true //NSUserActivity?.webpageURL.flatMap(handlePasswordlessSignIn)!
//    }
//
//    func handlePasswordlessSignIn(withUrl url: URL) -> Bool {
//        print("this function HANDLEPASSWORDLESSSIGNIN was called")
//        let link = url.absoluteString
//
//        //now check if we can log in with email and link thru firebase
//        if Auth.auth().isSignIn(withEmailLink: link) {
//
//            print("we tried to see if we can sign in with this link... the link we got is... \(link)")
//
//            UserDefaults.standard.set(link, forKey: "Link")
//
//            //(window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: false)
//            //window?.rootViewController?.children[0].performSegue(withIdentifier: "passwordless", sender: nil)
//            //NavigationLink
//
//            return true
//        }
//        return false
//    }
//
    
    
    

    
    






//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        print("this function CONTINUE USERACTIVITY was called")
//        if let incomingURL = userActivity.webpageURL {
//            print("Incoming URL is \(incomingURL)")
//            let linkHandled = FIRDynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) {
//                (dynamicLink, error) in
//                guard error == nil else {
//                    print("found an error \(error!.localizedDescription)")
//                    return
//                }
//                if let dynamicLink = dynamicLink {
//                    self.handleIncomingDynamicLink(dynamicLink)
//                }
//            }
//            if linkHandled {
//                return true
//            } else {
//                //maybe do other things if you have more dynamic links??
//                return false
//            }
//        }
//    }
    
    
//    func onWebBrowserActivity(_ userActivity: NSUserActivity) {
//        guard let url = userActivity.webpageURL else {
//            return
//        }
//        onOpenURL(url)
//    }
    
//    func onOpenURL(_ url: URL) {
//        let dynamicLinks = DynamicLinks.dynamicLinks()
//        if dynamicLinks.shouldHandleDynamicLink(fromCustomSchemeURL: url),
//           let dynamicLink = dynamicLinks.dynamicLink(fromCustomSchemeURL: url) {
//            handle(dynamicLink: dynamicLink)
//        } else {
//            handleUniversalLink(url: url)
//        }
//    }
