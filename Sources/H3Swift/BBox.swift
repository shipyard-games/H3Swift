//
//  BBox.swift
//  H3Swift
//
//  Created by Teemu Harju on 1.9.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

extension H3.BBox: Equatable {
    
    public static func == (lhs: H3.BBox, rhs: H3.BBox) -> Bool {
        return lhs.north == rhs.north && lhs.east == rhs.east &&
            lhs.south == rhs.south && lhs.west == rhs.west
    }
}
