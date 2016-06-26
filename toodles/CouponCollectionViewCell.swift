import UIKit

class CouponCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCouponPic : UIImageView!
    @IBOutlet weak var lblCouponTitle : UILabel!
    
    var coupon : Coupon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(coupon : Coupon) {
        self.coupon = coupon
        
        lblCouponTitle.text = coupon.title
        if let couponImage = coupon.image {
            imgCouponPic.image = couponImage
        } else {
            imgCouponPic.image = UIImage(named: "coupon")
            coupon.downloadImage(completion: { (image: UIImage) in
                self.imgCouponPic.image = image
            })
        }
    }
    
}
