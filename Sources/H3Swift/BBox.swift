//
//  BBox.swift
//  H3Swift
//
//  Created by Teemu Harju on 1.9.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import h3lib

extension H3.BBox: Equatable {
    
    public static func == (lhs: H3.BBox, rhs: H3.BBox) -> Bool {
        return lhs.north == rhs.north && lhs.east == rhs.east &&
            lhs.south == rhs.south && lhs.west == rhs.west
    }
    
    public func hexRadius(resolution: Int32) -> Int32 {
        var bbox = self
        return h3lib.bboxHexRadius(&bbox, resolution)
    }
}
