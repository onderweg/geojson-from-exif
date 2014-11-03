//
//  UnitTests.swift
//  UnitTests
//
//  Created by Gerwert on 02/11/14.
//  Copyright (c) 2014 Onderweg. All rights reserved.
//

/* Note: to be able to call code from main target, set Target Membership of
swift file to this test target */

import Cocoa
import XCTest

class UnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExif() {
        let bundle = NSBundle(forClass: UnitTests.self);
        let imgSrc = bundle.URLForResource("example", withExtension: "jpg");
        let meta = ImageMeta.readFromUrl(imgSrc!);
        
        XCTAssertNotNil(meta, "Should have meta data");
        XCTAssertNotNil(meta[kCGImagePropertyGPSDictionary as String], "Should contain GPS data");
  
    }
    
    func testPoints() {
        var point = Point( coordinates: (latitude:12.2, longitude:12.4) );
        var points = PointCollection();
        points.add(point);

        XCTAssertEqual(1, points.count(), "Should contain 1 point" );
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
