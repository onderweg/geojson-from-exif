//
//  exif.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

class ImageMeta {
    
    class func readFromUrl(url:NSURL) -> NSDictionary {
        var src = CGImageSourceCreateWithURL ( url, nil);
        
        if ( src == nil )
        {
            println("Error: could not read image \(url)");
            exit(0);
        }
        
        var meta:CFDictionary! = CGImageSourceCopyPropertiesAtIndex(src, 0, nil);
        
        return meta as NSDictionary;
    }
    
    class func readFromFile(path:String) -> NSDictionary {
        var url = NSURL(fileURLWithPath: path);
        return self.readFromUrl(url!);
    }
    
}


