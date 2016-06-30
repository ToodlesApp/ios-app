import UIKit

class BookletSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var booklets : [Booklet]!
    var filteredBooklets : [Booklet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        booklets = BookletDAO.GetDummyBooklets()
        filteredBooklets = booklets
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooklets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let booklet = filteredBooklets[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookletTableViewCell", for: indexPath) as? BookletTableViewCell {
            cell.configureCell(booklet: booklet)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            filteredBooklets = booklets
            view.endEditing(true)
        } else {
            let text = searchBar.text!
            filteredBooklets = booklets.filter({ (booklet: Booklet) -> Bool in
                return booklet.title.range(of: text, options: .caseInsensitiveSearch) != nil
            })
        }
        tableView.reloadData()
    }
}
