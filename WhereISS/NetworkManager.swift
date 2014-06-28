//
//  NetworkManager.swift
//  WhereISS
//
//  Created by Jackie Myrose on 6/28/14.
//  Copyright (c) 2014 jmyrose. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let baseURL = "https://api.wheretheiss.at/v1/"
    let issId = "25544"
    
    func loadSatelliteData(success: (satellite :Satellite) -> (), failure: (error: String) -> ()){
        
        let url:NSURL = NSURL(string: baseURL+"satellites/"+issId)
        let session:NSURLSession = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
            if !error{
                var jsonError:NSError?
                
                // Convert response data into Dictionary
                let respDict:Dictionary<String, AnyObject> = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as Dictionary
                
                if !jsonError {
                    // WHY AREN'T YOU WORKING?!?!
                    /*switch(respDict["latitute"], respDict["longitude"], respDict["velocity"], respDict["altitude"]) {
                    case (.Some(let lat as Double),
                    .Some(let long as Double),
                    .Some(let vel as Double),
                    .Some(let alt as Double)):
                    println("ALL GOOD!")
                    default:
                    println("MISSING JSON ERROR!")
                    //TODO - error
                    }*/
                    
                    if let latObj : AnyObject = respDict["latitude"] {
                        let latitude = latObj as Double
                        if let longObj : AnyObject = respDict["longitude"] {
                            let longitude = longObj as Double
                            if let velObj : AnyObject = respDict["velocity"] {
                                let velocity = velObj as Double
                                if let altObj : AnyObject = respDict["altitude"] {
                                    let altitude = altObj as Double
                                    
                                    success(satellite: Satellite(lat: latitude, long: longitude, vel: velocity, alt: altitude))
                                }
                            }
                        }
                    }
                    
                } else {
                    failure(error: "Error parsing the returned JSON")
                }
                
            } else {
                failure(error: error.description)
            }
            
        }).resume()
    }
}