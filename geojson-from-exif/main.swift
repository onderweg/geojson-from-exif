//
//  main.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

let path = (C_ARGC < 2) ? File.currentPath() : String.fromCString(C_ARGV[1])!;

let exists = File.exists(path);
if ( !exists.0 || !exists.1 ) {
    println("Path not found: \(path)");
    exit(0);
}

var files = File.listDirectory(path, extensions:["jpg", "jpeg"]);

var points = PointCollection();
var id:Int = 0;

for path in files {
    var meta = ImageMeta.readFromFile(path);
    
    if let gps = meta.objectForKey(kCGImagePropertyGPSDictionary) as? NSDictionary {
        var latitude: Double = (gps["Latitude"] as NSNumber).doubleValue;
        let latRef = gps["LatitudeRef"] as String;
        
        var longitude: Double = (gps["Longitude"] as NSNumber).doubleValue;
        let lngRef = gps["LongitudeRef"] as String;
        
        var altitude: Double? = gps["Altitude"] as Double?;
        var altRef: Int? = gps["AltitudeRef"] as Int?;
        
        // Time stamp of GPS data in GMT
        let dateStamp = gps["DateStamp"] as String?;
        let timeStamp = gps["TimeStamp"] as String?;
        
        if (latRef.lowercaseString == "s") {
            latitude = -latitude;
        }
        if (lngRef.lowercaseString == "w") {
            longitude = -longitude;
        }
        if (altRef != nil && altRef == 1) {
            altitude = -(altitude!);
        }
        
        var point = Point( coordinates: (latitude:latitude, longitude:longitude), altitude:altitude );
        point.id = String(++id);
        point.properties["file"] = path.lastPathComponent;
        
        if (dateStamp != nil && timeStamp != nil) {
            let date = NSDate.fromExifDate(dateStamp!, timeString:timeStamp!);
            point.properties["date"] = date.toJson();
        }

        // Additional metadata (IPTC)
        if let iptc = meta.objectForKey(kCGImagePropertyIPTCDictionary) as? NSDictionary {
            var descr = iptc[kCGImagePropertyIPTCCaptionAbstract as String] as String?;
            if (descr != nil) {
                point.properties["description"] = descr;
            }
        }

        points.add(point);
        
    }

		
}

println(points.toJsonText());
