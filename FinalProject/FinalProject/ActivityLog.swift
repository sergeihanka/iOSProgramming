//
//  ActivityLog.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/26/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import Foundation

class ActivityLog {
    
    static let sharedLog = ActivityLog()
    
    init() {
        updateActivityLog("School", newHours: 00000)
        updateActivityLog("Work", newHours: 00000)
        updateActivityLog("Play", newHours: 00000)
    }
    
    var count: Int { return categories.count }
    
    var totalTime: Double {
        get {
            var x = 0.0
            for n in activityStack.values {
                x = x + Double(n)
            }
            return x
        }
    }
    
    var activityStack = [String:Int]()
    var tempStack = [String:Int]()
    
    var categories: [String] {
        get {
            var tempList = [String]()
            for key in activityStack.keys {
                tempList.append(key)
            }
            return tempList
        }
    }
    
    func updateActivityLog(category: String, newHours: Int) {
        activityStack[category] = newHours
    }
    
    func getAverageBreakDown() -> [String:Double]{
        var stats = [String:Double]()
        for key in activityStack.keys {
            if totalTime > 0.0 {
                print(Double(activityStack[key]!) / totalTime)
                stats[key] = (Double(activityStack[key]!) / totalTime)
            }
        }
        print(stats)
        return stats
    }
    
}