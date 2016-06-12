//
//  User.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class User : DatabaseObject {
    // MARK: Fields
    var _firstName: String!
    var _lastName: String!
    var _userName: String!
    var _email: String!
    
    // MARK: Constructors
    init(id : Int, firstName : String, lastName : String, userName : String, email : String) {
        super.init(id : id)
        
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.email = email
    }
    
    // MARK: Properties
    var firstName : String! {
        get { return _firstName }
        set { _firstName = newValue }
    }
    
    var lastName : String! {
        get { return _lastName }
        set { _lastName = newValue }
    }
    
    var userName : String! {
        get { return _userName }
        set { _userName = newValue }
    }
    
    var email : String! {
        get { return _email }
        set { _email = newValue }
    }
    
}