import UIKit
import EZLoadingActivity

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var lnkLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.lnkLoginTapped))
        lnkLogin.addGestureRecognizer(tap)

    }

    @IBAction func btnCreateAccount(_ sender: AnyObject) {
        
        _ = EZLoadingActivity.show("Creating user account...", disableUI: true)
        
        let user = User(id: 0, firstName: txtFirstName.text!, lastName: txtLastName.text!, userName: txtUsername.text!, email: txtEmail.text!)
        
        UserDAO.createAccount(user, password: txtPassword.text!, passwordConfirmation: txtConfirmPassword.text!, successHandler: accountCreated, failHandler: accountFailedToCreate)

    }
    
    func accountCreated(_ user: User) {
        _ = EZLoadingActivity.hide()
        user.saveUserAsDefault()
        let alertController = UIAlertController(title: "Success!", message: "Created account! Please check your email to validate before logging in.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Right on!", style: .default, handler: goBack))
        present(alertController, animated: true, completion: nil)
    }
    
    func goBack(_ alertAction : UIAlertAction) {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    func accountFailedToCreate(_ error: String) {
        _ = EZLoadingActivity.hide()
        let alertController = UIAlertController(title: "Data Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func lnkLoginTapped(_ sender:UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "backSegue", sender: self)
    }
}
