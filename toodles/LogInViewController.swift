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
    
    @IBAction func btnSignupClicked(sender: AnyObject) {
        EZLoadingActivity.show("Loading...", disableUI: true)
        UserDAO.getUser(1, successHandler: setUser, failHandler: displayError)
    }
    
    func setUser(user: User) {
        EZLoadingActivity.hide()
        txtUsername.text = user.firstName
    }
    
    func displayError(error: String) {
        EZLoadingActivity.hide()
        let alertController = UIAlertController(title: "Data Error", message: error, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginClicked(sender: AnyObject) {
        if txtUsername.text!.trim().characters.count == 0 || txtPassword.text!.trim().characters.count == 0 {
            let alert = UIAlertController(title: "Missing Fields", message: "Please enter username and password.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        UserDAO.validateCredentials(txtUsername.text!, password: txtPassword.text!, successHandler: openApp, failHandler: displayError)
    }
    
    func openApp(user: User) {
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func lnkForgotPasswordTapped(sender:UITapGestureRecognizer) {
        txtUsername.text = "worked"
    }
    
}
