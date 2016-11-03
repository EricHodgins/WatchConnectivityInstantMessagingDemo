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
import HealthKit


class InterfaceController: WKInterfaceController {

    @IBOutlet var slider: WKInterfaceSlider!
    @IBOutlet var workoutSwitchControl: WKInterfaceSwitch!
    
    lazy var configuration: HKWorkoutConfiguration = {
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .running
        workoutConfiguration.locationType = .indoor
        return workoutConfiguration
    }()
    
    var workoutSession: WorkoutSessionService?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
    }
    
    @IBAction func workoutSwitchActivated(_ value: Bool) {
        if value == true {
            workoutSession = WorkoutSessionService(configuration: self.configuration)
            workoutSession?.startSession()
        } else {
            workoutSession?.stopSession()
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        let healthService: HealthDataService = HealthDataService()
        
        healthService.authorizeHealthKitAccess { (success, error) in
            if success {
                print("HealthKit authorization received.")
            } else {
                print("HealthKit authorization denied.!")
                if error != nil {
                    print("\(error?.localizedDescription)")
                }
            }
        }
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

// MARK: - Helpers

extension InterfaceController {
    func repeatingBackgroundTest(_ numberOfTests: Int) {
        if numberOfTests != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                print("Repeating task: \(numberOfTests)")
                self.repeatingBackgroundTest(numberOfTests - 1)
            }
        }
    }
}
