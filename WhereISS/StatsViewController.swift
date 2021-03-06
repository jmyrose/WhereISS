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
    
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitutdeLabel: UILabel!
    
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
            self.altitudeLabel.text = "No data available!"
            self.velocityLabel.text = ""
            self.latitudeLabel.text = ""
            self.longitutdeLabel.text = ""
        }
    }
    
    @IBAction func globeTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}