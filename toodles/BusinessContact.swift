//
//  BusinessContact.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class BusinessContact : DatabaseObject {
    // MARK: Fields
    private var _business : Business!
    private var _firstName : String!
    private var _lastName : String!
    private var _title : String!
    private var _primaryPhone : PhoneNumber!
    private var _secondaryPhone : PhoneNumber?
    private var _businesses : [BusinessLocation]!
    
    // MARK: Constructors
    init(id : Int, business : Business, firstName : String, lastName : String, title : String, primaryPhone : PhoneNumber, secondaryPhone : PhoneNumber, businesses : [BusinessLocation]) {
        super.init(id : id)
        
        self.business = business
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.primaryPhone = primaryPhone
        self.secondaryPhone = secondaryPhone
        self.businesses = businesses
    }
    
    // MARK: Properties
    var business : Business! {
        get { return _business }
        set { _business = newValue }
    }
    
    var firstName : String! {
        get { return _firstName }
        set { _firstName = newValue }
    }
    
    var lastName : String! {
        get { return _lastName }
        set { _lastName = newValue }
    }
    
    var title : String! {
        get { return _title }
        set { _title = newValue }
    }
    
    var primaryPhone : PhoneNumber! {
        get { return _primaryPhone }
        set { _primaryPhone = newValue }
    }
    
    var secondaryPhone : PhoneNumber? {
        get { return _secondaryPhone }
        set { _secondaryPhone = newValue }
    }
    
    var businesses : [BusinessLocation]! {
        get { return _businesses }
        set { _businesses = newValue }
    }
}