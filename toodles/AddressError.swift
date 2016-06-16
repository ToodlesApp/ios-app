//
//  AddressError.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

enum AddressError : ErrorProtocol {
    case invalidAddress1
    case invalidAddress2
    case invalidCity
    case invalidState
    case invalidZip
    case invalidCountry
}
