//
//  twitterClient.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class twitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = twitterClient(baseURL: NSURL(string: "https://api.twitter.com") , consumerKey: "cfBGYu04LsmGeuj6ALRBuFArc", consumerSecret: "HQXGIF5nVAFN7BJWZapqG2dSP70O3R4BuT4sxybz2izQN740vm")
    
    var loginSucces: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    
    func login(success: () -> () , failure: (NSError) -> () ) {
        loginSucces = success
        loginFailure = failure
        
        
        
        deauthorize()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "Get", callbackURL: NSURL(string: "mytwitterDemo://oauth"), scope: nil, success: { (requestToken:
            BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }
    
    func currentAccount() {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            // print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            // print("name: \(userDictionary["name"])")
            
            let user = User(dictionary: userDictionary)
            
            
            print(user.name)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        })
        
    }
    
    
    func homeTimeLine(success: ([Tweet] -> ()), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArrays(dictionaries)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "Post", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            self.loginSucces?()
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
                
                
        }

        
        
     
        
    }

}
