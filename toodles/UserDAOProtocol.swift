import Foundation

protocol UserDAOProtocol {
    func validateCredentials(email: String, password: String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?)
    
    func getUser(userId: Int, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?)
    
    func createAccount(user: User, password : String, passwordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?)
    
    func changePassword(userId: Int, password: String, newPassword : String, newPasswordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?)
    
    func changeInfo(user : User, successHandler: ((User, Bool) -> Void)?, failHandler: ((String) -> Void)?)
}
