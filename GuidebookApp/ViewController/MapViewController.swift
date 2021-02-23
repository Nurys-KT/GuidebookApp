//
//  MapViewController.swift
//  GuidebookApp
//
//  Created by KYUNGTAE KIM on 2021/02/19.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // Mapkit import
    @IBOutlet weak var placeMapView: MKMapView!
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        if place != nil {
            
            // Create a CLLocationCoordinate2D
            let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            
            // create a pin
            let pin = MKPointAnnotation()
            pin.coordinate = location
            
            // Add it to the map
            placeMapView.addAnnotation(pin)
            
            // Create a region to zoom to
            // 중앙위치, 주변에 보여줄 정도 (100)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            
            placeMapView.setRegion(region, animated: false)
        }
    }

}
