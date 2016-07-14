import Foundation

class MockCouponDAO : CouponDAOProtocol {
    func getCoupons() -> [Coupon] {
        var coupons = [Coupon]()
        
        coupons.append(Coupon(title: "Jiffy Lube Oil Change", url: "http://a4.mzstatic.com/us/r30/Purple/v4/fe/d8/23/fed82318-a903-906d-3b0e-e74713a0f7f6/mzl.jeadhgrh.png"))
        coupons.append(Coupon(title: "Carl's Jr. BOGO", url: "http://www.findthatlogo.com/wp-content/gallery/carls-jr-logos/carls-jr-star-logo.png"))
        coupons.append(Coupon(title: "Coral Cliffs FREE", url: "http://a5.mzstatic.com/us/r30/Purple7/v4/b6/60/fd/b660fd20-2dfb-f62a-b64b-b0c7d694727e/icon175x175.png"))
        coupons.append(Coupon(title: "George Fest Pass", url: "http://www.visitstgeorge.com/wp-content/uploads/2014/06/xancestor-logo-180x180.png.pagespeed.ic.Fd-LXZlfW4.png"))
        coupons.append(Coupon(title: "Free Massage", url: "http://media.superpages.com/media/photos//05/08/75/29/83/images/ed034782e69dd3d18136f27d36933461.png"))
        coupons.append(Coupon(title: "20% off Running Store", url: "http://www.stgeorgemarathon.com/newtest/images/sgmlogo.png"))
        coupons.append(Coupon(title: "Jamba Juice", url: "https://upload.wikimedia.org/wikipedia/en/6/62/Jambajuice.png"))
        coupons.append(Coupon(title: "Orange Peel", url: "http://cdn.yogitea.com/wp-content/uploads/sites/7/2014/12/ingredient-32-Orange-Peel-300x300.png"))
        coupons.append(Coupon(title: "YogurtLand", url: "https://upload.wikimedia.org/wikipedia/en/9/92/Yogurtland-logo.png"))
        coupons.append(Coupon(title: "Wendy's", url: "https://cms.ysu.edu/sites/default/files/images/administrative-offices/kilcawley-center/Wendys-Logo.png"))
        coupons.append(Coupon(title: "McDonalds", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald's_Golden_Arches.svg/2000px-McDonald's_Golden_Arches.svg.png"))
        coupons.append(Coupon(title: "Boulevard Furniture Discount", url: "http://www.boulevardhomefurnishings.com/current/img/logo/logo.png"))
        
        return coupons
    }
}
