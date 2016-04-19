//
//  ViewController.swift
//  ColorBox
//
//  Created by Sergei Hanka on 3/29/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class ColorBoxViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension ColorBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ColorBoxTableViewCell
        
        
        cell.configure()
        
        return cell
    }
}
