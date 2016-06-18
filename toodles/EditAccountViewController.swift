import UIKit
import EZLoadingActivity

class EditAccountViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let u = User.getDefaultUser() {
            user = u
            txtFirstName.text = user.firstName
            txtLastName.text = user.lastName
            txtEmail.text = user.email
        } else {
          _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnChangeClicked(_ sender: AnyObject) {
        
        if txtPassword.text!.trim().characters.count == 0 {
            let alert = UIAlertController(title: "Missing Fields", message: "Please enter password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        _ = EZLoadingActivity.show("Updating account", disableUI: true)
        
        UserDAO.validateCredentials(user.email, password: txtPassword.text!, successHandler: onUserValidated, failHandler: displayError)
    }
    
    func onUserValidated(user :User) {
        let user = User(id: user.id, firstName: txtFirstName.text!, lastName: txtLastName.text!, email: txtEmail.text!)
        UserDAO.changeInfo(user, successHandler: onUserInfoChanged, failHandler: displayError)
    }
    
    func onUserInfoChanged(user : User, emailChanged : Bool) {
        user.saveUserAsDefault()
        _ = EZLoadingActivity.hide()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func displayError(_ error: String) {
        _ = EZLoadingActivity.hide()
        let alertController = UIAlertController(title: "Data Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func btnCancelClicked(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
