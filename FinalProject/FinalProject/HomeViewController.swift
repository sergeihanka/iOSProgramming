//
//  GraphViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/27/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit
import PNChartSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var barChart: PNBarChart!
    
    @IBOutlet weak var ChartLabel: UILabel!
    
    var AL = ActivityLog.sharedLog
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        
        self.title = "Productivity!"

        createBarChart()
        
    }
    
    func createBarChart() {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        print(screenSize)
        
        print("BARCHART WIDTH",barChart.frame.size.width)
        
        ChartLabel.textColor = PNGreenColor
        
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        
        ChartLabel.text = "Productivity Overview"
        
        barChart.backgroundColor = UIColor.clearColor()
        
        barChart.barBackgroundColor = UIColor.clearColor()
        
        barChart.animationType = .Waterfall
        
        print("Main Chart Values")
        print(Array(AL.allActivitiesCategoriesAndTotalTime.keys))
        
        barChart.xLabels = Array(AL.allActivitiesCategoriesAndTotalTime.keys)
        
        var barValues = [Double]()
        
        for num in AL.allActivitiesCategoriesAndTotalTime.values {
            if num != 0 {
                barValues.append(num)
            } else {
                barValues.append(0.1)
            }
        }
        
        print(barValues)
        
        barChart.yValues = barValues
        
        barChart.strokeChart()
    }
    
    func userClickedOnBarChartIndex(barIndex: Int) {
        print("Click  on bar \(barIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(sender: AnyObject) {
        AL.CLEARALL()
    }
    
}


//end