//
//  Booklet.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class Booklet : DatabaseObject {
    // MARK: Fields
    private var _title : String!
    private var _description : String!
    private var _startDate : NSDate!
    private var _endDate : NSDate!
    
    // MARK: Constructors
    init(id: Int, title : String, description : String, startDate : NSDate, endDate : NSDate) {
        super.init(id: id)
        
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
    
    // MARK: Properties
    var title : String! {
        get { return _title }
        set { _title = newValue }
    }
    
    var description : String! {
        get { return _description }
        set { _description = newValue }
    }
    
    var startDate : NSDate! {
        get { return _startDate }
        set { _startDate = newValue }
    }
    
    var endDate : NSDate! {
        get { return _endDate }
        set { _endDate = newValue }
    }
}