//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    var tweetUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        twitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
                self.tweets = tweets
            
                for tweet in tweets {
                    self.tweets.append(tweet)
                }
            self.tableView.reloadData()
                
                }, failure: { (error: NSError) -> () in
                    print(error.localizedDescription)
            })
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        twitterClient.sharedInstance.logout()
    }
    
    //
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        }
        else {
            return 0
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        tweetUser = cell.tweet.user
    
        return cell
        
        
        
    }
    
    
    
  
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "UserProfileSegue"
        {
            print("tapped")
            let userProfileViewController = segue.destinationViewController as! UserProfileViewController
            
            
            userProfileViewController.user = tweetUser
            
            
            
        }
        if segue.identifier == "SelectedTweetSegue" {
            
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let selectedTweetViewController = segue.destinationViewController as! SelectedTweetViewController
        selectedTweetViewController.tweet = tweets[indexPath!.row] as Tweet
        
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
