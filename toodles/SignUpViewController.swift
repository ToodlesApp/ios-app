//
//  SignUpViewController.swift
//  toodles
//
//  Created by Justin Madsen on 5/6/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnCreateAccount(sender: AnyObject) {
        performSegueWithIdentifier("backSegue", sender: self)
    }
}
