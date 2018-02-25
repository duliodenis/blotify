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
    }
    
    @IBAction func signin(_ sender: Any) {
        if UIApplication.shared.openURL(loginURL!) {
            if auth.canHandle(auth.redirectURL) {
                
            }
        }
    }
    
}
