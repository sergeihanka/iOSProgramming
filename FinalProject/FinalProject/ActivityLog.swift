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
    var selectedChart = Int()
    
    init() { //load Saved Data
        print("Stack empty, loading template.",activityStack)
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let day = formatter.stringFromDate(NSDate())
        selectedDate = day
        
        activityStack = loadSavedData()!
        
        if (activityStack == []) {
            let newAct = ["School":0.0]
            activityStack.append(Day(date: day, ActivityAndTime: newAct)!)
            saveActivityLog()
        }
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
            print("New Item:",forDate, name)
            activityStack.append(Day(date: forDate, ActivityAndTime: [name: 0.0])!)
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
        print("ACTIVITYSTACK:",activityStack)
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

    var getPastWeek: [String] {
        get {
            let timeLength = 7
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
    
    var allActivitiesCategoriesAndTotalTime: [String:Double] {
        get {
            var tmpDict = [String:Double]()
            for day in activityStack {
                for activity in day.ActivityAndTime {
                    if let x = tmpDict[activity.0] {
                        print(activity.0, "HERE",x)
                        tmpDict[activity.0] = x + activity.1
                    } else {
                        if activity.1 == 0.0 {
                            tmpDict[activity.0] = 0.0
                        } else {
                            tmpDict[activity.0] = activity.1
                        }
                    }
                }
            }
            print("Overall Breakdown:",tmpDict)
            return tmpDict
        }
    }
    
//    func getTotalAverageBreakDown() -> [String:Double]{
//        var stats = [String:Double]()
//        let allCategoriesTotal = allActivitiesCategoriesAndTotalTime
//        let tTime = allActivitiesTotalTime
//        for category in allCategoriesTotal.keys {
//            if tTime > 0.0 {
//                stats[category] = (Double((allCategoriesTotal[category])! / tTime))
//            } else {
//                stats[category] = 0.1
//            }
//        }
//        return stats
//    }
    
    var getWeeklyAverageBreakDown: [String:Double] {
        get {
            let lastWeek = getPastWeek
            var tmpDict = [String:Double]()
            for day in activityStack {
                if let _ = lastWeek.indexOf(day.date) {
                    for activity in day.ActivityAndTime {
                        if let x = tmpDict[activity.0] {
                            print(activity.0, "HERE",x)
                            tmpDict[activity.0] = x + activity.1
                        } else {
                            if activity.1 == 0.0 {
                                tmpDict[activity.0] = 0.0
                            } else {
                                tmpDict[activity.0] = activity.1
                            }
                        }
                    }
                }
            }
            print("Weekly Breakdown:",tmpDict)
            return tmpDict
        }
    }
    
    var getDailyAverageBreakDown: [String:Double] {
        get {
            var tmpDict = [String:Double]()
            for day in activityStack {
                if day.date == selectedDate {
                    for activity in day.ActivityAndTime {
                        if let x = tmpDict[activity.0] {
                            print(activity.0, "HERE",x)
                            tmpDict[activity.0] = x + activity.1
                        } else {
                            if activity.1 == 0.0 {
                                tmpDict[activity.0] = 0.0
                            } else {
                                tmpDict[activity.0] = activity.1
                            }
                        }
                    }
                }
            }
            print("Daily Breakdown:",tmpDict)
            return tmpDict
        }
    }
 
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
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let day = formatter.stringFromDate(NSDate())
        selectedDate = day
        let newAct = ["School":0.0]
        print(activityStack)
        activityStack.append(Day(date: day, ActivityAndTime: newAct)!)
        saveActivityLog()

    }
}