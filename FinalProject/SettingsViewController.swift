//
//  SettingsViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/3/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var AL = ActivityLog.sharedLog
    
    @IBAction func ClearData(sender: AnyObject) {
        AL.CLEARALL()
    }
    
}