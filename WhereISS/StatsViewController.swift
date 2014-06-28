//
//  StatsViewController.swift
//  WhereISS
//
//  Created by Jackie Myrose on 6/28/14.
//  Copyright (c) 2014 jmyrose. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var satellite:Satellite?
    
    @IBOutlet var altitudeLabel: UILabel
    @IBOutlet var velocityLabel: UILabel
    @IBOutlet var latitudeLabel: UILabel
    @IBOutlet var longitutdeLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "tiny_grid.png"))
        
        if let sat:Satellite = self.satellite {
            // Round the values to just 2 decimal places
            self.altitudeLabel.text = "Altitude: " + NSString(format:"%.2f", sat.altitude) + " km"
            self.velocityLabel.text = "Velocity: " + NSString(format:"%.2f", sat.velocity) + " km/hr"
            self.latitudeLabel.text = "Latitude: " + NSString(format:"%.2f", sat.latitude)
            self.longitutdeLabel.text = "Longitude: " + NSString(format:"%.2f", sat.longitute)
        } else {
            println("No sat...")
        }
    }
    @IBAction func globeTapped(sender: AnyObject) {
        self.dismissModalViewControllerAnimated(true)
    }
    
}