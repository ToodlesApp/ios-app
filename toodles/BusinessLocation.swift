//
//  BusinessLocation.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class BusinessLocation : DatabaseObject {
    // MARK: Fields
    private var _business : Business!
    private var _address : Address!
    private var _phoneNumber : PhoneNumber!
    private var _coupons : [Coupon]!
    private var _contacts : [BusinessContact]!
    
    // MARK: Constructors
    init(id : Int, business : Business, address: Address, phoneNumber: PhoneNumber, coupons : [Coupon], contacts : [BusinessContact]) {
        super.init(id: id)
        
        self.business = business
        self.address = address
        self.phoneNumber = phoneNumber
        self.coupons = coupons
        self.contacts = contacts
    }
    
    // MARK: Properties
    var business : Business! {
        get { return _business }
        set { _business = newValue }
    }
    
    var address : Address! {
        get { return _address }
        set { _address = newValue }
    }
    
    var phoneNumber : PhoneNumber! {
        get { return _phoneNumber }
        set { _phoneNumber = newValue }
    }
    
    var coupons : [Coupon]! {
        get { return _coupons }
        set { _coupons = newValue }
    }
    
    var contacts : [BusinessContact]! {
        get { return _contacts }
        set { _contacts = newValue }
    }
}