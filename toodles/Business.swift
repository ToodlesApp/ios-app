//
//  Business.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class Business : DatabaseObject {
    // MARK: Fields
    private var _businessName : String!
    private var _locations : [BusinessLocation]!
    
    // MARK: Constructors
    init(id : Int, businessName : String, locations : [BusinessLocation]) {
        super.init(id : id)
        
        self.businessName = businessName
        self.locations = locations
    }
    
    // MARK: Properties
    var businessName : String! {
        get { return _businessName }
        set { _businessName = newValue }
    }
    
    var locations : [BusinessLocation]! {
        get { return _locations }
        set { _locations = newValue }
    }
}