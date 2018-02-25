//
//  AppDelegate.swift
//  Blotify
//
//  Created by Dulio Denis on 2/24/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var auth = SPTAuth()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        auth.redirectURL = URL(string: "Blocify://returnAfterLogin")
        auth.sessionUserDefaultsKey = "current session"
        
        return true
    }
    
    // Called when user signs in to Spotify.
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                if error != nil { print("Error Handling Auth Callback.") }
                
                let userDefaults = UserDefaults.standard
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
                
                userDefaults.set(sessionData, forKey: "SpotifySession")
                userDefaults.synchronize()
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
            })
            return true
        }
        return false
    }
    
}

