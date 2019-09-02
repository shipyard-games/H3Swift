//
//  GeoCoord.swift
//  H3Swift
//
//  Created by Teemu Harju on 19.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension H3.GeoCoord {
    
    /**
     Indexes the location at the specified resolution, returning the index of the cell containing the location.
     
     Returns 0 on error.
     */
    public func toH3(resolution: Int32) -> H3.Index {
        var geoCoord = self
        geoCoord.lat = h3lib.degsToRads(geoCoord.lat)
        geoCoord.lon = h3lib.degsToRads(geoCoord.lon)
        
        return h3lib.geoToH3(&geoCoord, resolution)
    }
}

extension H3.GeoCoord: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "H3.GeoCoord(lat: \(lat), lon: \(lon))"
    }
}

extension H3.GeoCoord: Equatable {
    public static func == (lhs: GeoCoord, rhs: GeoCoord) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
}

#if canImport(CoreLocation)
import CoreLocation

extension H3.GeoCoord {
    
    public var location: CLLocation {
        return CLLocation(latitude: lat, longitude: lon)
    }
}
#endif

#if canImport(MapKit)
import MapKit

extension H3.GeoCoord {
    public var mapPoint: MKMapPoint {
        return MKMapPoint(location.coordinate)
    }
}
#endif
