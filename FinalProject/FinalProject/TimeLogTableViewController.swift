//
//  TimeLogController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/25/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class TimeLogTableViewController: UITableViewController, UITextFieldDelegate{
//
    var AL = ActivityLog.sharedLog
    
//    @IBOutlet weak var daylabel: UIBarButtonItem!
    
    //MARK: Storyboard Buttons
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AL.itemCount(AL.selectedDate)
    }
    
    private struct Storyboard {
        static let CategoryReuseIdentifier = "categories"
    }
    
    //MARK: Table Population

    override func viewDidLoad() {
        //Load date into header
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
//        daylabel.title! = AL.selectedDate
        
        self.title = "Time Log"
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
    }
    
    func loadList(notification: NSNotification){
        //load data here
//        daylabel.title! = AL.selectedDate
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CategoryReuseIdentifier, forIndexPath: indexPath) as! TimeLogTableViewCellController
//        AL.selectedDate = dayPicker.description
        cell.TitleLabel.text! = AL.dayCats(AL.selectedDate)[indexPath.row]
        cell.HoursLabel.text! = String(AL.dayVals(AL.selectedDate)[indexPath.row])
        
        return cell
    }
    
    @IBOutlet weak var dayPicker: UIPickerView!
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        print("ROW:",row)
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
    }
    
}



//end