import UIKit

class CouponSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var coupons : [Coupon]!
    var filteredCoupons : [Coupon]!
    
    let CELL_PADDING : CGFloat = 8.0

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        coupons = DAOFactory.getCouponDAO().getCoupons()
        filteredCoupons = coupons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coupon = filteredCoupons[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCollectionViewCell", for: indexPath) as? CouponCollectionViewCell {
            cell.configureCell(coupon: coupon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCoupons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collection.layer.preferredFrameSize().width / 2) - (CELL_PADDING / 2)
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CELL_PADDING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CELL_PADDING
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            filteredCoupons = coupons
            view.endEditing(true)
        } else {
            let text = searchBar.text!
            filteredCoupons = coupons.filter({ (coupon: Coupon) -> Bool in
                return coupon.title.range(of: text, options: .caseInsensitiveSearch) != nil
            })
        }
        collection.reloadData()
    }
}
