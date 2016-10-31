//
//  HealthDataService.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-31.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import HealthKit

let heartRateType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!

class HealthDataService {
    
    internal let healthKitStore: HKHealthStore = HKHealthStore()
    
    init() {
        
    }
    
    func authorizeHealthKitAccess(_ completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
        let typesToShare = Set(
            [HKObjectType.workoutType(), heartRateType]
        )
        
        let typesToSave = Set([heartRateType])
        
        healthKitStore.requestAuthorization(toShare: typesToShare, read: typesToSave) { (success, error) in
            completion(success, error)
        }
        
    }
    

    
}
