//
//  ViewController.swift
//  WhereISS
//
//  Created by Jackie Myrose on 6/28/14.
//  Copyright (c) 2014 jmyrose. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let networkManager:NetworkManager = NetworkManager()
    var satellite: Satellite?
    
    @IBOutlet var mapView: MKMapView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        self.networkManager.loadSatelliteData({
            (satellite) in
            self.satellite = satellite
            self.updateMapWithData(self.satellite!)
        }, {
            (error) in
            let alert:UIAlertController = UIAlertController(title: "Error!", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    // Mark where the satellite is on the map with the newly loaded data
    func updateMapWithData(satellite:Satellite){
        // Set the visual map region
        let centerCoord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: satellite.latitude, longitude: satellite.longitute);
        let viewRegion:MKCoordinateRegion = MKCoordinateRegion(center: centerCoord, span: MKCoordinateSpanMake(50, 50))
        mapView.setRegion(viewRegion, animated: true)
        
        // Pin the station
        let annotation:MKPointAnnotation = MKPointAnnotation()
        annotation.setCoordinate(centerCoord)
        mapView.addAnnotation(annotation)
    }
    
    
    /** MKMapViewDelegate method(s) **/
    
    // Make the annotation point a picture of the ISS
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        let annotationView:MKAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.image = UIImage(named: "iss_pic.png")
        // Make the view smaller
        annotationView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        return annotationView
    }
}

