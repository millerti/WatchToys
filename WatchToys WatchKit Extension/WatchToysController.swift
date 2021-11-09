//
//  WatchToysController.swift
//  WatchToys WatchKit Extension
//
//  Created by Tim Miller on 11/7/21.
//

import Foundation
import HealthKit

class WatchToysVM {
    let healthStore = HKHealthStore()
    
    func AuthorizeStepsData() -> () {
        healthStore.requestAuthorization(toShare: nil, read: Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])) { (success, error) in
            print("Authorized")
        }
    }
}
