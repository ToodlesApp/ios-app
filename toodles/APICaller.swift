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
    
    // MARK: getRequest methods
    static func getRequest(_ method: String) {
        getRequest(method, successHandler: nil)
    }
    
    static func getRequest(_ method: String, successHandler: ((NSDictionary) -> Void)?) {
        getRequest(method, successHandler: successHandler, failHandler: nil)
    }
    
    static func getRequest(_ method: String, successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        
        var request = URLRequest(url: URL(string: "\(TOODLES_URL)\(method)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["cache-control": "no-cache"]
        
        
        let dataTask = getDefaultSession().dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            completionHandler(data, response: response, error: error, successHandler: successHandler, failHandler: failHandler)
        })
            
        dataTask.resume()
    }
    
    
    // MARK: postRequest methods
    static func postRequest(_ method: String, params: Data, httpMethod: String) {
        postRequest(method, params: params, httpMethod: httpMethod, successHandler: nil)
    }
    
    static func postRequest(_ method: String, params: Data, httpMethod: String, successHandler: ((NSDictionary) -> Void)?) {
        postRequest(method, params: params, httpMethod: httpMethod, successHandler: successHandler, failHandler: nil)
    }
    
    static func postRequest(_ method: String, params: Data, httpMethod: String, successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        var request = URLRequest(url: URL(string: "\(TOODLES_URL)\(method)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = ["content-type": "application/json",
                                       "cache-control": "no-cache"]
        request.httpBody = params
        
        let dataTask = getDefaultSession().dataTask(with: request, completionHandler: {
            (data : Data?, response : URLResponse?, error : NSError?) -> Void in
            completionHandler(data, response: response, error: error, successHandler: successHandler, failHandler: failHandler)
        })
        
        dataTask.resume()
    }
    
    // MARK: helper methods
    static private func completionHandler(_ data: Data?, response: URLResponse?, error: NSError?, successHandler: ((NSDictionary) -> Void)?, failHandler: ((APICallerError, NSError?) -> Void)?) {
        if let err = error {
            failHandler?(.serverReturnedError, err)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, receivedData = data else {
            failHandler?(.serverReturnedNoData, nil)
            return
        }
        
        if httpResponse.statusCode < 200 || httpResponse.statusCode > 300 {
            failHandler?(.invalidResponseStatusCode, nil)
            return
        }
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as? NSDictionary
            
            if let json2 = json {
                successHandler?(json2)
            } else {
                failHandler?(.deserializerFailed, nil)
            }
            
        } catch let err as NSError {
            failHandler?(.deserializerFailed, err)
        }
    }
    
    static private func getDefaultSession() -> URLSession {
        return URLSession(configuration: URLSessionConfiguration.default())
    }
}
