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
        var hoursVal = Double(HoursLabel.text!)!
        hoursVal = hoursVal + 1
        HoursLabel.text! = hoursVal.description
        AL.updateTempStack(TitleLabel.text!, newHours: Double(hoursVal), clear: false)
        
    }
    @IBAction func minusButton(sender: UIButton) {
        print(HoursLabel.text!)
        var hoursVal = Double(HoursLabel.text!)!
        if hoursVal > 0 {
            hoursVal = hoursVal - 1
            HoursLabel.text! = hoursVal.description
            AL.updateTempStack(TitleLabel.text!, newHours: Double(hoursVal), clear: false)
        }
    }
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var HoursLabel: UILabel!
}