//
//  APICallerError.swift
//  toodles
//
//  Created by Justin Madsen on 5/22/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation

enum APICallerError : ErrorProtocol {
    case serverReturnedError
    case serverReturnedNoData
    case deserializerFailed
    case serializerFailed
}
