import UIKit

class MyAccountTableViewController: UITableViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!

    // MARK: Loading functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = User.getDefaultUser() {
            lblFirstName.text = user.firstName
            lblLastName.text = user.lastName
            lblEmail.text = user.email
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
