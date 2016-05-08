//
//  GraphViews.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/8/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit
import PNChartSwift

class DayChart: UIViewController {
    @IBOutlet weak var barChart: PNBarChart!
    
    var AL = ActivityLog.sharedLog
    
    override func viewDidLoad() {
        createBarChart()
    }
    
    func createBarChart() {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        print(screenSize)
        
        print("BARCHART WIDTH",barChart.frame.size.width)
        
        //        ChartLabel.textColor = PNGreenColor
        //
        //        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        //
        //        ChartLabel.text = "Productivity Overview"
        
        barChart.backgroundColor = UIColor.clearColor()
        
        barChart.barBackgroundColor = UIColor.clearColor()
        
        barChart.animationType = .Waterfall
        
        print("Daily Chart Values")
        print(Array(AL.getDailyAverageBreakDown.keys))
        print(barChart.yValues)
        
        barChart.xLabels = Array(AL.getDailyAverageBreakDown.keys)
        
        var barValues = [Double]()
        
        for num in AL.getDailyAverageBreakDown.values {
            if num != 0 {
                barValues.append(num)
            } else {
                barValues.append(0.1)
            }
        }
        
        barChart.yValues = barValues
        
        barChart.strokeChart()
    }
    
    func userClickedOnBarChartIndex(barIndex: Int) {
        print("Click  on bar \(barIndex)")
    }
}