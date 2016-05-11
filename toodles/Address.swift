//
//  Address.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class Address : DatabaseObject {
    // MARK: Fields
    private var _address1 : String!
    private var _address2 : String!
    private var _city : String!
    private var _state : State!
    private var _zip : String!
    private var _country : Country!
    
    // MARK: Constructors
    init(id : Int, address1 : String, address2 : String, city : String, state : State, zip : String, country : Country) {
        super.init(id: id)
        
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
    }
    
    convenience init(id : Int, address1 : String, address2 : String, city : String, state : State, zip : String) {
        self.init(id: id, address1 : address1, address2: address2, city: city, state: state, zip: zip, country: .USA)
    }
    
    // MARK: Properties
    var address1 : String! {
        get { return _address1 }
        set { _address1 = newValue }
    }
    
    var address2 : String! {
        get { return _address2 }
        set { _address2 = newValue }
    }
    
    var city : String! {
        get { return _city }
        set { _city = newValue }
    }
    
    var state : State! {
        get { return _state }
        set { _state = newValue }
    }
    
    var zip : String! {
        get { return _zip }
        set { _zip = newValue }
    }
    
    var country : Country! {
        get { return _country }
        set { _country = newValue }
    }
}