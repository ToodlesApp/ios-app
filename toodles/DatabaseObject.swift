//
//  DatabaseObject.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class DatabaseObject {
    // MARK: Fields
    private var _id : Int!
 
    // MARK: Constructors
    init(id : Int) {
        self.id = id
    }
    
    // MARK: Properties
    var id : Int!{
        get { return _id }
        set { _id = newValue }
    }
}