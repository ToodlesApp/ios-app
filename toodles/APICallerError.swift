//
//  APICallerError.swift
//  toodles
//
//  Created by Justin Madsen on 5/22/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

enum APICallerError : ErrorType {
    case ServerReturnedError
    case ServerReturnedNoData
    case DeserializerFailed
    case SerializerFailed
}