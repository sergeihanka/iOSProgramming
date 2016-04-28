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
    
    static var sharedTable = TimeLogTableViewController()
    
    //MARK: Storyboard Buttons
    
    @IBAction func SubmitButton() {
        for key in AL.tempStack.keys {
            AL.updateActivityLog(key, newHours: AL.tempStack[key]!)
        }

        AL.getAverageBreakDown()
        print("STACK",AL.activityStack,"TOTAL HOURS",AL.totalTime)
    }
    
    @IBOutlet weak var getCategoryPopup: UIButton!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AL.count
    }
    
    private struct Storyboard {
        static let CategoryReuseIdentifier = "categories"
    }
    
    //MARK: Table Population

    override func viewDidLoad() {
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
        cell.HoursLabel.text! = AL.activityStack[cell.TitleLabel.text!]!.description
        return cell
    }

}




























//end