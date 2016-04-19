//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Sergei Hanka on 4/5/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
//    var hashtagColor = UIColor.blueColor()
//    var urlColor = UIColor.redColor()
//    var userMentionsColor = UIColor.greenColor()
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil

        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            format(tweet)
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
    
    private func format(tweet: Tweet) {
        
        let hashTagColor = UIColor(red:111/255, green:168/255, blue:220/255, alpha:1)
        let urlColor = UIColor.blueColor()
        let userMentionColor = UIColor.grayColor()
        
        var text = tweet.text
        for _ in tweet.media {
            text = text + " 📷"
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        if !tweet.hashtags.isEmpty {
            for ht in tweet.hashtags {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: hashTagColor, range: ht.nsrange)
            }
        }
        
        if !tweet.urls.isEmpty {
            for url in tweet.urls {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: urlColor, range: url.nsrange)
//                attributedString.addAttribute(NSLinkAttributeName, value: url, range: <#T##NSRange#>)
            }
        }
        
        if !tweet.userMentions.isEmpty {
            for um in tweet.userMentions {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: userMentionColor, range: um.nsrange)
            }
        }
        
        if tweet.hashtags.count + tweet.urls.count + tweet.userMentions.count + tweet.media.count > 0 {
            accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        } else {
            accessoryType = UITableViewCellAccessoryType.None
        }
        
        tweetTextLabel?.attributedText = attributedString
    }
}
