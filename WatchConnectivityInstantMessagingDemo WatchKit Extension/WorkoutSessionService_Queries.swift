//
//  WorkoutSessionService_Queries.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-11-01.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import HealthKit


extension WorkoutSessionService {
    
    internal func heartRateQuery(withStartDate start: Date) -> HKQuery {
        let predicate = genericSamplePredicate(withStartDate: start)
        let query: HKAnchoredObjectQuery = HKAnchoredObjectQuery(type: hrType,
                                                                 predicate: predicate,
                                                                 anchor: hrAnchorValue,
                                                                 limit: Int(HKObjectQueryNoLimit)) {
                                                                    (query, sampleObjects, deletedObjects, newAnchor, error) in
                                                                    
                                                                    self.hrAnchorValue = newAnchor
                                                                    self.newHRSamples(sampleObjects)
                                                                    
        }
        
        query.updateHandler = { (query, samples, deleteObjects, newAnchor, error) in
            self.hrAnchorValue = newAnchor
            self.newHRSamples(samples)
        }
        
        return query
    }
    
    private func newHRSamples(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample],
            samples.count > 0 else {
                return
        }
        
        DispatchQueue.main.async {
            self.hrData += samples
            
            if let hr = samples.last?.quantity {
                self.heartRate = hr
                print("heart rate = \(hr)")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func genericSamplePredicate(withStartDate start: Date) -> NSPredicate {
        let dataPredicate = HKQuery.predicateForSamples(withStart: start, end: nil, options: .strictStartDate)
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: [dataPredicate, devicePredicate])
    }
}



































