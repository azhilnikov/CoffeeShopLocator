//
//  ShopStore.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol ShopStoreDelegate {
    func didShopStoreUpdate()
}

// Singleton containing shops sorted by distance in ascending order
class ShopStore {
    
    static let sharedInstance = ShopStore()
    
    var delegate: ShopStoreDelegate?
    
    // Array containing discovered shops
    private(set) var allStores = [Shop]()
    
    // Update records
    func update(shops: [Shop]) {
        self.clear()
        for shop in shops {
            allStores.append(shop)
        }
        
        // Call delegate
        self.delegate?.didShopStoreUpdate()
    }
    
    private func clear() {
        // Remove all items
        allStores.removeAll()
    }
}
