//
//  H3.swift
//  H3Swift
//
//  Created by Teemu Harju on 31.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

public class H3 {
    
    public typealias GeoCoord = h3lib.GeoCoord
    public typealias GeoPolygon = h3lib.GeoPolygon
    public typealias GeoBoundary = h3lib.GeoBoundary
    public typealias Index = h3lib.H3Index
    public typealias BBox = h3lib.BBox
    
    class Geofence {
        
        var vertices: [H3.GeoCoord]
        var geofence: h3lib.Geofence
        
        init(vertices: [H3.GeoCoord]) {
            self.vertices = vertices
            self.geofence = h3lib.Geofence(numVerts: Int32(vertices.count), verts: &self.vertices)
        }
    }
}
