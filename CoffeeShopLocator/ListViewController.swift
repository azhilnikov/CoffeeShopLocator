//
//  ListViewController.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import UIKit

private let shopCellIdentifier = "ShopCell"

class ListViewController: UIViewController, ShopStoreDelegate {
    
    @IBOutlet weak var shopsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Register cell NIB
        let nib = UINib(nibName: shopCellIdentifier , bundle: nil)
        shopsTableView.registerNib(nib, forCellReuseIdentifier: shopCellIdentifier)
        
        // Height of status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        // Height of tab bar
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: tabBarHeight, right: 0)
        shopsTableView.contentInset = insets
        shopsTableView.scrollIndicatorInsets = insets
        
        // Row height
        shopsTableView.rowHeight = 80
        
        ShopStore.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Shop store delegate
    
    func didShopStoreUpdate() {
        shopsTableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of shops
        return ShopStore.sharedInstance.allStores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let shop = ShopStore.sharedInstance.allStores[indexPath.row]
        
        // Configure cell
        let cell = tableView.dequeueReusableCellWithIdentifier(shopCellIdentifier,
                                                               forIndexPath: indexPath) as! ShopCell
        cell.nameLabel?.text = shop.name
        cell.addressLabel?.text = shop.address
        cell.distanceLabel?.text = String(format: "%d m", shop.distance)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Call the shop if it has a phone number
        let phone = ShopStore.sharedInstance.allStores[indexPath.row].phoneNumber
        
        if !phone.isEmpty {
            let alertTitle = "Call " + phone + "?"
            
            // Confirm call the shop
            let alert = UIAlertController(title: alertTitle,
                                          message: nil,
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: {(alert: UIAlertAction!) in
                    let phoneNumberURL = NSURL(string: "tel://" + phone)
                    UIApplication.sharedApplication().openURL(phoneNumberURL!)
            }))
            
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertActionStyle.Cancel,
                handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
