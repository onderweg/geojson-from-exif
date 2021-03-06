//
//  geojson.swift
//  Project: geojson-from-exif
//
//  Created by G. Stevens
//  Copyright (c) 2014
//

import Foundation

typealias Coordinates = (latitude:Double, longitude:Double);

class PointCollection {
    
    var points:Array<Point> = Array<Point>();
    
    var id:String = "";
    
    subscript(index: Int) -> Point {
        get {
            return self.points[index];
        }
        set(newValue) {
            self.points[index] = newValue;
        }
    }
    
    init () {
        
    }
    
    func add(point:Point) {
        points.append(point);
    }
    
    func count() -> Int {
        return points.count;
    }
    
    func toJsonText() -> String {
        var jsonCreationError:NSError?;
        
        var dict:Dictionary<String, AnyObject> = [
            "type": "FeatureCollection",
            "features": self.points.map {
                [
                    "id": $0.id,
                    "type": "Feature",
                    "properties": $0.properties,
                    "geometry": [
                        "type": "Point",
                        "coordinates": $0.toArray()
                    ]
                    
                ]
            }
        ];
        

        let jsonData:NSData = NSJSONSerialization.dataWithJSONObject(dict,
            options: NSJSONWritingOptions.PrettyPrinted, error: &jsonCreationError)!
        
        if (jsonCreationError != nil) {
            println("Errors: \(jsonCreationError)")
        }
        
        return NSString(data: jsonData, encoding: NSUTF8StringEncoding) as String;
    }
    
}

class Point {
    
    var id:String = "";
    
    var altitude:Double? = nil;
    
    var coordinates:Coordinates;
    
    var properties:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
    
    init (coordinates:Coordinates, altitude:Double? = nil) {
        self.coordinates = coordinates;
        self.altitude = altitude;
    }
    
    func toArray() -> Array<Double> {
        if (self.altitude != nil) {
            return [
                self.coordinates.longitude,
                self.coordinates.latitude,
                self.altitude!
            ];
        } else {
            return [
                self.coordinates.longitude,
                self.coordinates.latitude
            ];
        }
    }

}
