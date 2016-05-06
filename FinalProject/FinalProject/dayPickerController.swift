//
//  dayPickerController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/6/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import Foundation
import UIKit

class dayPickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dayPicker: UIPickerView!
    
    var AL = ActivityLog.sharedLog
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: AL.getPastData[row], attributes: [NSForegroundColorAttributeName : UIColor.orangeColor()])
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AL.getPastData.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AL.selectedDate = AL.getPastData[row]
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        print("picker:",AL.selectedDate)
    }
    
    override func viewDidLoad() {
    }
    
}
