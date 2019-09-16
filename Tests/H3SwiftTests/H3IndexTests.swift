//
//  H3IndexTests.swift
//  H3Swift
//
//  Created by Teemu Harju on 31.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import XCTest
@testable import H3Swift

import h3lib

final class H3IndexTests: XCTestCase {
    
    func testGeoCoordToIndex() {
        
        let geoCoord = H3.GeoCoord(lat: 40.689167, lon: -74.044444)
        let index = geoCoord.toH3(resolution: 5)
        
        XCTAssertEqual(index.hexString, "0x852a1073fffffff")
    }
    
    func testIndexToGeoCoord() {
        let geoCoord1 = H3.GeoCoord(lat: 40.72057966485312, lon: -74.09152905917784)
        let index = geoCoord1.toH3(resolution: 5)
        
        let geoCoord2 = index.toGeo()
        
        XCTAssertEqual(geoCoord1, geoCoord2)
    }
    
    func testRandomCellCenters() {
        let geoCoord1 = H3.GeoCoord(lat: 10.752074718, lon: 345.714683533)
        XCTAssertEqual(geoCoord1.toH3(resolution: 15).hexString, "0x8f54c4b5391d296")
        
        let geoCoord2 = H3.GeoCoord(lat: -27.384130955, lon: 298.040864468)
        XCTAssertEqual(geoCoord2.toH3(resolution: 15).hexString, "0x8fb2657092a5ca1")
        
        let geoCoord3 = H3.GeoCoord(lat: -65.478402972, lon: 111.465804577)
        XCTAssertEqual(geoCoord3.toH3(resolution: 15).hexString, "0x8fe5098d5d75d5c")
        
        let geoCoord4 = H3.GeoCoord(lat: -3.635374904, lon: 155.61553359)
        XCTAssertEqual(geoCoord4.toH3(resolution: 15).hexString, "0x8f76a1cc64caa8a")
    }
    
    static var allTests = [
        ("testGeoCoordToIndex", testGeoCoordToIndex),
        ("testIndexToGeoCoord", testIndexToGeoCoord),
        ("testRandomCellCenters", testRandomCellCenters)
    ]
}
