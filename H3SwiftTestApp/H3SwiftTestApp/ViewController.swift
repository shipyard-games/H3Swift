//
//  ViewController.swift
//  H3SwiftTestApp
//
//  Created by Teemu Harju on 1.9.2019.
//  Copyright © 2019 Shipyard Games Oy. All rights reserved.
//

import Cocoa

import MapKit
import H3Swift

class ViewController: NSViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let center = CLLocationCoordinate2D(latitude: 60.171132, longitude: 24.946499)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let centerIndex = center.toH3GeoCoord().toH3(resolution: 11)
        let neighborIndices = centerIndex.kRing(k: 10)
        
        for neighborIndex in neighborIndices {
            mapView.insertOverlay(H3Cell(withIndex: neighborIndex), at: 0)
        }
        
        let parentIndex = centerIndex.toParent(resolution: 10)
        let parentNeighborIndices = parentIndex.kRing(k: 10)
        for parentNeighborIndex in parentNeighborIndices {
            mapView.insertOverlay(H3Cell(withIndex: parentNeighborIndex), at: 0)
        }
        
        let grandparentIndex = centerIndex.toParent(resolution: 9)
        let grandparentNeighborIndices = grandparentIndex.kRing(k: 10)
        for grandparentNeighborIndex in grandparentNeighborIndices {
            mapView.insertOverlay(H3Cell(withIndex: grandparentNeighborIndex), at: 0)
        }
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = center
        mapCamera.pitch = 75.0
        mapCamera.altitude = 50.0
        mapCamera.heading = 0.0

        mapView.camera = mapCamera
        
        mapView.appearance = NSAppearance(named: .darkAqua)
    }
    
    override func viewDidAppear() {}

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? H3Cell {
            let renderer = H3CellOverlayView(withIndex: overlay.index)
            renderer.fillColor = .clear
            renderer.strokeColor = strokeColor(forResolution: overlay.index.resolution)
            renderer.lineWidth = lineWidth(forResolution: overlay.index.resolution)
            return renderer
        } else if let overlay = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: overlay as MKCircle)
            renderer.fillColor = NSColor(deviceRed: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    private func strokeColor(forResolution resolution: Int32) -> NSColor {
        switch resolution {
        case 11:
            return .red
        case 10:
            return .green
        case 9:
            return .blue
        default:
            fatalError()
        }
    }
    
    private func lineWidth(forResolution resolution: Int32) -> CGFloat {
        switch resolution {
        case 11:
            return 4.0
        case 10:
            return 4.0
        case 9:
            return 4.0
        default:
            fatalError()
        }
    }
}

