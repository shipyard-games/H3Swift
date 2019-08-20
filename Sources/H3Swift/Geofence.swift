//
//  Geofence.swift
//  H3Swift
//
//  Created by Teemu Harju on 15.8.2019.
//

extension H3.Geofence {
    
    public init(verts: [H3.GeoCoord]) {
        assert(verts.count < Int32.max)
        var verts = verts
        self.init(numVerts: Int32(verts.count), verts: &verts)
    }
}
