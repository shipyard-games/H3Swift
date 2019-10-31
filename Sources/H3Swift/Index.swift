//
//  Index.swift
//  H3Swift
//
//  Created by Teemu Harju on 31.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension H3.Index {

    public var hexString: String {
        return String(format: "%#llx", self)
    }
    
    public static func from(string: String) -> H3.Index? {
        let scanner = Scanner(string: string)
        var h3Index: UInt64 = 0
        if scanner.scanHexInt64(&h3Index) {
            return h3Index
        }
        return nil
    }

    /**
     Finds the centroid of the index.
     */
    public func toGeo() -> H3.GeoCoord {
        var geoCoord = H3.GeoCoord()
        h3lib.h3ToGeo(self, &geoCoord)
        return geoCoord
    }
    
    /**
     Finds the boundary of the index.
     */
    public func toGeoBoundary() -> H3.GeoBoundary {
        var geoBoundary = H3.GeoBoundary()
        h3lib.h3ToGeoBoundary(self, &geoBoundary)
        return geoBoundary
    }
    
    // MARK: Index inspection functions
    
    /**
     Returns the resolution of the index.
     */
    public var resolution: Int32 {
        return h3lib.h3GetResolution(self)
    }
    
    /**
     Returns the base cell number of the index.
     */
    public var baseCell: Int32 {
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
    
    public func toParent(resolution: Int32) -> H3.Index {
        return h3lib.h3ToParent(self, resolution)
    }
    
    public func toChildren(resolution: Int32) -> [H3.Index] {
        if self.resolution >= resolution {
            return []
        }
        
        let resolutionSteps = resolution - self.resolution
        let childCount = Int(resolutionSteps * 7)
        
        let indicesPtr = UnsafeMutablePointer<H3.Index>.allocate(capacity: childCount)
        h3lib.h3ToChildren(self, resolution, indicesPtr)
        
        let indices = Array(UnsafeMutableBufferPointer(start: indicesPtr, count: childCount))
        
        indicesPtr.deallocate()
        
        return indices
    }
}

extension H3.Index: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return self.hexString
    }
}

#if canImport(MapKit)
import MapKit

extension H3.Index {
    
    public func h3ToMKPolygon() -> MKPolygon {
        let boundary = self.toGeoBoundary()
        let points = boundary.mapPoints
        return MKPolygon(points: points, count: points.count)
    }
    
    public func boundingMapRect() -> MKMapRect {
        let geoBoundary = self.toGeoBoundary()
        let geoFence = H3.Geofence(vertices: geoBoundary.vertices)
        let bbox = geoFence.bbox
        
        let nwPoint = MKMapPoint(CLLocationCoordinate2D(latitude: bbox.north, longitude: bbox.west))
        let sePoint = MKMapPoint(CLLocationCoordinate2D(latitude: bbox.south, longitude: bbox.east))
        
        return MKMapRect(x: fmin(nwPoint.x, sePoint.x), y: fmin(nwPoint.y, sePoint.y),
                         width: fabs(nwPoint.x - sePoint.x), height: fabs(nwPoint.y - sePoint.y))
    }
}

public class H3Cell: NSObject, MKOverlay {
    
    public let coordinate: CLLocationCoordinate2D
    public let boundingMapRect: MKMapRect
    public let index: H3.Index
    
    public init(withIndex index: H3.Index) {
        self.index = index
        self.coordinate = index.toGeo().location.coordinate
        self.boundingMapRect = index.boundingMapRect()
    }
}

public class H3CellOverlayView: MKPolygonRenderer {
    
    public let index: H3.Index
    
    public init(withIndex index: H3.Index) {
        self.index = index
        
        var points = index.toGeoBoundary().mapPoints
        let overlay = MKPolygon(points: &points, count: points.count)
        
        super.init(overlay: overlay)
    }
}
#endif

