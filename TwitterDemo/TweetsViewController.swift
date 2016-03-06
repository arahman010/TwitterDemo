//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        twitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
                self.tweets = tweets
            
                for tweet in tweets {
                    print("\(tweet.text!)")
                }
                
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
