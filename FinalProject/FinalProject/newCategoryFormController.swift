//
//  newCategoryForm.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/27/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

//class newCategoryFormController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate {
class newCategoryFormController: UIViewController{
    var AL = ActivityLog.sharedLog
    
    @IBOutlet weak var popOverNewCategoryLabel: UITextField!

    @IBAction func newCategorySubmit(sender: UIButton) {
        print("DATE:",AL.selectedDate)
        for item in AL.activityStack {
            print(item.date, item.ActivityAndTime)
            if item.date == AL.selectedDate {
                print(AL.selectedDate,item.ActivityAndTime)
            }
        }
        if (popOverNewCategoryLabel.text! != "" && popOverNewCategoryLabel.text! != "") {
            AL.newCategory(popOverNewCategoryLabel.text!, forDate: AL.selectedDate)
            
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func closeNewCategoryFormButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var newCatForm: UIView!
    
    
}
