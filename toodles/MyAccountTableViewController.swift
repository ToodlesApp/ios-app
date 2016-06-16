import UIKit

class MyAccountTableViewController: UITableViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUsername: UILabel!

    // MARK: Loading functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = User.getDefaultUser() {
            lblFirstName.text = user.firstName
            lblLastName.text = user.lastName
            lblEmail.text = user.email
            lblUsername.text = user.userName
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
