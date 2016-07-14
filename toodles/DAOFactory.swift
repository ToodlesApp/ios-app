import Foundation

class DAOFactory {
    static var useMockDAO = true
    
    static func getUserDAO() -> UserDAOProtocol {
        if useMockDAO {
            return MockUserDAO()
        } else {
            return UserDAO()
        }
    }
    
    static func getCouponDAO() -> CouponDAOProtocol {
        if useMockDAO {
            return MockCouponDAO()
        } else {
            return CouponDAO()
        }
    }
    
    static func getBookletDAO() -> BookletDAOProtocol {
        if useMockDAO {
            return MockBookletDAO()
        } else {
            return BookletDAO()
        }
    }
}
