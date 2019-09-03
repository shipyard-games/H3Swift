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
        
        let geofence = H3.Geofence(vertices: [
            H3.GeoCoord(lat: 0.8, lon: 0.3),
            H3.GeoCoord(lat: 0.7, lon: 0.6),
            H3.GeoCoord(lat: 1.1, lon: 0.7),
            H3.GeoCoord(lat: 1.0, lon: 0.2)]
        )
        
        let bbox = geofence.bbox
        
        XCTAssertEqual(bbox, H3.BBox(north: 1.1, south: 0.7, east: 0.7, west: 0.2))
    }
    
    func testPolygon() {
        let geofence = H3.Geofence(vertices: [
            H3.GeoCoord(lat: 0.8, lon: 0.3),
            H3.GeoCoord(lat: 0.7, lon: 0.6),
            H3.GeoCoord(lat: 1.1, lon: 0.7),
            H3.GeoCoord(lat: 1.0, lon: 0.2)]
        )
        
//        let polygon = H3.GeoPolygon(geofence: geofence, numHoles: 0, holes: nil)
        
        var ptr = geofence.geofence.verts!
        
        XCTAssertEqual(ptr.pointee, H3.GeoCoord(lat: 0.8, lon: 0.3))
        
        ptr = ptr.advanced(by: 1)
        
        XCTAssertEqual(ptr.pointee, H3.GeoCoord(lat: 0.7, lon: 0.6))
        
        ptr = ptr.advanced(by: 1)
        
        XCTAssertEqual(ptr.pointee, H3.GeoCoord(lat: 1.1, lon: 0.7))
        
        ptr = ptr.advanced(by: 1)
        
        XCTAssertEqual(ptr.pointee, H3.GeoCoord(lat: 1.0, lon: 0.2))
    }
    
    func testPolyfill() {
//        let geoPolygon = H3.GeoPolygon(verts: [
//            H3.GeoCoord(lat: 24.94021744781594, lon: 60.14783793888228),
//            H3.GeoCoord(lat: 24.870179606019065, lon:60.13937761616308),
//            H3.GeoCoord(lat: 24.8363623147593, lon: 60.1595420688616),
//            H3.GeoCoord(lat: 24.845975351868674, lon: 60.20008982281753),
//            H3.GeoCoord(lat: 24.98742432647805, lon: 60.209728549946284),
//            H3.GeoCoord(lat: 24.995320749817893, lon: 60.170388161455854),
//            H3.GeoCoord(lat: 24.94021744781594, lon: 60.14783793888228)
//        ])
        
        let coords = [H3.GeoCoord(latDegs: 24.938035389296715, lonDegs: 60.16617037580286),
                      H3.GeoCoord(latDegs: 24.939344307295983, lonDegs: 60.16517759542684),
                      H3.GeoCoord(latDegs: 24.94164027821273, lonDegs: 60.16596755214254),
                      H3.GeoCoord(latDegs: 24.940331360213463, lonDegs: 60.16694429668797),
                      H3.GeoCoord(latDegs: 24.938035389296715, lonDegs: 60.16617037580286)]
        
//        let geoPolygon = H3.GeoPolygon(verts: coords)
//        
//        let indices = geoPolygon.polyfill(resolution: 12)
//        
//        XCTAssertTrue(indices.count > 0)
    }
    
    static var allTests = [
        ("testGeofenceBBox", testGeofenceBBox),
        ("testPolyfill", testPolyfill),
    ]
}
