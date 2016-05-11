////
////  NSDateExtension.swift
////  toodles
////
////  Created by Justin Madsen on 5/4/16.
////  Copyright © 2016 mbv. All rights reserved.
////
//
//import Foundation
//
//extension NSDate {
//    convenience init(dateString:String) {
//        let dateStringFormatter = NSDateFormatter()
//        dateStringFormatter.dateFormat = "yyyy-MM-dd"
//        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//        let d = dateStringFormatter.dateFromString(dateString)!
//        self.init(timeInterval:0, sinceDate:d)
//    }
//}