//
//  SelectedTweetViewController.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/12/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class SelectedTweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        tableView.reloadData()
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    // Functions for tableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 1;
    
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        cell.tweet = tweet
        
        
        
        return cell;
    
    
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    
  /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let largeImageViewController = segue.destinationViewController as! LargeImageViewController
        largeImageViewController.url = tweet.user?.url
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


    */

}
