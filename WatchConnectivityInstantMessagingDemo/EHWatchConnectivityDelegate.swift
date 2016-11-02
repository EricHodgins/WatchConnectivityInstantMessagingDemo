//
//  EHWatchConnectivityDelegate.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-29.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import WatchConnectivity

class EHWatchConnectivityDelegate: NSObject, WCSessionDelegate {
    
    override init() {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session deactivated.")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session error: \(error.localizedDescription)")
            return
        }
        
        print("Session activated, state: \(activationState.rawValue)")
    }
    
    //MARK: - Instant Messaging
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let sliderValue = message["message"] as? Float {
            print("\(sliderValue)")
            let userInfo = ["message" : sliderValue]
            NotificationCenter.default.post(name: Notification.Name(rawValue: WatchMessageNotifiation), object: nil, userInfo: userInfo)
        }
        
        if let heartRate = message["heart_rate"] as? Double {
            print("Got the heart rate: \(heartRate)")
            let userInfo = ["heart_rate" : heartRate]
            NotificationCenter.default.post(name: Notification.Name(rawValue: WatchHeartRateNotification), object: nil, userInfo: userInfo)
        }
    }
}
