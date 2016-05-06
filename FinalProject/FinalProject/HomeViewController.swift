//
//  CalendarViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/4/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {
    
    let AL = ActivityLog.sharedLog
    
    @IBAction func getLastWeek(sender: AnyObject) {
        
        let calendar = NSCalendar.currentCalendar()

        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        let day = formatter.stringFromDate(NSDate())
        
        for i in AL.activityStack {
            if i.date == day {
                print(i.date, i.ActivityAndTime)
            }
        }
        
        print("today",day)
        
        var i = 0
        while i > -30 {
            let yesterday = calendar.dateByAddingUnit(.Day, value: i, toDate: NSDate(), options: [])
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            
            let day = formatter.stringFromDate(yesterday!)
            i = i - 1
            print(day)
        }
    }
}