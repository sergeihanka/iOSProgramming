//
//  newCategoryForm.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/27/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class newCategoryFormController: UIViewController {
    
    var ST = TimeLogTableViewController.sharedTable
    var AL = ActivityLog.sharedLog
    
    @IBOutlet weak var popOverNewCategoryLabel: UITextField!

    @IBAction func closeNewCategoryFormButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func AddCategoryButton() {
        if popOverNewCategoryLabel.text! != "" && popOverNewCategoryLabel.text != nil {
            AL.activityStack[popOverNewCategoryLabel.text!] = 00
            
            //Refresh the table
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            
            print(AL.activityStack)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBOutlet weak var newCatForm: UIView!
    
    override var preferredContentSize: CGSize {
        get {
            if newCatForm != nil && presentingViewController != nil {
                return newCatForm.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}
