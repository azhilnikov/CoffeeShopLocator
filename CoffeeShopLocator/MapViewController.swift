//
//  MapViewController.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import MapKit

// Fetch information from server every 15 seconds
private let updateTimerInterval = 15.0

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    // Coordinates of current location
    private var currentLocation: CLLocationCoordinate2D?
    private weak var updateTimer: NSTimer?
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Configure location manager
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        ShopStore.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func myLocationButtonTapped(sender: UIButton) {
        if let location = currentLocation {
            // Show my current location
            moveToLocation(location)
        }
    }
    
    // MARK: - Core location delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location?.coordinate {
            if nil == currentLocation {
                // Show my current location
                moveToLocation(location)
                mapView.showsUserLocation = true
                
                // Update information
                Server.fetchShops(location)
                
                // Run timer for 15 seconds
                updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateTimerInterval,
                                                                     target: self,
                                                                     selector: #selector(updateTimerTimeout),
                                                                     userInfo: nil,
                                                                     repeats: true)
            }
            currentLocation = location
        }
    }
    
    // MARK: - Private methods
    
    @objc private func updateTimerTimeout() {
        if let location = currentLocation {
            // Update information
            Server.fetchShops(location)
        }
    }
    
    private func moveToLocation(location: CLLocationCoordinate2D) {
        // Show region around current location
        let region = MKCoordinateRegionMakeWithDistance(location, 800, 800)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate, ShopStoreDelegate {
    
    // MARK: - Shop store delegate
    
    func didShopStoreUpdate() {
        for shop in ShopStore.sharedInstance.allStores {
            // Create annotation and add it to map
            let pin = MKPointAnnotation()
            pin.coordinate = shop.coordinates
            pin.title = shop.name
            mapView.addAnnotation(pin)
        }
    }
}
