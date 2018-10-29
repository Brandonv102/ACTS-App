//
//  ViewController.swift
//  TTime
//
//  Created by  on 9/11/18.
//  Copyright © 2018 Isaiah Cherry. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblGivenName: UILabel!
    @IBOutlet weak var lblFamilyName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnSignIn: GIDSignInButton!
    @IBOutlet weak var btnSignOut: UIButton!
    
    @IBAction func SignOut(_ sender: Any) {
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
        // Do any additional setup after loading the view, typically from a nib.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var signInButton: GIDSignInButton!

    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            lblUserId.isHidden = false
            lblFullName.isHidden = false
            lblGivenName.isHidden = false
            lblFamilyName.isHidden = false
            lblEmail.isHidden = false
            btnSignIn.isHidden = true
            btnSignOut.isHidden = false
        } else {
            // Signed out
            lblUserId.isHidden = true
            lblFullName.isHidden = true
            lblGivenName.isHidden = true
            lblFamilyName.isHidden = true
            lblEmail.isHidden = true
            btnSignIn.isHidden = false
            btnSignOut.isHidden = true
        }
    }

    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let user = notification.object as? GIDGoogleUser else { return }
                guard (notification.userInfo as? [String:String]) != nil else { return }
                
                lblFullName.text = user.profile.name
                lblGivenName.text = user.profile.givenName
                lblFamilyName.text = user.profile.familyName
                lblEmail.text = user.profile.email
            }
        }
    }

}
   

