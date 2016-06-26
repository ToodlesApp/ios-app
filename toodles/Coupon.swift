//
//  Coupon.swift
//  toodles
//
//  Created by Justin Madsen on 5/4/16.
//  Copyright © 2016 mbv. All rights reserved.
//

import UIKit

class Coupon {
    // MARK: Fields
    private var _title : String!
    private var _url : String!
    private var _image : UIImage?
//    private var _finePrint : String!
//    private var _maxUse : Int!
//    private var _isTemporary : Bool!
//    private var _isVoided : Bool!
//    private var _locations : [BusinessLocation]!
    
    // MARK: Constructors
//    init(id : Int, title : String, finePrint : String, maxUse : Int, isTemporary : Bool, isVoided : Bool, locations : [BusinessLocation]) {
//        super.init(id: id)
//        
//        self.title = title
//        self.finePrint = finePrint
//        self.maxUse = maxUse
//        self.isTemporary = isTemporary
//        self.isVoided = isVoided
//        self.locations = locations
//    }
    init(title : String, url : String) {
        self.title = title
        self.url = url
        
        
    }
    
    // MARK: Properties
    var title : String! {
        get { return _title }
        set { _title = newValue }
    }
    
    var url : String! {
        get { return _url }
        set {
            _url = newValue
        }
    }
    
    var image : UIImage? {
        return _image
    }
    
    func downloadImage(completion: ((UIImage) -> Void)?){
        
        guard let url = URL(string: url) else {
            print("Invalid url")
            return
        }
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            DispatchQueue.main.sync() { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent ?? "")
                print("Download Finished")
                self._image = UIImage(data: data)
                completion?(self._image!)
            }
        }
    }
    
    func getDataFromUrl(url:URL, completion: ((data: Data?, response: URLResponse?, error: NSError? ) -> Void)) {
        URLSession.shared().dataTask(with: url) {
            (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
