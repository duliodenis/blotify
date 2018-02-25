//
//  SignInController.swift
//  Blotify
//
//  Created by Dulio Denis on 2/25/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class SignInController: UIViewController {

    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginURL: URL?
    
    func setupSpotify() {
        SPTAuth.defaultInstance().clientID = "YOUR_SPOTIFY_CLIENT_ID"
        SPTAuth.defaultInstance().redirectURL = URL(string: "Blocify://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope,
                                                     SPTAuthPlaylistReadPrivateScope,
                                                     SPTAuthPlaylistModifyPublicScope,
                                                     SPTAuthPlaylistModifyPrivateScope]
        loginURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpotify()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInController.updateAfterFirstLogin),
                                               name: .connectionCompleted,
                                               object: nil)
    }
    
    @IBAction func signin(_ sender: Any) {
        if UIApplication.shared.openURL(loginURL!) {
            if auth.canHandle(auth.redirectURL) {
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaylistControllerSegue" {
            print("Segue Invoked")
            let playlistController = segue.destination as? PlaylistController
            playlistController?.session = session
        }
    }
    
    @objc func updateAfterFirstLogin (_ notification: Notification) {
        print("first login called")
        if let sessionObj:AnyObject = UserDefaults().object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            performSegue(withIdentifier: "PlaylistControllerSegue", sender: self)
        }
    }
    
}

extension Notification.Name {
    static let connectionCompleted = Notification.Name(
        rawValue: "loginSuccessfull")
}
