//
//  TweetContentTableViewCell.swift
//  SmashTag
//
//  Created by Sergei Hanka on 4/17/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class TweetContentTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var spinnyThing: UIActivityIndicatorView!
    
    var imageUrl: NSURL? { didSet { updateUI() } }
    
    func updateUI() {
        tweetImageView?.image = nil
        if let url = imageUrl {
            spinnyThing?.startAnimating()
            if #available(iOS 8.0, *) {
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                    let imageData = NSData(contentsOfURL: url)
                    dispatch_async(dispatch_get_main_queue()) {
                        if url == self.imageUrl {
                            if imageData != nil {
                                print("IMAGE: ",imageData!)
                                self.tweetImageView?.image = UIImage(data: imageData!)
                            } else {
                                self.tweetImageView?.image = nil
                            }
                            self.spinnyThing?.stopAnimating()
                        }
                    }
                }
            } else {
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                    let imageData = NSData(contentsOfURL: url)
                    dispatch_async(dispatch_get_main_queue()) {
                        if url == self.imageUrl {
                            if imageData != nil {
                                print("IMAGE: ",imageData!)
                                self.tweetImageView?.image = UIImage(data: imageData!)
                            } else {
                                self.tweetImageView?.image = nil
                            }
                            self.spinnyThing?.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
}
