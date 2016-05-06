//
//  ActivityLog.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/26/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import Foundation

class ActivityLog {
//    
    static let sharedLog = ActivityLog()
    
    var activityStack = [Day]()

    var selectedDate = String()
    
    init() { //load Saved Data
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let day = formatter.stringFromDate(NSDate())
        selectedDate = day
        let newAct = ["School":0.0]
        print(activityStack)
        activityStack.append(Day(date: day, ActivityAndTime: newAct)!)
        activityStack = loadSavedData()!
    }
    
    // MARK: functions
    
    func newCategory(name: String, forDate: String) {
        var foundInStack = false
        for object in activityStack {
            if object.date == forDate {
                object.ActivityAndTime[name] = 0.0
                foundInStack = true
            }
        }
        if !foundInStack {
            print(forDate, name)
            activityStack.append(Day(date: forDate, ActivityAndTime: [name:0.0])!)
        }
    }
    
    // MARK: Key Info
    
    func itemCount(date: String) -> Int {
        for obj in activityStack {
            if obj.date == date {
                return obj.ActivityAndTime.count
            }
        }
        return 0
    }
    

    func dayCats(date: String) -> [String] {
        var tmpCats = [String]()
        for obj in activityStack {
            if obj.date == date {
                for item in obj.ActivityAndTime {
                    tmpCats.append(item.0)
                }
            }
        }
        return tmpCats
    }
    
    func dayVals(date: String) -> [Double] {
        var tmpVals = [Double]()
        for obj in activityStack {
            if obj.date == date {
                for item in obj.ActivityAndTime {
                    tmpVals.append(item.1)
                }
            }
        }
        return tmpVals
    }
    
    var getPastData: [String] {
        get {
            let timeLength = 30
            let calendar = NSCalendar.currentCalendar()
            var tmpList = [String]()
            var i = 0
            while i > (0 - timeLength) {
                let yesterday = calendar.dateByAddingUnit(.Day, value: i, toDate: NSDate(), options: [])
                let formatter: NSDateFormatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                
                let day = formatter.stringFromDate(yesterday!)
                i = i - 1
                tmpList.append(day)
            }
            return tmpList
        }
    }
    
    var allActivitiesCategoriesAndTotalTime: [String:Double] {
        get {
            var x = [String:Double]()
            for obj in activityStack {
                for item in obj.ActivityAndTime {
                    if x[item.0] != nil {
                        x[item.0] = x[item.0]! + item.1
                    } else {
                        x[item.0] = 0
                    }
                }
            }
            return x
        }
    }

    var allActivitiesTotalTime: Double {
        get {
            let allCats = allActivitiesCategoriesAndTotalTime
            var x = 0.0
            for cat in allCats.keys {
                if allCats[cat] != nil {
                    x = x + allCats[cat]!
                } else {
                    x = x + 0
                }

            }
            return x
        }
    }
    
    // MARK: Get Stats
    
    func getTotalAverageBreakDown() -> [String:Double]{
        var stats = [String:Double]()
        let allCategoriesTotal = allActivitiesCategoriesAndTotalTime
        let tTime = allActivitiesTotalTime
        for category in allCategoriesTotal.keys {
            if tTime > 0.0 {
                stats[category] = (Double((allCategoriesTotal[category])! / tTime))
            } else {
                stats[category] = 0.1
            }
        }
        
        print(tTime)
        print("STATS: ",stats)
        print("CATEGORIES: ",allCategoriesTotal)
        return stats
    }
    
//    func getWeeklyAverageBreakDown() -> [String:Double]{
//        var stats = [String:Double]()
//        
//        for date in getLastWeek {
//            if let keyExists = activityStack. [date] != nil {
//                
//            }
//        }
//        
//        print(tTime)
//        print("STATS: ",stats)
//        print("CATEGORIES: ",categories)
//        return stats
//    }
    
//    func getDailyAverageBreakDown() -> [String:Double]{
//        var stats = [String:Double]()
//        let tTime = allActivitiesTotalTime
//        for key in categories {
//            if tTime > 0.0 {
//                print(Double((activityStack[key]?.totalTime)!) / tTime)
//                stats[key] = (Double((activityStack[key]?.totalTime)!) / tTime)
//            } else {
//                stats[key] = 0.1
//            }
//        }
//        
//        print(tTime)
//        print("STATS: ",stats)
//        print("CATEGORIES: ",categories)
//        return stats
//    }
 
    // MARK: Persistent Data
    
    func saveActivityLog() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(activityStack as [Day])
        
        defaults.setObject(archivedObject, forKey: "activityList")
        
        defaults.synchronize()
        
        print("SAVED!")
    }
    
    func loadSavedData() -> [Day]? {
        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("activityList") as? NSData {
            return (NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as! [Day])
        } else {
            return [Day]()
        }
    }
    func CLEARALL() {
        activityStack = [Day]()
    }
}