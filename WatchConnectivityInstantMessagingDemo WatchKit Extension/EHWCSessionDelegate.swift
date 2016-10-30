//
//  EHWCSessionDelegate.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-29.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import WatchConnectivity

class EHWCSessionDelegate: NSObject, WCSessionDelegate {
    
    override init() {
        
    }
 
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
            return
        }
        
        print("Session activation with state: \(activationState.rawValue)")
    }
    
    //MARK: - Instant Messaging

}
