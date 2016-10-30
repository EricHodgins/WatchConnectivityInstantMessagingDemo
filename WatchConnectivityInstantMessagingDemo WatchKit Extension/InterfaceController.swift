//
//  InterfaceController.swift
//  WatchConnectivityInstantMessagingDemo WatchKit Extension
//
//  Created by Eric Hodgins on 2016-10-29.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var slider: WKInterfaceSlider!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
    }
    
    func repeatingBackgroundTest(_ numberOfTests: Int) {
        if numberOfTests != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
                print("Repeating task: \(numberOfTests)")
                self.repeatingBackgroundTest(numberOfTests - 1)
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func sliderUpdated(_ value: Float) {
        print(value)
        if WCSession.isSupported() {
            let session = WCSession.default()
            
            if session.isReachable {
                let message = ["message": value]
                
                session.sendMessage(message, replyHandler: nil, errorHandler: { (error) in
                    print("ERROR: sendMessage error - \(error.localizedDescription)")
                })
                
            }
            
        }
    }
}
