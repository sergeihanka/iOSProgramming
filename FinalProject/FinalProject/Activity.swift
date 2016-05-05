//
//  Activity.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/28/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class Activity: NSObject, NSCoding {
    // MARK: Properties
    
    var categoryName: String
    var dailyTime: Double
    var totalTime: Double
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("ActivityStack")
    
    
    // MARK: Initialization
    
    init?(categoryName: String, dailyTime: Double, totalTime: Double) {
        // Initialize stored properties.
        
        self.categoryName = categoryName
        self.dailyTime = dailyTime
        self.totalTime = totalTime
        
        super.init()
        
        // Initialization should fail if there is no categoryName
        if categoryName.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(categoryName, forKey: "categoryName")
        aCoder.encodeDouble(dailyTime, forKey: "dailyTime")
        aCoder.encodeDouble(totalTime, forKey: "totalTime")

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let categoryName = aDecoder.decodeObjectForKey("categoryName") as! String
        
        let dailyTime = aDecoder.decodeDoubleForKey("dailyTime")
        
        let totalTime = aDecoder.decodeDoubleForKey("totalTime")
        
        // Must call designated initializer.
        self.init(categoryName: categoryName, dailyTime: dailyTime, totalTime: totalTime)
    }
    
}