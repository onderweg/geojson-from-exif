//
//  extend.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

extension NSDate
    {
    convenience
        init(dateString:String, timeString:String) {
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
            dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            let d = dateStringFormatter.dateFromString(dateString + " " + timeString)
            self.init(timeInterval:0, sinceDate:d)
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
    func contains(object:AnyObject!) -> Bool {
        if(self.isEmpty) {
            return false
        }
        let array: NSArray = self.bridgeToObjectiveC();
        return array.containsObject(object)
    }
}
