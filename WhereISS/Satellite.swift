//
//  Satellite.swift
//  WhereISS
//
//  Created by Jackie Myrose on 6/28/14.
//  Copyright (c) 2014 jmyrose. All rights reserved.
//

import Foundation

class Satellite {
    let latitude: Double
    let longitute: Double
    let velocity: Double
    let altitude: Double
    
    init(lat:Double, lon:Double, vel:Double, alt:Double) {
        latitude = lat
        longitute = lon
        velocity = vel
        altitude = alt
    }
}