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
        var src:Unmanaged<CGImageSource>! = CGImageSourceCreateWithURL ( url as CFURLRef, nil);
        
        // Swift wraps returned Core Foundation objects in an Unmanaged<T> structure
        // When you receive an unmanaged object from an unannotated API, you should immediately convert it to a memory managed object before you work with it.
        var source : CGImageSource! = src.takeUnretainedValue();
        
        if ( source == nil )
        {
            println("Error: could not read image \(path)");
            exit(0);
        }
        
        var meta:CFDictionary! = CGImageSourceCopyPropertiesAtIndex(source, 0, nil).takeUnretainedValue();
        
        // Cleanup
        CFRelease(source);
        CFRelease ( meta );
        source = nil;
                
        return meta as NSDictionary;        
    }
    
}


