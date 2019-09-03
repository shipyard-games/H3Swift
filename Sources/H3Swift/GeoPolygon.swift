//
//  GeoPolygon.swift
//  H3Swift
//
//  Created by Teemu Harju on 1.9.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension H3.GeoPolygon {
    
//    public init(verts: [H3.GeoCoord]) {
//        let geofence = H3.Geofence(vertices: verts)
//        self.init(geofence: geofence, numHoles: 0, holes: nil)
//    }
    
    public func maxPolyfillSize(resolution: Int32) -> Int32 {
        var geoPolygon = self
        return h3lib.maxPolyfillSize(&geoPolygon, resolution)
    }
    
    public func polyfill(resolution: Int32) -> [H3.Index] {
        var geoPolygon = self
        let maxIndices = Int(self.maxPolyfillSize(resolution: resolution))
        
        let indicesPtr = UnsafeMutablePointer<H3.Index>.allocate(capacity: maxIndices)
        h3lib.polyfill(&geoPolygon, resolution, indicesPtr)
        
        let indices = Array(UnsafeMutableBufferPointer(start: indicesPtr, count: maxIndices))
        
        indicesPtr.deallocate()
        
        return indices.filter { $0 != 0 }
    }
}
