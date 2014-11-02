//
//  extend.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

extension NSDate {
    
    class func fromExifDate(dateString:String, timeString:String) -> NSDate {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        dateStringFormatter.timeZone = NSTimeZone(name:"UTC")
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let date = dateStringFormatter.dateFromString(dateString + " " + timeString)
        return date!;
    }
    
    /**
     * Returns ISO-8601 date (e.g: 2013-04-27T13:27:50-0700_
     */
    func toJson() -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
        return dateStringFormatter.stringFromDate(self);
    }
}

extension Array {
    func contains<T : Equatable>(obj: T) -> Bool {
        let filtered = self.filter {$0 as? T == obj}
        return filtered.count > 0
    }
}
