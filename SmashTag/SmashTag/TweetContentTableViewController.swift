//
//  MentionsTableViewController.swift
//  SmashTag
//
//  Created by Sergei Hanka on 4/17/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class TweetContentTableViewController: UITableViewController {
    
    var tweet: Tweet? {
        didSet {
            title = tweet?.user.screenName
            if let media = tweet?.media {
                content.append(TweetContent(title: "Images",
                    data: media.map { TweetData.Image($0.url, $0.aspectRatio) }))
            }
            if let urls = tweet?.urls {
                content.append(TweetContent(title: "URLs",
                    data: urls.map { TweetData.Keyword($0.keyword) }))
            }
            if let hashtags = tweet?.hashtags {
                content.append(TweetContent(title: "Hashtags",
                    data: hashtags.map { TweetData.Keyword($0.keyword) }))
            }
            if let users = tweet?.userMentions {
                content.append(TweetContent(title: "Users",
                    data: users.map { TweetData.Keyword($0.keyword) }))
            }
        }
    }
    
    var content: [TweetContent] = []
    
    struct TweetContent: CustomStringConvertible
    {
        var title: String
        var data: [TweetData]
        
        var description: String { return "\(title): \(data)" }
    }
    
    enum TweetData: CustomStringConvertible
    {
        case Keyword(String)
        case Image(NSURL, Double)
        
        var description: String {
            switch self {
            case .Keyword(let keyword): return keyword
            case .Image(let url, _): return url.path!
            }
        }
    }
    
    // MARK: - UITableViewControllerDataSource
    
    private struct Storyboard {
        static let KeywordCellReuseIdentifier = "ContentView"
        static let ImageCellReuseIdentifier = "ImgView"
        static let ImageViewReuseIdentifier = "showImage"
        static let ClickSearchReuseIdentifier = "clickToSearch"
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return content.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let mention = content[indexPath.section].data[indexPath.row]
        
        switch mention {
        case .Keyword(let keyword):
            let cell = tableView.dequeueReusableCellWithIdentifier(
                Storyboard.KeywordCellReuseIdentifier,
                forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = keyword
            return cell
        case .Image(let url, _): //could be let ratio instead of _
            let cell = tableView.dequeueReusableCellWithIdentifier(
                Storyboard.ImageCellReuseIdentifier,
                forIndexPath: indexPath) as! TweetContentTableViewCell
            cell.imageUrl = url
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = content[indexPath.section].data[indexPath.row]
        switch data {
        case .Image(_, let ratio):
            return tableView.bounds.size.width / CGFloat(ratio)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print((content[section].data),":",(content[section].data).count)
        if content[section].data.count != 0 {
            return self.content[section].title
        }
        return ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == Storyboard.ClickSearchReuseIdentifier {
                if let mtvc = segue.destinationViewController as? TweetTableViewController {
                    if let theTweet = sender as? UITableViewCell {
                        mtvc.searchText = theTweet.textLabel?.text
                    }
                }
            }
            if identifier == Storyboard.ImageViewReuseIdentifier {
                if let imgvc = segue.destinationViewController as? ImageViewController {
                    if let cell = sender as? TweetContentTableViewCell {
                        print(cell.imageUrl)
                        imgvc.imageURL = cell.imageUrl
                    }
                }
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == Storyboard.ClickSearchReuseIdentifier {
            if let cell = sender as? UITableViewCell {
                if let url = cell.textLabel?.text {
                    if url.containsString("https://") {
                        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
                        return false
                    }
                }
            }
        }
        return true
    }
}