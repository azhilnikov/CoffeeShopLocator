//
//  Server.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import CoreLocation

private let foursquare      = "https://api.foursquare.com/v2/venues/explore"
private let clientID        = "?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G"
private let clientSecret    = "&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL"
private let version         = "&v=20130815"
private let section         = "&section=coffee"
private let radius          = "&radius=400"
private let openNow         = "&openNow=1"
private let sortByDistance  = "&sortByDistance=1"

// URL string with all necessary parameter (except coordinates of current location)
private let fullURL = foursquare + clientID + clientSecret + version + section + radius + sortByDistance + openNow

class Server {
    
    // Configure default URL session
    private static let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    class func fetchShops(location: CLLocationCoordinate2D) {
        // Add coordinates of current location to URL string
        let urlString = fullURL + String(format: "&ll=%f,%f", location.latitude, location.longitude)
        
        // Create URL
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        // Create a request
        let request = NSURLRequest(URL: url)
        
        // Create task, send a request
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            // Check response
            if let requestError = error {
                // Error
                print(requestError.localizedDescription)
            }
            else if let jsonData = data {
                // Parse JSON
                Json.parseData(jsonData)
            }
            else {
                print("Unknown error")
            }
        }
        task.resume()
    }
}
