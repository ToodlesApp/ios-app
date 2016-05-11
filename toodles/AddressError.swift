//
//  AddressError.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

enum AddressError : ErrorType {
    case InvalidAddress1
    case InvalidAddress2
    case InvalidCity
    case InvalidState
    case InvalidZip
    case InvalidCountry
}