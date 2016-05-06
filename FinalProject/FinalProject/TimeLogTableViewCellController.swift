//
//  TimeLogCellController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/25/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import Foundation
import UIKit

class TimeLogTableViewCellController: UITableViewCell {
    
    var AL = ActivityLog.sharedLog
    
    
    @IBAction func plusButton(sender: UIButton) {
        HoursLabel.text! = String(Double(HoursLabel.text!)! + 1.0);
        for item in AL.activityStack {
            if item.date == AL.selectedDate {
                item.setActivityTime(TitleLabel.text!, newTime: Double(HoursLabel.text!)!)
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    
    @IBAction func minusButton(sender: UIButton) {
        if HoursLabel.text! != "0.0" {
            HoursLabel.text! = String(Double(HoursLabel.text!)! - 1.0);
            for item in AL.activityStack {
                if item.date == AL.selectedDate {
                    item.setActivityTime(TitleLabel.text!, newTime: Double(HoursLabel.text!)!)
                }
            }
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        }
    }
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var HoursLabel: UILabel!
}