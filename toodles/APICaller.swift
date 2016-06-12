//
//  APICaller.swift
//  toodles
//
//  Created by Justin Madsen on 5/21/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import Foundation
import EZLoadingActivity

class APICaller {
    static let TOODLES_URL = "http://localhost:3000/"
    
    // MARK: getRequest methods
    static func getRequest(method: String) {
        getRequest(method, successHandler: nil)
    }
    
    static func getRequest(method: String, successHandler: ((NSDictionary) -> Void)?) {
        getRequest(method, successHandler: successHandler, failHandler: nil)
    }
    
    static func getRequest(method: String, successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(TOODLES_URL)\(method)")!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = ["cache-control": "no-cache"]
        
        let dataTask = getSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            completionHandler(data, response: response, error: error, successHandler: successHandler, failHandler: failHandler)
        })
            
        dataTask.resume()
    }
    
    // MARK: postRequest methods
    static func postRequest(method: String, params: [String: String]) {
        postRequest(method, params: params, successHandler: nil)
    }
    
    static func postRequest(method: String, params: [String: String], successHandler: ((NSDictionary) -> Void)?) {
        postRequest(method, params: params, successHandler: successHandler, failHandler: nil)
    }
    
    static func postRequest(method: String, params: [String: String], successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(TOODLES_URL)\(method)")!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json",
                                       "cache-control": "no-cache"]
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        } catch let err as NSError{
            failHandler?(.SerializerFailed, err)
            return
        }
        
        let dataTask = getSession().dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            completionHandler(data, response: response, error: error, successHandler: successHandler, failHandler: failHandler)
        })
        
        dataTask.resume()
    }
    
    // MARK: helper methods
    static private func completionHandler(data: NSData?, response: NSURLResponse?, error: NSError?, successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        if let err = error {
            failHandler?(.ServerReturnedError, err)
            return
        }
        
        guard let _ = response as? NSHTTPURLResponse, receivedData = data else {
            failHandler?(.ServerReturnedNoData, nil)
            return
        }
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as? NSDictionary
            
            if let json2 = json {
                successHandler?(json2)
            } else {
                failHandler?(.DeserializerFailed, nil)
            }
            
        } catch let err as NSError {
            failHandler?(.DeserializerFailed, err)
        }
    }
    
    static private func getSession() -> NSURLSession {
        return NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
}