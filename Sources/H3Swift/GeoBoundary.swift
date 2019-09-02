//
//  GeoBoundary.swift
//  H3Swift
//
//  Created by Teemu Harju on 19.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension GeoBoundary {
   
    public var vertices: [GeoCoord] {
        var (gc0, gc1, gc2, gc3, gc4, gc5, gc6, gc7, gc8, gc9) = verts
        
        gc0.lat = radsToDegs(gc0.lat)
        gc0.lon = radsToDegs(gc0.lon)
        gc1.lat = radsToDegs(gc1.lat)
        gc1.lon = radsToDegs(gc1.lon)
        gc2.lat = radsToDegs(gc2.lat)
        gc2.lon = radsToDegs(gc2.lon)
        gc3.lat = radsToDegs(gc3.lat)
        gc3.lon = radsToDegs(gc3.lon)
        gc4.lat = radsToDegs(gc4.lat)
        gc4.lon = radsToDegs(gc4.lon)
        gc5.lat = radsToDegs(gc5.lat)
        gc5.lon = radsToDegs(gc5.lon)
        gc6.lat = radsToDegs(gc6.lat)
        gc6.lon = radsToDegs(gc6.lon)
        gc7.lat = radsToDegs(gc7.lat)
        gc7.lon = radsToDegs(gc7.lon)
        gc8.lat = radsToDegs(gc8.lat)
        gc8.lon = radsToDegs(gc8.lon)
        gc9.lat = radsToDegs(gc9.lat)
        gc9.lon = radsToDegs(gc9.lon)
        
        switch numVerts {
        case 0:
            return []
        case 1:
            return [gc0]
        case 2:
            return [gc0, gc1]
        case 3:
            return [gc0, gc1, gc2]
        case 4:
            return [gc0, gc1, gc2, gc3]
        case 5:
            return [gc0, gc1, gc2, gc3, gc4]
        case 6:
            return [gc0, gc1, gc2, gc3, gc4, gc5]
        case 7:
            return [gc0, gc1, gc2, gc3, gc4, gc5, gc6]
        case 8:
            return [gc0, gc1, gc2, gc3, gc4, gc5, gc6, gc7]
        case 9:
            return [gc0, gc1, gc2, gc3, gc4, gc5, gc6, gc7, gc8]
        case 10:
            return [gc0, gc1, gc2, gc3, gc4, gc5, gc6, gc7, gc8, gc9]
        default:
            fatalError()
        }
    }
}

#if canImport(CoreLocation)
import CoreLocation

extension GeoBoundary {
    public var locations: [CLLocation] {
        return vertices.map { $0.location }
    }
}
#endif

#if canImport(MapKit)
import MapKit

extension GeoBoundary {
    public var mapPoints: [MKMapPoint] {
        return locations.map { MKMapPoint($0.coordinate) }
    }
}
#endif
