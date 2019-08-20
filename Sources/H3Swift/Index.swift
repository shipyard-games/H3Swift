import Foundation

import h3lib

extension H3.Index {

    // MARK: Indexing functions
    
    public var hex: String {
        return String(format: "%#llx", self)
    }

    /**
     Indexes the location at the specified resolution, returning the index of the cell containing the location.

     Returns 0 on error.
     */
    public static func geoToH3(_ geoCoord: H3.GeoCoord, resolution: Int32) -> H3.Index {
        var geoCoord = geoCoord
        return h3lib.geoToH3(&geoCoord, resolution)
    }

    /**
     Finds the centroid of the index.
     */
    public func h3ToGeo() -> H3.GeoCoord {
        var geoCoord = H3.GeoCoord()
        h3lib.h3ToGeo(self, &geoCoord)
        return geoCoord
    }
    
    /**
     Finds the boundary of the index.
     */
    public func h3ToGeoBoundary() -> H3.GeoBoundary {
        var geoBoundary = H3.GeoBoundary()
        h3lib.h3ToGeoBoundary(self, &geoBoundary)
        return geoBoundary
    }
    
    // MARK: Index inspection functions
    
    /**
     Returns the resolution of the index.
     */
    public func h3GetResolution() -> Int32 {
        return h3lib.h3GetResolution(self)
    }
    
    /**
     Returns the base cell number of the index.
     */
    public func h3GetBaseCell() -> Int32 {
        return h3lib.h3GetBaseCell(self)
    }
    
    // MARK: Grid traversal functions
    
    /**
     k-rings produces indices within k distance of the origin index.

     k-ring 0 is defined as the origin index, k-ring 1 is defined as k-ring 0 and all neighboring indices, and so on.

     Output is placed in the provided array in no particular order. Elements of the output array may be left zero, as can happen when crossing a pentagon.
     */
    public func kRing(k: Int32) -> [H3.Index] {
        let maxIndices = Int(H3.Index.maxKringSize(k))
        
        let indicesPtr = UnsafeMutablePointer<H3.Index>.allocate(capacity: maxIndices)
        h3lib.kRing(self, k, indicesPtr)
        
        let indices = Array(UnsafeMutableBufferPointer(start: indicesPtr, count: maxIndices))
        
        indicesPtr.deallocate()
        
        return indices
    }
    
    public static func maxKringSize(_ k: Int32) -> Int32 {
        return h3lib.maxKringSize(k)
    }
}

extension H3.Index: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return self.hex
    }
}

#if canImport(CoreLocation)
import CoreLocation

extension H3.Index {
    public func h3ToCLLocation() -> CLLocation {
        let geoCoord = self.h3ToGeo()
        return CLLocation(latitude: geoCoord.lat, longitude: geoCoord.lon)
    }
}

#endif

#if canImport(MapKit)
import MapKit

extension H3.Index {
    public func h3ToMKPolygon() -> MKPolygon {
        let boundary = self.h3ToGeoBoundary()
        let points = boundary.mapPoints
        return MKPolygon(points: points, count: points.count)
    }
}
#endif
