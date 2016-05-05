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
    var activityStack = [String:Activity]()
    var tempStack = [String:Activity]()
    
    init() {
        //load Saved Data
        
        activityStack = loadSavedData()!
        
    }
    
    var count: Int { return categories.count }
    
    var allActivitiesTotalTime: Double {
        get {
            var x = 0.0
            for n in activityStack.values {
                print("VALUE: ", n.totalTime)
                x = x + Double(n.totalTime)
            }
            return x
        }
    }
    
    var categories: [String] {
        get {
            var tempList = [String]()
            for key in activityStack.keys {
                tempList.append(key)
            }
            return tempList
        }
    }
    
    func updateActivityLog(category: String, newHours: Double, clear: Bool) {
        var foundInStack = false
        if clear {
            activityStack[category]?.dailyTime = 0
            activityStack[category]?.totalTime = 0
        }
        for key in activityStack.keys {
            if category == key {
                activityStack[category]?.dailyTime = newHours
                activityStack[category]?.totalTime = (activityStack[category]?.totalTime)! + newHours
                foundInStack = true
            }
        }
        if !foundInStack {
            activityStack[category] = Activity(categoryName: category, dailyTime: newHours, totalTime: newHours)
        }
    }
    
    func updateTempStack(category: String, newHours: Double, clear: Bool) {
        var foundInStack = false
        for key in tempStack.keys {
            if category == key {
                tempStack[category]?.dailyTime = newHours
                tempStack[category]?.totalTime = (tempStack[category]?.totalTime)! + newHours
                foundInStack = true
            }
        }
        if !foundInStack {
            tempStack[category] = Activity(categoryName: category, dailyTime: newHours, totalTime: newHours)
        }
    }
    
    func getAverageBreakDown() -> [String:Double]{
        var stats = [String:Double]()
        let tTime = allActivitiesTotalTime
        for key in categories {
            if tTime > 0.0 {
                print(Double((activityStack[key]?.totalTime)!) / tTime)
                stats[key] = (Double((activityStack[key]?.totalTime)!) / tTime)
            } else {
                stats[key] = 0.1
            }
        }
        
        print(tTime)
        print("STATS: ",stats)
        print("CATEGORIES: ",categories)
        return stats
    }
 
    // MARK: Persistent Data
    
    func saveActivityLog() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(activityStack as NSDictionary)
        
        defaults.setObject(archivedObject, forKey: "activityList")
        
        defaults.synchronize()
        
    }
    
    func loadSavedData() -> [String:Activity]? {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("activityList") as? NSData {
            return (NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as! [String:Activity]?)
        } else {
            return [String:Activity]()
        }
    }
    func CLEARALL() {
        for key in activityStack.keys {
            updateActivityLog(key, newHours: 0, clear: true)
        }
    }
}