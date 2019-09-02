//
//  CoreLocation.swift
//  H3Swift
//
//  Created by Teemu Harju on 31.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

#if canImport(CoreLocation)
import CoreLocation

extension CLLocation {
   
    public func toH3(resolution: Int32) -> H3.Index {
        return self.coordinate.toH3(resolution: resolution)
    }
}

extension CLLocationCoordinate2D {
    
    public func toH3(resolution: Int32) -> H3.Index {
        let geoCoord = H3.GeoCoord(lat: self.latitude, lon: self.longitude)
        return geoCoord.toH3(resolution: resolution)
    }
    
    public func toH3GeoCoord() -> H3.GeoCoord {
         return H3.GeoCoord(lat: latitude, lon: longitude)
     }
}

extension H3.Index {
    
    public func toCLLocation() -> CLLocation {
        let geoCoord = self.toGeo()
        return CLLocation(latitude: geoCoord.lat, longitude: geoCoord.lon)
    }
    
    public func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        let geoCoord = self.toGeo()
        return CLLocationCoordinate2D(latitude: geoCoord.lat, longitude: geoCoord.lon)
    }
}
#endif
