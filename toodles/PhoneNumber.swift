//
//  PhoneNumber.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

class PhoneNumber {
    // MARK: Fields
    private var _areaCode : String!
    private var _baseNumber : String!
    private var _extensionNumber : String!
    
    // MARK: Constructors
    init(areaCode : String, baseNumber : String, extensionNumber : String) throws {
        let formattedAreaCode = areaCode.trim()
        let formattedBaseNumber = baseNumber.trim()
        let formattedExtensionNumber = extensionNumber.trim()
        
        if !(Int(formattedAreaCode) == nil) || formattedAreaCode.characters.count != 3 {
            throw PhoneNumberError.invalidAreaCode
        }
        
        if !(Int(formattedBaseNumber) == nil) || formattedBaseNumber.characters.count != 7 {
            throw PhoneNumberError.invalidBaseNumber
        }
        
        if !(Int(formattedExtensionNumber) == nil) {
            throw PhoneNumberError.invalidExtensionNumer
        }
        
        self.areaCode = formattedAreaCode
        self.baseNumber = formattedBaseNumber
        self.extensionNumber = formattedExtensionNumber
    }
    
    convenience init(areaCode : String, baseNumber : String) throws {
        try self.init(areaCode: areaCode, baseNumber: baseNumber, extensionNumber: "")
    }
    
    // MARK: Properties
    var areaCode : String! {
        get { return _areaCode }
        set { _areaCode = newValue }
    }
    
    var baseNumber : String! {
        get { return _baseNumber }
        set { _baseNumber = newValue }
    }
    
    var extensionNumber : String! {
        get { return _extensionNumber }
        set { _extensionNumber = newValue }
    }
    
    var formattedNumber : String {
        get { return "(\(areaCode)) \(baseNumber) \(extensionNumber.trim().characters.count == 0 ? "" : "ext. \(extensionNumber)")" }
    }
}
