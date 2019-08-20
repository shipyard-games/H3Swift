//
//  GeoCoord.swift
//  H3Swift
//
//  Created by Teemu Harju on 19.8.2019.
//

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
