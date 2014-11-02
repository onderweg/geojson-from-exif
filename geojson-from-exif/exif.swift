//
//  exif.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

class Exif {
    
    class func readFromFile(path:String) -> NSDictionary {
        var url = NSURL(fileURLWithPath: path);
        var src = CGImageSourceCreateWithURL ( url, nil);

        if ( src == nil )
        {
            println("Error: could not read image \(path)");
            exit(0);
        }
        
        var meta:CFDictionary! = CGImageSourceCopyPropertiesAtIndex(src, 0, nil);
                
        return meta as NSDictionary;    
    }
    
}


