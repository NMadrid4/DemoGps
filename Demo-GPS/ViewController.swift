//
//  ViewController.swift
//  Demo-GPS
//
//  Created by Nicolas on 4/08/18.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var sampleMapView: MKMapView!
    let locationManager = CLLocationManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    
    @IBAction func getMyLocation(_ sender: Any) {
        //dispara didUpadateLocation(Implementado en la extension)
        locationManager.startUpdatingLocation()
    }
    
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat),\(long)")
            
            let span = MKCoordinateSpanMake(0.015, 0.025)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
            sampleMapView.setRegion(region, animated: true)
            
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            annotation.coordinate = centerCoordinate
            annotation.title = "I am Here"
            sampleMapView.addAnnotation(annotation)
            
            locationManager.stopUpdatingLocation()
        }else {
            print("no coordinates")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)        
    }
    
}

