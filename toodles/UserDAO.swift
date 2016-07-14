import Foundation

class UserDAO : UserDAOProtocol {
    func validateCredentials(email: String, password: String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
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
                            if let userData = data["details"] as? NSDictionary, let user = self.loadUserFromData(userData) {
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
                    failHandler?(self.getAPICallerErrorMessage(errorType))
                })
            })
    }
    
    func getUser(userId: Int, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        APICaller.getRequest("users/1",
            successHandler: { (data) -> Void in
                DispatchQueue.main.async(execute: {
                    if let userData = data["details"] as? NSDictionary, let user = self.loadUserFromData(userData) {
                        successHandler?(user)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            },
            failHandler: { (errorType, error) in
                DispatchQueue.main.async(execute: {
                    failHandler?(self.getAPICallerErrorMessage(errorType))
                })
            })
    }
    
    // MARK: createAccount methods
    func createAccount(user: User, password : String, passwordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        
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
                    if let userData = data["details"] as? NSDictionary, let user = self.loadUserFromData(userData) {
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
                    failHandler?(self.getAPICallerErrorMessage(errorType))
                })
        })
    }
    
    // MARK: changePassword methods
    func changePassword(userId: Int, password: String, newPassword : String, newPasswordConfirmation : String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        
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
                    if let userData = data["details"] as? NSDictionary, let user = self.loadUserFromData(userData) {
                        successHandler?(user)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            } else {
                DispatchQueue.main.async(execute: {
                    if let errorMessage = data["details"] as? String {
                        failHandler?(errorMessage)
                    } else {
                        failHandler?("Unable to update password")
                    }
                    
                })
            }
            
            }, failHandler : {
                (errorType, error) in
                
                DispatchQueue.main.async(execute: {
                    failHandler?(self.getAPICallerErrorMessage(errorType))
                })
        })
    }
    
    // MARK: changeInfo methods
    func changeInfo(user : User, successHandler: ((User, Bool) -> Void)?, failHandler: ((String) -> Void)?) {
        var params : Data!
        do {
            params = try JSONSerialization.data(
                withJSONObject: [
                    "first_name" : user.firstName,
                    "last_name" : user.lastName,
                    "email" : user.email
                ], options: .prettyPrinted)
        } catch let err as NSError{
            failHandler?(err.debugDescription)
            return
        }
        
        APICaller.postRequest("change_info/\(user.id)", params: params, httpMethod: "PUT", successHandler : {
            (data) -> Void in
            
            let success = data["success"] as! Bool
            
            if success {
                DispatchQueue.main.async(execute: {
                    if let userData = data["details"] as? NSDictionary, let user = self.loadUserFromData(userData) {
                        successHandler?(user, data["email_changed"] as! Bool)
                    } else {
                        failHandler?("Unable to load user from server response")
                    }
                })
            } else {
                DispatchQueue.main.async(execute: {
                    if let errorMessage = data["details"] as? String {
                        failHandler?(errorMessage)
                    } else {
                        failHandler?("Unable to update info")
                    }
                })
            }
            
            }, failHandler : {
                (errorType, error) in
                
                DispatchQueue.main.async(execute: {
                    failHandler?(self.getAPICallerErrorMessage(errorType))
                })
        })
    }
    
    // MARK: helper methods
    private func loadUserFromData(_ data: NSDictionary) -> User? {
        if let id = data["id"] as? Int, let firstName = data["first_name"] as? String, let lastName = data["last_name"] as? String, let email = data["email"] as? String {
            return User(id: id, firstName: firstName, lastName: lastName, email: email, password: "")
        }
        return nil
    }
    
    func getAPICallerErrorMessage(_ errorType: APICallerError) -> String {
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
