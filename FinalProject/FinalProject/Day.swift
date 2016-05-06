//
//  Activity.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/28/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class Day: NSObject, NSCoding {
//class Day: NSObject {
    
    // MARK: Properties
    
    var date: String
    var ActivityAndTime: [String:Double]
    
    // MARK: Initialization
    
    init?(date: String, ActivityAndTime: [String:Double]) {
        
        self.date = date
        self.ActivityAndTime = ActivityAndTime
        
        super.init()
        
        if date.isEmpty {
            return nil
        }
    }
    
    func setActivityTime(category: String, newTime: Double) {
        ActivityAndTime[category] = newTime
    }
    
    func addCategory(categoryName: String) {
        ActivityAndTime[categoryName] = 0
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(ActivityAndTime, forKey: "ActivityAndTime")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObjectForKey("date") as! String
        
        let ActivityAndTime = aDecoder.decodeObjectForKey("ActivityAndTime") as! [String:Double]
        
        // Must call designated initializer.
        self.init(date: date, ActivityAndTime: ActivityAndTime)
    }
    
}