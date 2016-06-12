import Foundation

class UserDAO {
    
    // MARK: validateCredentials methods
    static func validateCredentials(username: String, password: String, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        APICaller.postRequest("validate_credentials", params: ["username" : username, "password" : password], successHandler : {
            (data) -> Void in
            
            let success = data["valid"] as! Bool
            
            if success {
                let userData = data["details"] as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), {
                    successHandler?(loadUserFromData(userData))
                })
            } else {
                let details = data["details"] as! String
                dispatch_async(dispatch_get_main_queue(), {
                    failHandler?(details)
                })
            }
            
        }, failHandler : {
            (errorType, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                failHandler?(getAPICallerErrorMessage(errorType))
            })
        })
    }
    
    // MARK: getUser methods
    static func getUser(userId: Int) {
        getUser(userId, successHandler: nil)
    }
    
    static func getUser(userId: Int, successHandler: ((User) -> Void)?) {
        getUser(userId, successHandler: successHandler, failHandler: nil)
    }
    
    static func getUser(userId: Int, successHandler: ((User) -> Void)?, failHandler: ((String) -> Void)?) {
        APICaller.getRequest("users/1", successHandler: {
            (data) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), {
                successHandler?(loadUserFromData(data))
            })
            
        }, failHandler: {
            (errorType, error) in

            
            dispatch_async(dispatch_get_main_queue(), {
                failHandler?(getAPICallerErrorMessage(errorType))
            })
        })
    }
    
    // MARK: changePassword methods
//    static func changerPassword
    
    // MARK: forgotPassword methods
    
    // MARK: helper methods
    static func loadUserFromData(data: NSDictionary) -> User {
        let id = data["id"] as! Int
        let firstName = data["first_name"] as! String
        let lastName = data["last_name"] as! String
        let email = data["email"] as! String
        let userName = data["username"] as! String
        return User(id: id, firstName: firstName, lastName: lastName, userName: userName, email: email)
    }
    
    static func getAPICallerErrorMessage(errorType: APICallerError) -> String {
        switch (errorType) {
        case .DeserializerFailed:
            return "Unable to process response from server"
        case .SerializerFailed:
            return "Unable to process request to server"
        case .ServerReturnedNoData:
            return "Unable to retrieve data from server"
        case .ServerReturnedError:
            return "Error was thrown!"
        }
    }
    
}