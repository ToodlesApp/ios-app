//
//  Coupon.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class Coupon : DatabaseObject {
    // MARK: Fields
    private var _title : String!
    private var _finePrint : String!
    private var _maxUse : Int!
    private var _isTemporary : Bool!
    private var _isVoided : Bool!
    private var _locations : [BusinessLocation]!
    
    // MARK: Constructors
    init(id : Int, title : String, finePrint : String, maxUse : Int, isTemporary : Bool, isVoided : Bool, locations : [BusinessLocation]) {
        super.init(id: id)
        
        self.title = title
        self.finePrint = finePrint
        self.maxUse = maxUse
        self.isTemporary = isTemporary
        self.isVoided = isVoided
        self.locations = locations
    }
    
    // MARK: Properties
    var title : String! {
        get { return _title }
        set { _title = newValue }
    }
    
    var finePrint : String! {
        get { return _finePrint }
        set { _finePrint = newValue }
    }
    
    var maxUse : Int! {
        get { return _maxUse }
        set { _maxUse = newValue }
    }
    
    var isTemporary : Bool! {
        get { return _isTemporary }
        set { _isTemporary = newValue }
    }
    
    var isVoided : Bool! {
        get { return _isVoided }
        set { _isVoided = newValue }
    }
    
    var locations : [BusinessLocation]! {
        get { return _locations }
        set { _locations = newValue }
    }
}