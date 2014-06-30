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
                    }*/
                    switch(respDict["latitute"], respDict["longitude"], respDict["velocity"], respDict["altitude"]) {
                    case (.Some(let lat), .Some(let lon), .Some(let vel), .Some(let alt)):
                        success(satellite: Satellite(lat: lat as Double, lon: lon as Double, vel: vel as Double, alt: alt as Double))
                    default:
                        failure(error: "Missing JSON in the returned response")
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