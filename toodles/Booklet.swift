//
//  Booklet.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class Booklet {
    // MARK: Fields
    private var _id : Int!
    private var _title : String!
    private var _description : String!
    private var _startDate : Date!
    private var _endDate : Date!
    
    // MARK: Constructors
    init(id : Int, title : String, description : String, startDate : Date, endDate : Date) {
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
    
    // MARK: Properties
    var id : Int!{
        get { return _id }
        set { _id = newValue }
    }
    
    var title : String! {
        get { return _title }
        set { _title = newValue }
    }
    
    var description : String! {
        get { return _description }
        set { _description = newValue }
    }
    
    var startDate : Date! {
        get { return _startDate }
        set { _startDate = newValue }
    }
    
    var endDate : Date! {
        get { return _endDate }
        set { _endDate = newValue }
    }
}
