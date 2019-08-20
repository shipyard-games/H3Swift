//
//  GeoBoundary.swift
//  H3Swift
//
//  Created by Teemu Harju on 19.8.2019.
//

import h3lib

extension GeoBoundary {
   public var vertices: [GeoCoord] {
        let (gc0, gc1, gc2, gc3, gc4, gc5, gc6, gc7, gc8, gc9) = verts
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
