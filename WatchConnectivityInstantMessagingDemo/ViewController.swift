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
    @IBOutlet weak var currentHeartRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateLabel(notification:)), name: Notification.Name(rawValue: WatchMessageNotifiation), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateHeartLabel(notification:)), name: Notification.Name(rawValue: WatchHeartRateNotification), object: nil)
        
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
    
    func updateHeartLabel(notification: Notification) {
        let userInfo = notification.userInfo
        
        if let hr = userInfo?["heart_rate"] as? Double {
            DispatchQueue.main.async {
                self.currentHeartRateLabel.text = "\(hr)"
            }
        }
    }

}

