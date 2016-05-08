//
//  DualViewController.swift
//  FinalProject
//
//  Created by Sergei Hanka on 5/8/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let AL = ActivityLog.sharedLog
    
    var pageViewController: UIPageViewController!
    let pages = ["GraphOnePageController","GraphTwoPageController","GraphThreePageController"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if (index < pages.count - 1) {
                return viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if (index > 0) {
                return viewControllerAtIndex(index - 1)
            }
        }
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController?{
        let vc = storyboard?.instantiateViewControllerWithIdentifier(pages[index])
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("GraphPages") {
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            
            pageViewController = vc as! UIPageViewController
            
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
            print("MADE IT")
            pageViewController.didMoveToParentViewController(self)
            
        }
    }
}