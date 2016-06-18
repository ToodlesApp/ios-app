import Foundation

class UserDAO {
    
    // MARK: validateCredentials methods
    static func validateCredentials(_ email: String, password: String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        var params : Data!
        do {
            params = try JSONSerialization.data(withJSONObject: ["email" : email, "password" : password], options: .prettyPrinted)
        } catch let err as NSError{
            failHandler?(err.debugDescription)
            return
        }
        
        APICaller.postRequest("validate_credentials", params: params, httpMethod: "POST",
            successHandler : { (data) -> Void in
                DispatchQueue.main.async(execute: {
                    if let success = data["success"] as? Bool {
                        if success {
                            if let userData = data["details"] as? NSDictionary, let user = loadUserFromData(userData) {
                                successHandler?(user)
                            } else {
                                failHandler?("Unable to load user from server response")
                            }
                        } else {
                            if let details = data["details"] as? String {
                                failHandler?(details)
                            } else {
                                failHandler?("Invalid response from server")
                            }
                        }
                    }
                })
            },
            failHandler : {
                (errorType, error) in
                
                DispatchQueue.main.async(execute: {
                    failHandler?(getAPICallerErrorMessage(errorType))
                })
            })
    }
    
    // MARK: getUser methods
    static func getUser(_ userId: Int) {
        getUser(userId, successHandler: nil)
    }
    
    static func getUser(_ userId: Int, successHandler: ((User) -> Void)?) {
        getUser(userId, successHandler: successHandler, failHandler: nil)
    }
    
    static func getUser(_ userId: Int, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        APICaller.getRequest("users/1",
            successHandler: { (data) -> Void in
                DispatchQueue.main.async(execute: {
                    if let userData = data["details"] as? NSDictionary, let user = loadUserFromData(userData) {
                        successHandler?(user)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            },
            failHandler: { (errorType, error) in
                DispatchQueue.main.async(execute: {
                    failHandler?(getAPICallerErrorMessage(errorType))
                })
            })
    }
    
    // MARK: createAccount methods
    static func createAccount(_ user: User, password : String, passwordConfirmation : String) {
        createAccount(user, password: password, passwordConfirmation: passwordConfirmation, successHandler: nil)
    }
    
    static func createAccount(_ user: User, password : String, passwordConfirmation : String, successHandler: ((User) -> Void)?) {
        createAccount(user, password: password, passwordConfirmation: passwordConfirmation, successHandler: successHandler, failHandler: nil)
    }
    
    static func createAccount(_ user: User, password : String, passwordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        
        var params : Data!
        do {
            params = try JSONSerialization.data(
                withJSONObject: [
                    "user" :
                        [
                            "first_name" : user.firstName,
                            "last_name" : user.lastName,
                            "email" : user.email,
                            "password" : password,
                            "password_confirmation" : passwordConfirmation
                    ]
            ], options: .prettyPrinted)
        } catch let err as NSError{
            failHandler?(err.debugDescription)
            return
        }
        
        APICaller.postRequest("users", params: params, httpMethod: "POST", successHandler : {
            (data) -> Void in
            
            let success = data["success"] as! Bool
            
            if success {
                DispatchQueue.main.async(execute: {
                    if let userData = data["details"] as? NSDictionary, let user = loadUserFromData(userData) {
                        successHandler?(user)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            } else {
//                let errors = data["details"] as! NSDictionary
//                let details = ""
//                for (String error in errors) {
//                    details += "\(error as! String)\n"
//                }
                DispatchQueue.main.async(execute: {
                    failHandler?("Unable to create account!")
                })
            }
            
            }, failHandler : {
                (errorType, error) in
                
                DispatchQueue.main.async(execute: {
                    failHandler?(getAPICallerErrorMessage(errorType))
                })
        })
    }
    
    // MARK: changePassword methods
    static func changePassword(_ userId: Int, password: String, newPassword : String, newPasswordConfirmation : String) {
        changePassword(userId, password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation, successHandler: nil)
    }
    
    static func changePassword(_ userId: Int, password: String, newPassword : String, newPasswordConfirmation : String, successHandler: ((User) -> Void)?) {
        changePassword(userId, password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation, successHandler: successHandler, failHandler: nil)
    }
    
    static func changePassword(_ userId: Int, password: String, newPassword : String, newPasswordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        
        var params : Data!
        do {
            params = try JSONSerialization.data(
                withJSONObject: [
                    "password" : password,
                    "new_password" : newPassword,
                    "new_password_confirmation" : newPasswordConfirmation
                ], options: .prettyPrinted)
        } catch let err as NSError{
            failHandler?(err.debugDescription)
            return
        }
        
        APICaller.postRequest("change_password/\(userId)", params: params, httpMethod: "PUT", successHandler : {
            (data) -> Void in
            
            let success = data["success"] as! Bool
            
            if success {
                DispatchQueue.main.async(execute: {
                    if let userData = data["details"] as? NSDictionary, let user = loadUserFromData(userData) {
                        successHandler?(user)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            } else {
                DispatchQueue.main.async(execute: {
                    failHandler?("Unable to update password!")
                })
            }
            
            }, failHandler : {
                (errorType, error) in
                
                DispatchQueue.main.async(execute: {
                    failHandler?(getAPICallerErrorMessage(errorType))
                })
        })
    }
    
    // MARK: forgotPassword methods
    
    // MARK: helper methods
    static func loadUserFromData(_ data: NSDictionary) -> User? {
        if let id = data["id"] as? Int, let firstName = data["first_name"] as? String, let lastName = data["last_name"] as? String, let email = data["email"] as? String {
            return User(id: id, firstName: firstName, lastName: lastName, email: email)
        }
        return nil
    }
    
    static func getAPICallerErrorMessage(_ errorType: APICallerError) -> String {
        switch (errorType) {
        case .deserializerFailed:
            return "Unable to process response from server"
        case .serializerFailed:
            return "Unable to process request to server"
        case .serverReturnedNoData:
            return "Unable to retrieve data from server"
        case .serverReturnedError:
            return "Error was thrown!"
        case .invalidResponseStatusCode:
            return "Invalid response status code from server"
        }
    }
    
}
