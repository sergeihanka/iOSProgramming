//
//  DualViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/8/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class DualViewController: UIViewController {
    let AL = ActivityLog.sharedLog
    
    @IBAction func SubmitButton() {
        AL.saveActivityLog()
    }
}
