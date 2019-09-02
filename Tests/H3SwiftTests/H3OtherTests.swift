//
//  H3OtherTests.swift
//  H3SwiftTests
//
//  Created by Teemu Harju on 1.9.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import XCTest
@testable import H3Swift

import h3lib

final class H3OtherTests: XCTestCase {
    
    func testGeofenceBBox() {
        
        let geofence = H3.Geofence(verts: [
            H3.GeoCoord(lat: 0.8, lon: 0.3),
            H3.GeoCoord(lat: 0.7, lon: 0.6),
            H3.GeoCoord(lat: 1.1, lon: 0.7),
            H3.GeoCoord(lat: 1.0, lon: 0.2)]
        )
        
        let bbox = geofence.bbox
        
        XCTAssertEqual(bbox, H3.BBox(north: 1.1, south: 0.7, east: 0.7, west: 0.2))
    }
    
    static var allTests = [
        ("testGeofenceBBox", testGeofenceBBox),
    ]
}
