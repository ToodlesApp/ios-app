import Foundation

class MockUserDAO : UserDAOProtocol {
    
    static var _users = [
        User(id: 1, firstName: "Justin", lastName: "Madsen", email: "justinmadsen4@gmail.com", password: "test123")
    ]

    func validateCredentials(email: String, password: String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        for user in MockUserDAO._users {
            if user.email == email && user.password == password {
                successHandler?(user)
                return
            }
        }
        failHandler?("Invalid credentials")
    }
    
    func getUser(userId: Int, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        for user in MockUserDAO._users {
            if user.id == userId {
                successHandler?(user)
                return
            }
        }
        failHandler?("Can't find user by id")
    }
    
    func createAccount(user: User, password : String, passwordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        if (password == passwordConfirmation) {
            user.id = MockUserDAO._users.count + 1
            user.password = password
            MockUserDAO._users.append(user)
            successHandler?(user)
        } else {
            failHandler?("Passwords don't match")
        }
    }
    
    func changePassword(userId: Int, password: String, newPassword : String, newPasswordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        
        if let user = (MockUserDAO._users.first { (user : User) -> Bool in user.id == userId && user.password == password }) where newPassword == newPasswordConfirmation {
            user.password = newPassword
            successHandler?(user)
        } else {
            failHandler?("Unable to change password")
        }
    }
    
    func changeInfo(user : User, successHandler: ((User, Bool) -> Void)?, failHandler: ((String) -> Void)?) {
        if let user = (MockUserDAO._users.first { (user :User) -> Bool in user.id == user.id }) {
            print(user.id)
        }
    }
}
