//
//  ViewController.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-29.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var watchUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateLabel(notification:)), name: Notification.Name(rawValue: WatchMessageNotifiation), object: nil)
        
        let healthService: HealthDataService = HealthDataService()
        healthService.authorizeHealthKitAccess { (success, error) in
            DispatchQueue.main.async {
                if success {
                    print("success healthkit authorization: \(ViewController.self)")
                } else {
                    print("HealthKit authorization denied! \n\(error)")
            
                }
            }
        }
    }
    
    func updateLabel(notification: Notification) {
        let userInfo = notification.userInfo
        
        if let message = userInfo?["message"] as? Float {
            DispatchQueue.main.async(execute: { 
                self.watchUpdateLabel.text = "\(message)"
            })
        }
    }

}

