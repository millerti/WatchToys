//
//  StepsComplication.swift
//  WatchToys WatchKit Extension
//
//  Functions that facilitate registration and data retrieval for the Steps complication.
//
//  Created by Tim Miller on 11/7/21.
//

import ClockKit
import HealthKit

// Set up access to the system's health store so we can access step counts
let healthStore = HKHealthStore()

func stepsComplicationDescriptor () -> CLKComplicationDescriptor {
    // The descriptor for the Steps complication.
    // Call this in the getComplicationDescriptors function to make this complication available.
    CLKComplicationDescriptor(identifier: "stepsComplication",
                              displayName: "Steps",
                              supportedFamilies: [CLKComplicationFamily.modularSmall,
                                                  CLKComplicationFamily.circularSmall,
                                                  CLKComplicationFamily.graphicCorner])
}

func getStepsCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    // This is the meat and potatoes of our complication: it returns the information that should be displayed at the current time.
    // Ssince the only real thing we plan to do is to return the current step count according to HealthKit, it should remain relatively simple.
    
    // Call this function in ComplicationController::getCurrentTimelineEntry for the complication with the relevant identifier.
    
    // In HealthKit, an app cannot query whether or not the user has granted permission to read data. As such,
    // we should not bother checking here.
    
    getStepsData(completion: { (_ result: Double) -> Void in
        let stepCount: String = String(format: "%.0f", result)
        var stepLabel: String = ""
        
        // Mustn't mispluralize
        if stepCount == "1" {
            stepLabel = "STEP"
        } else {
            stepLabel = "STEPS"
        }
        
        let now: Date = Date()
    
        // Pass the data along to formatting functions for each complication "shape":
        switch complication.family {
            case .modularSmall:
                let template = CLKComplicationTemplateModularSmallStackText(
                    line1TextProvider: CLKSimpleTextProvider(text: stepCount),
                    line2TextProvider: CLKSimpleTextProvider(text: stepLabel))
            
                handler(CLKComplicationTimelineEntry(date: now,
                                                             complicationTemplate: template))
         
            case .circularSmall:
                let template = CLKComplicationTemplateCircularSmallStackText(
                    line1TextProvider: CLKSimpleTextProvider(text: stepCount),
                    line2TextProvider: CLKSimpleTextProvider(text: stepLabel))
            
                handler(CLKComplicationTimelineEntry(date: now,
                                                             complicationTemplate: template))
            
           case .graphicCorner:
               let template = CLKComplicationTemplateGraphicCornerStackText(
                   innerTextProvider: CLKSimpleTextProvider(text: stepLabel),
                   outerTextProvider: CLKSimpleTextProvider(text: stepCount))
           
               handler(CLKComplicationTimelineEntry(date: now,
                                                            complicationTemplate: template))
         
            default:
                handler(nil)
        }
    })
}

func getStepsData(completion: @escaping (Double) -> Void) {
    // Retrieves the number of steps the user has taken today
    
    // Restrict the time interval to today up until now
    let now = Date()
    let stepsQuery = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: now),
                                                 end: now,
                                                 options: .strictStartDate)
    
    // Construct a statistics query for total step count using our time interval
    let statistics = HKStatisticsQuery(quantityType: HKQuantityType.quantityType(forIdentifier: .stepCount)!,
                                       quantitySamplePredicate: stepsQuery,
                                       options: .cumulativeSum)
    {
        // This closure is the completion handler for the query
        (query, results, error) in
        
            // This sort of error display isn't fantastic, but let's return specific values when things go wrong
            // since it's convenient (and unlikely to collide with actual step counts since real step counts tend to be whole numbers)
            if error != nil {
                print(error.debugDescription)
                completion(1.1) // error code 1.1 -- we got an error from HKStatisticsQuery
                return
            }
            
            // The guard let keyword protects against nil since results is optional
            guard let results = results else {
                completion(1.2) // error code 1.2 -- no results returned
                return
            }
            
            guard let sum = results.sumQuantity() else {
                completion(1.3) // error code 1.3 -- error when summing results, or perhaps sumQuantity returned nil
                return
            }
            
            // Pass the value from the HKQuantity object to the completion handler for the function
            completion(sum.doubleValue(for: HKUnit.count()))
    }
    
    // Actually run the query we just described
    healthStore.execute(statistics)
}

func getStepsLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    // This function returns the look for a complication when the user is configuring which complications they want to display.
    // It will contain preview data, not real data, so we get to just fudge a lot of stuff.
    
    // Call this function in ComplicationController::getLocalizableSampleTemplate for the complication with the relevant identifier.
    
    // This complication only displays a step count, so our preview will simply be two lines of text,
    // no matter what shape the complication takes:
    let previewNumber: String = "1524"
    let previewLabel: String = "STEPS"
    
    // Each case is for a different possible complication shape. We must return a generated template through a call to handler.
    switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText(
                line1TextProvider: CLKSimpleTextProvider(text: previewNumber),
                line2TextProvider: CLKSimpleTextProvider(text: previewLabel))
            handler(template)
     
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallStackText(
                line1TextProvider: CLKSimpleTextProvider(text: previewNumber),
                line2TextProvider: CLKSimpleTextProvider(text: previewLabel))
            handler(template)
        
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerStackText(
                innerTextProvider: CLKSimpleTextProvider(text: previewLabel),
                outerTextProvider: CLKSimpleTextProvider(text: previewNumber))
            handler(template)
     
        default:
            handler(nil)
    }
}
