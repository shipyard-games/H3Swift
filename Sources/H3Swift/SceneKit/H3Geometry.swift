//
//  H3Geometry.swift
//  H3Swift
//
//  Created by Teemu Harju on 31.8.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

#if canImport(SceneKit)
import SceneKit

extension H3.Index {
    
    func h3ToSCNGeometry() {
        self.toGeoBoundary()
    }
}
#endif
