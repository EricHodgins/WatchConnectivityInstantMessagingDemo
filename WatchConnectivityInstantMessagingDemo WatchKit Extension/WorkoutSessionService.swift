//
//  WorkoutSessionService.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-31.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import HealthKit

class WorkoutSessionService {
    
    var hrData: [HKQuantitySample] = [HKQuantitySample]()
    
    let session: HKWorkoutSession
    
    init?() {
        
        let hkWorkoutConfiguration = HKWorkoutConfiguration()
        hkWorkoutConfiguration.activityType = HKWorkoutActivityType.running
        hkWorkoutConfiguration.locationType = HKWorkoutSessionLocationType.indoor
        
        do {
            session = try HKWorkoutSession(configuration: hkWorkoutConfiguration)
        } catch {
            print("ERROR: \(error.localizedDescription)")
            return nil
        }
        
    }
}
