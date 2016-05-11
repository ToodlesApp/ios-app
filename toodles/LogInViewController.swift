//
//  LogInViewController.swift
//  toodles
//
//  Created by Justin Madsen on 5/6/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lnkForgotPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.lnkForgotPasswordTapped))
        lnkForgotPassword.addGestureRecognizer(tap)
    }
    
    @IBAction func btnSignupClicked(sender: AnyObject) {
        performSegueWithIdentifier("signUpSegue", sender: self)
    }
    
    @IBAction func btnLoginClicked(sender: AnyObject) {
        if txtUsername.text!.trim().characters.count == 0 || txtPassword.text!.trim().characters.count == 0 {
            let alert = UIAlertController(title: "Missing Fields", message: "Please enter username and password.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func lnkForgotPasswordTapped(sender:UITapGestureRecognizer) {
        txtUsername.text = "worked"
    }
    
}
