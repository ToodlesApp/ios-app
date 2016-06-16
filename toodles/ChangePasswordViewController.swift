//
//  ChangePasswordViewController.swift
//  toodles
//
//  Created by Susan Madsen on 6/12/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import UIKit
import EZLoadingActivity

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtNewPasswordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCancelClicked(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChangeClicked(_ sender: AnyObject) {
        guard let user = User.getDefaultUser() else {
            return
        }
        
        _ = EZLoadingActivity.show("Changing password", disableUI: true)
        UserDAO.changePassword(user.id, password: txtOldPassword.text!, newPassword: txtNewPassword.text!, newPasswordConfirmation: txtNewPasswordConfirmation.text!, successHandler: onPasswordChanged, failHandler: onPasswordFailed)
    }
    
    func onPasswordChanged(_ user : User) {
        _ = EZLoadingActivity.hide()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func onPasswordFailed(_ error : String) {
        _ = EZLoadingActivity.hide()
        let alertController = UIAlertController(title: "Data Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
