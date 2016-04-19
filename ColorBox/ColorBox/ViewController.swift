//
//  ViewController.swift
//  ColorBox
//
//  Created by Sergei Hanka on 3/29/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var colors: [ColorBox] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ColorClient.sharedClient.getColors { [weak self](colors) in
            self?.colors = colors
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ColorBoxTableViewCell
        let color = colors[indexPath.row]
        cell.configure(color)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height)        
        return headerView
    }
}