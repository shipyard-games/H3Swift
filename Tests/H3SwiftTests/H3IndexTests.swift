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
        
        let geoCoord = H3.GeoCoord(latDegs: 40.689167, lonDegs: -74.044444)
        let index = geoCoord.toH3(resolution: 5)
        
        XCTAssertEqual(index.hexString, "0x852a1073fffffff")
    }
    
    func testIndexToGeoCoord() {
        let geoCoord1 = H3.GeoCoord(latDegs: 40.72057966485312, lonDegs: -74.09152905917784)
        let index = geoCoord1.toH3(resolution: 5)
        
        let geoCoord2 = index.toGeo()
        
        XCTAssertEqual(geoCoord1.lat, geoCoord2.lat, accuracy: 0.000000001)
        XCTAssertEqual(geoCoord1.lon, geoCoord2.lon, accuracy: 0.000000001)
    }
    
    func testRandomCellCenters() {
        let geoCoord1 = H3.GeoCoord(latDegs: 10.752074718, lonDegs: 345.714683533)
        XCTAssertEqual(geoCoord1.toH3(resolution: 15).hexString, "0x8f54c4b5391d296")
        
        let geoCoord2 = H3.GeoCoord(latDegs: -27.384130955, lonDegs: 298.040864468)
        XCTAssertEqual(geoCoord2.toH3(resolution: 15).hexString, "0x8fb2657092a5ca1")
        
        let geoCoord3 = H3.GeoCoord(latDegs: -65.478402972, lonDegs: 111.465804577)
        XCTAssertEqual(geoCoord3.toH3(resolution: 15).hexString, "0x8fe5098d5d75d5c")
        
        let geoCoord4 = H3.GeoCoord(latDegs: -3.635374904, lonDegs: 155.61553359)
        XCTAssertEqual(geoCoord4.toH3(resolution: 15).hexString, "0x8f76a1cc64caa8a")
    }
    
    func testToParentToChildren() {
        let geoCoord = H3.GeoCoord(latDegs: 40.72057966485312, lonDegs: -74.09152905917784)
        let index = geoCoord.toH3(resolution: 10)
        
        XCTAssertEqual(0x8a2a10700007fff, index)
        
        let parent = index.toParent(resolution: 9)
        XCTAssertEqual(parent, 0x892a1070003ffff)
        
        let children = parent.toChildren(resolution: 10)
        XCTAssertEqual(children.count, 7)
        XCTAssertTrue(children.contains(index))
        
        XCTAssertEqual(parent.toChildren(resolution: 9).count, 0)
        XCTAssertEqual(parent.toChildren(resolution: 8).count, 0)
    }
    
    func testIndexFromString() {
        let h3String = "0x8aa8a0634027fff"
        let h3Index = H3.Index.from(string: h3String)!
        
        XCTAssertEqual(h3String, h3Index.hexString)
    }
    
    func testLine() {
        let start: H3.Index = 0x8a08866032cffff
        let end: H3.Index = 0x8a088661d467fff
        
        let line = start.line(to: end)
        
        XCTAssertTrue(line.count != 0)
        
        XCTAssertEqual(line.first!, start)
        XCTAssertEqual(line.last!, end)
        
        let correctLine: [UInt64] = [
            0x8a08866032cffff, 0x8a088661d967fff, 0x8a088661d977fff, 0x8a088661d957fff, 0x8a088661d82ffff,
            0x8a088661d807fff, 0x8a088661d81ffff, 0x8a088661d8f7fff, 0x8a088661d88ffff, 0x8a088661d127fff,
            0x8a088661d137fff, 0x8a088661d117fff, 0x8a088661d1affff, 0x8a088661d187fff, 0x8a088661d19ffff,
            0x8a088661d0b7fff, 0x8a088661d54ffff, 0x8a088661d467fff]
        
        XCTAssertEqual(line, correctLine)
    }
    
    static var allTests = [
        ("testGeoCoordToIndex", testGeoCoordToIndex),
        ("testIndexToGeoCoord", testIndexToGeoCoord),
        ("testRandomCellCenters", testRandomCellCenters)
    ]
}

