//
//  TimeLogController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/25/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class TimeLogTableViewController: UITableViewController, UITextFieldDelegate {
//
    var AL = ActivityLog.sharedLog
    
    @IBOutlet weak var daylabel: UIBarButtonItem!
    
    static var sharedTable = TimeLogTableViewController()
    
    //MARK: Storyboard Buttons
    
    @IBAction func SubmitButton() {
        print(AL.tempStack)
        for key in AL.activityStack.keys {
            if AL.tempStack[key]?.dailyTime != nil {
                AL.updateActivityLog(key, newHours: (AL.tempStack[key]?.dailyTime)!, clear: false)
            } else {
                AL.updateActivityLog(key, newHours: 0, clear: false)
            }
            
            print("STACK",AL.activityStack[key]!.dailyTime,"TOTAL HOURS",(AL.tempStack[key]?.dailyTime))
        }
        
        AL.getAverageBreakDown()
        AL.saveActivityLog()
    }
    
//    @IBOutlet weak var getCategoryPopup: UIButton!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AL.count
    }
    
    private struct Storyboard {
        static let CategoryReuseIdentifier = "categories"
    }
    
    //MARK: Table Population

    override func viewDidLoad() {
        //Load date into header
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        daylabel.title! = formatter.stringFromDate(NSDate())
        
        self.title = "Time Log"
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CategoryReuseIdentifier, forIndexPath: indexPath) as! TimeLogTableViewCellController
        cell.TitleLabel.text! = AL.categories[indexPath.row]
        cell.HoursLabel.text! = String(AL.activityStack[cell.TitleLabel.text!]!.dailyTime)
        return cell
    }
}




























//end