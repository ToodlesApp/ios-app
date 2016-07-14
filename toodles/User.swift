import Foundation

class User : NSObject, NSCoding {
    // MARK: Fields
    var _id: Int!
    var _firstName: String!
    var _lastName: String!
    var _email: String!
    var _password: String!
    
    // MARK: Constructors
    override init() {
        super.init()
        self.id = 0
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
    }
    
    convenience init(id : Int, firstName : String, lastName : String, email : String, password : String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let id = aDecoder.decodeObject(forKey: "id") as? Int {
            self.id = id
        }
        if let firstName = aDecoder.decodeObject(forKey: "firstName") as? String {
            self.firstName = firstName
        }
        if let lastName = aDecoder.decodeObject(forKey: "lastName") as? String {
            self.lastName = lastName
        }
        if let email = aDecoder.decodeObject(forKey: "email") as? String {
            self.email = email
        }
        if let password = aDecoder.decodeObject(forKey: "password") as? String {
            self.password = password
        }
    }
    
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.password, forKey: "password")
    }
    
    // MARK: Properties
    var id : Int {
        get { return _id }
        set { _id = newValue }
    }
    
    var firstName : String {
        get { return _firstName }
        set { _firstName = newValue }
    }
    
    var lastName : String {
        get { return _lastName }
        set { _lastName = newValue }
    }
    
    var email : String {
        get { return _email }
        set { _email = newValue }
    }
    
    var password : String {
        get { return _password }
        set { _password = newValue }
    }
    
    func saveUserAsDefault() {
        let userData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard().set(userData, forKey: "loggedInUser")
        UserDefaults.standard().synchronize()
    }
    
    static func removeDefaultUser() {
        UserDefaults.standard().removeObject(forKey: "loggedInUser")
        
        UserDefaults.standard().synchronize()
    }
    
    static func getDefaultUser() -> User? {
        if let userData = UserDefaults.standard().object(forKey: "loggedInUser") as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: userData) as? User
        }
        return nil
    }
    
}
