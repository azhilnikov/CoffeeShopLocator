//
//  Json.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import CoreLocation

private let kJSONResponse   = "response"
private let kJSONGroups     = "groups"
private let kJSONItems      = "items"
private let kJSONVenue      = "venue"
private let kJSONName       = "name"
private let kJSONLocation   = "location"
private let kJSONAddress    = "address"
private let kJSONDistance   = "distance"
private let kJSONLatitude   = "lat"
private let kJSONLongitude  = "lng"
private let kJSONContact    = "contact"
private let kJSONPhone      = "phone"

class Json {
    
    class func parseData(data: NSData) {
        do {
            // Parse JSON data
            let jsonData = try NSJSONSerialization
                .JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
            
            if let response = jsonData[kJSONResponse] as? NSDictionary,
                let groups = response[kJSONGroups] as? NSArray,
                let group = groups[0] as? NSDictionary,
                let items = group[kJSONItems] as? NSArray {
                
                    var shops = [Shop]()
                    
                    for item in items {
                        if let value = item as? NSDictionary,
                            let venue = value[kJSONVenue] as? NSDictionary,
                            let name = venue[kJSONName] as? String,
                            let location = venue[kJSONLocation] as? NSDictionary,
                            let address = location[kJSONAddress] as? String,
                            let distance = location[kJSONDistance] as? Int,
                            let latitude = location[kJSONLatitude] as? Double,
                            let longitude = location[kJSONLongitude] as? Double {
                                var phoneNumber = ""
                                if let contact = venue[kJSONContact] as? NSDictionary,
                                    let phone = contact[kJSONPhone] as? String {
                                    phoneNumber = phone
                                }
                                // We have all necessary information
                                let shop = Shop(name: name,
                                                address: address,
                                                phone: phoneNumber,
                                                distance: distance,
                                                coordinates: CLLocationCoordinate2DMake(latitude, longitude))
                                shops.append(shop)
                    }
                }
                
                if !shops.isEmpty {
                    // Update store if there are new data
                    ShopStore.sharedInstance.update(shops)
                }
            }
        }
        catch let jsonError as NSError {
            print("JSON parsing error: " + "\(jsonError.localizedDescription)")
        }
    }
}
