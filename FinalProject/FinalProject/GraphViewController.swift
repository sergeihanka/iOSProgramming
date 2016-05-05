//
//  GraphViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 4/27/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit
import PNChartSwift

class GraphViewController: UIViewController {
    
    @IBOutlet weak var barChart: PNBarChart!
    
    
    @IBOutlet weak var ChartLabel: UILabel!
    
    var AL = ActivityLog.sharedLog
    
    override func viewDidLoad() {
        self.title = "Productivity!"
        createBarChart()
        
    }
    
    func createBarChart() {
        ChartLabel.textColor = PNGreenColor
        
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        
        ChartLabel.text = "Productivity Overview"
        
        barChart.backgroundColor = UIColor.clearColor()
        
        barChart.barBackgroundColor = UIColor.clearColor()
        
        barChart.animationType = .Waterfall
        
        barChart.xLabels = AL.categories
        
        barChart.yValues = Array(AL.getAverageBreakDown().values)
        
        print(barChart.yValues)
        
        barChart.strokeChart()
    }
    
    func userClickedOnBarChartIndex(barIndex: Int) {
        print("Click  on bar \(barIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}








//end