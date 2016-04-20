//
//  CoffeeShopLocatorTests.swift
//  CoffeeShopLocatorTests
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoffeeShopLocator

class CoffeeShopLocatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testShopStoreCount() {
        // Create 2 shops
        let shop1 = Shop(name: "AAA",
                         address: "111",
                         phone: "",
                         distance: 200,
                         coordinates: CLLocationCoordinate2DMake(-33.827759327657603, 151.23060078319645))
        let shop2 = Shop(name: "BBB",
                         address: "222",
                         phone: "",
                         distance: 150,
                         coordinates: CLLocationCoordinate2DMake(-33.827759327657603, 151.23060078319645))
        // Update information
        ShopStore.sharedInstance.update([shop1, shop2])
        var shopsCount = ShopStore.sharedInstance.allStores.count
        // Now we should have 2 shops
        XCTAssertEqual(shopsCount, 2, "Shop store update error error!")
        
        // Remove all stores
        ShopStore.sharedInstance.update([])
        shopsCount = ShopStore.sharedInstance.allStores.count
        // Now we should not have any shops
        XCTAssertEqual(shopsCount, 0, "Shop store update error error!")
    }
    
    func testAsynchronousURLConnection() {
        let foursquare      = "https://api.foursquare.com/v2/venues/explore"
        let clientID        = "?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G"
        let clientSecret    = "&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL"
        let version         = "&v=20130815"
        let section         = "&section=coffee"
        let radius          = "&radius=400"
        let openNow         = "&openNow=1"
        let sortByDistance  = "&sortByDistance=1"
        let location = CLLocationCoordinate2DMake(-33.827759327657603, 151.23060078319645)
        
        // URL string with all necessary parameter
        let fullURL = foursquare + clientID + clientSecret + version + section + radius + sortByDistance + openNow
        let urlString = fullURL + String(format: "&ll=%f,%f", location.latitude, location.longitude)
        
        // Create URL
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? NSHTTPURLResponse {
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
        }
        task.resume()
    }
}
