//
//  Shop.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import Foundation
import CoreLocation

class Shop: NSObject {
    
    // Shop name
    let name: String
    // Shop address
    let address: String
    // Phone number
    let phoneNumber: String
    // Distance to the shop from current location
    let distance: Int
    // Shop coordinates
    let coordinates: CLLocationCoordinate2D
    
    init(name: String, address: String, phone: String, distance: Int, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.phoneNumber = phone
        self.distance = distance
        self.coordinates = coordinates
        super.init()
    }
    
    convenience override init() {
        self.init(name: "", address: "", phone: "", distance: 0, coordinates: CLLocationCoordinate2DMake(0, 0))
    }
}
