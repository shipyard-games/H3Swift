//
//  Geofence.swift
//  H3Swift
//
//  Created by Teemu Harju on 15.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension H3.Geofence {
    
    public var bbox: H3.BBox {
        var bbox = H3.BBox()
        h3lib.bboxFromGeofence(&geofence, &bbox)
        return bbox
    }
}
