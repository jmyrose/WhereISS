//
//  MapViewController.swift
//  WhereISS
//
//  Created by Jackie Myrose on 6/28/14.
//  Copyright (c) 2014 jmyrose. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let networkManager:NetworkManager = NetworkManager()
    var satellite: Satellite?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var switchToStatsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        self.switchToStatsView.backgroundColor = UIColor(patternImage: UIImage(named: "tiny_grid.png"))
        
        // Load up the ISS data
        self.networkManager.loadSatelliteData(successfulDataLoad, failedDataLoad)
    }
    
    @IBAction func refreshTapped(sender: AnyObject) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.networkManager.loadSatelliteData(successfulDataLoad, failedDataLoad)
    }
    
    func successfulDataLoad(satellite:Satellite){
        self.satellite = satellite
        self.updateMapWithData(satellite.latitude, lon: satellite.longitute)
    }
    
    func failedDataLoad(error:String){
        let alert:UIAlertController = UIAlertController(title: "Error!", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "stats" {
            let statsViewController:StatsViewController = segue.destinationViewController as StatsViewController
            statsViewController.satellite = self.satellite
        }
    }
    
    // Mark where the satellite is on the map with the newly loaded data
    func updateMapWithData(lat:Double, lon:Double){
        // Set the visual map region
        let centerCoord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon);
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
        annotationView.image = UIImage(named: "iss.png")
        // Make the view smaller
        annotationView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        return annotationView
    }
}

