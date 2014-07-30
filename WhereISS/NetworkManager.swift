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
        
        //https://api.wheretheiss.at/v1/satellites/25544
        
        let url:NSURL = NSURL(string: baseURL+"satellites/"+issId)
        let session:NSURLSession = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
            if !error{
                var jsonError:NSError?
                
                // Convert response data into Dictionary
                let respDict:Dictionary<String, AnyObject> = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as Dictionary
                
                if !jsonError {
  /*
    WWDC Intermediate Swift video (session 403)
    
    func stateFromPlist(list: Dictionary<String, AnyObject>) -> State? {
        switch (list["name"], list["population"], list["abbr"]) {
        case (.Some(let listName as NSString),
            .Some(let pop as NSNumber),
            .Some(let abbr as NSString))
            where abbr.length == 2:
            return State(name: listName, population: pop, abbr: abbr)
        default:
            return nil
        }
    }
    
    // WHY AREN'T YOU WORKING?!?!
    switch(respDict["latitute"], respDict["longitude"], respDict["velocity"], respDict["altitude"]) {
        case (.Some(let lat as Double),
            .Some(let long as Double),
            .Some(let vel as Double),
            .Some(let alt as Double)):
                success(satellite: Satellite(lat: lat, lon: lon, vel: vel, alt: alt))
        default:
                failure(error: "Missing JSON in the returned response")
    }
    
    // this works
    switch(respDict["latitute"], respDict["longitude"], respDict["velocity"], respDict["altitude"]) {
        case (.Some(let lat),
            .Some(let lon),
            .Some(let vel),
            .Some(let alt)):
                success(satellite: Satellite(lat: lat as Double, lon: lon as Double, vel: vel as Double, alt: alt as Double))
        default:
                failure(error: "Missing JSON in the returned response")
    }*/
                    
                    switch(respDict["latitude"], respDict["longitude"], respDict["velocity"], respDict["altitude"]) {
                        case (.Some(let lat as NSNumber),
                            .Some(let lon as NSNumber),
                            .Some(let vel as NSNumber),
                            .Some(let alt as NSNumber)):
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