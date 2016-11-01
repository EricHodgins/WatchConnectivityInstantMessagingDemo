//
//  WorkoutSessionService.swift
//  WatchConnectivityInstantMessagingDemo
//
//  Created by Eric Hodgins on 2016-10-31.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import HealthKit

class WorkoutSessionService: NSObject {
    
    fileprivate let healthService = HealthDataService()
    var startDate: Date?
    var endDate: Date?
    
    var hrData: [HKQuantitySample] = [HKQuantitySample]()
    
    let hkWorkoutConfiguration: HKWorkoutConfiguration
    let session: HKWorkoutSession
    
    init?(configuration: HKWorkoutConfiguration) {

        self.hkWorkoutConfiguration = configuration
        //hkWorkoutConfiguration.activityType = HKWorkoutActivityType.running
        //hkWorkoutConfiguration.locationType = HKWorkoutSessionLocationType.indoor
        
        do {
            session = try HKWorkoutSession(configuration: hkWorkoutConfiguration)
        } catch {
            print("ERROR: \(error.localizedDescription)")
            return nil
        }
        
        super.init()
        session.delegate = self
    }
    
    func startSession() {
        healthService.healthKitStore.start(session)
    }
    
    func stopSession() {
        healthService.healthKitStore.end(session)
    }
}

extension WorkoutSessionService: HKWorkoutSessionDelegate {
    fileprivate func sessionStarted(_ date: Date) {
        print("Session started.")
    }
    
    fileprivate func sessionEnded(_ date: Date) {
        print("Session ended.")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        print("Workout session did change state: \(toState.rawValue)-\(fromState.rawValue)")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("Did fail with error: \(error)")
    }
}



























