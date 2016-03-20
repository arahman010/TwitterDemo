//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/19/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

@objc protocol ComposeTweetViewControllerDelegate {
    optional func composeTweetViewController(composeTweetViewController: ComposeViewController, didUpdateTweet newTweet: Tweet)
}

class ComposeViewController: UIViewController {
    
    weak var delegate: ComposeTweetViewControllerDelegate?


    @IBOutlet weak var tweetTextView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    @IBAction func onTweetClicked(sender: AnyObject) {
       
        
        
        let apiParameters = NSMutableDictionary()
        apiParameters["status"] = tweetTextView.text!
        twitterClient.sharedInstance.replyToTweetWithCompletion(apiParameters) { (tweet, error) -> () in
            
            if tweet != nil
            {
            print("tweet is not nil")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
            else {
                print("Tweet Nil")
            }
            
    }
        
    }
    
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        
        view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    
        
    
    
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
