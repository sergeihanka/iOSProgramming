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
        var hoursVal = Int(HoursLabel.text!)!
        hoursVal = hoursVal + 1
        HoursLabel.text! = hoursVal.description
        AL.tempStack[TitleLabel.text!] = hoursVal
        
    }
    @IBAction func minusButton(sender: UIButton) {
        var hoursVal = Int(HoursLabel.text!)!
        if hoursVal > 0 {
            hoursVal = hoursVal - 1
            HoursLabel.text! = hoursVal.description
            AL.tempStack[TitleLabel.text!] = hoursVal
        }
    }
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var HoursLabel: UILabel!
}