import UIKit
import EZLoadingActivity

class LogInViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lnkForgotPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.lnkForgotPasswordTapped))
        lnkForgotPassword.addGestureRecognizer(tap)
    }
    
    @IBAction func btnSignupClicked(_ sender: AnyObject) {
//        EZLoadingActivity.show("Loading...", disableUI: true)
//        UserDAO.getUser(1, successHandler: stuff, failHandler: displayError)
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    func createAccount(_ user: User) {
        _ = EZLoadingActivity.hide()
        txtUsername.text = user.firstName
        
    }
    
    func displayError(_ error: String) {
        _ = EZLoadingActivity.hide()
        let alertController = UIAlertController(title: "Data Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginClicked(_ sender: AnyObject) {
        if txtUsername.text!.trim().characters.count == 0 || txtPassword.text!.trim().characters.count == 0 {
            let alert = UIAlertController(title: "Missing Fields", message: "Please enter username and password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        UserDAO.validateCredentials(txtUsername.text!, password: txtPassword.text!, successHandler: openApp, failHandler: displayError)
    }
    
    func openApp(_ user: User) {
        user.saveUserAsDefault()
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    func lnkForgotPasswordTapped(_ sender:UITapGestureRecognizer) {
        txtUsername.text = "worked"
    }
    
}
