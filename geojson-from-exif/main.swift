//
//  main.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

let path = (C_ARGC < 2) ? File.currentPath() : String.fromCString(C_ARGV[1]);

let exists = File.exists(path);
if ( !exists.0 || !exists.1 ) {
    println("Path not found: \(path)");
    exit(0);
}

var files = File.listDirectory(path, extensions:["jpg", "jpeg"]);

var points = PointCollection();

for path in files {
    var exif = Exif.readFromFile(path);
    if let gps = exif.objectForKey("{GPS}") as? NSDictionary {
        var latitude = gps["Latitude"].doubleValue;
        let latRef = gps["LatitudeRef"] as String;
        var longitude = gps["Longitude"].doubleValue;
        let lngRef = gps["LongitudeRef"] as String;
        
        // Time stamp of GPS data in GMT
        let dateStamp = gps["DateStamp"] as String;
        let timeStamp = gps["TimeStamp"] as String;
        
        let date = NSDate.fromExifDate(dateStamp, timeString:timeStamp)
        
        if (latRef.lowercaseString == "s") {
            latitude = -latitude;
        }
        if (lngRef.lowercaseString == "w") {
            longitude = -longitude;
        }
        
        var point = Point( coordinates: (latitude:latitude, longitude:longitude) );
        point.properties["file"] = path.lastPathComponent;
        point.properties["date"] = date.toJson();
        points.add(point);
    }
}

println(points.toJsonText());
