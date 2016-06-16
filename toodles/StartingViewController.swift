import UIKit

class StartingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = User.getDefaultUser() {
            self.performSegue(withIdentifier: "openAppSegue", sender: user)
        } else {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }

}
