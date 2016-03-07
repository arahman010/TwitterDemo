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
    
    /// *********************
    
    /**
    * POST /statuses/retweet/
    * Params: String tweetId
    *
    * Retweets a status (specified by the tweetId) that isn't owned by the User.
    */
    
    func retweet(tweetId: String) {
        POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Retweeting a tweet!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        })
    }
    
    /**
     * POST /statuses/unretweet/
     * Params: String tweetId
     *
     * Unetweets a status (specified by the tweetId) that was already retweeted by the
     * User.
     */
    
    func unretweet(tweetId: String) {
        POST("1.1/statuses/unretweet/\(tweetId).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Unretweeting a tweet!")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    /**
     * POST /favorites/create/
     * Params: String tweetId
     *
     * Favorites a status (specified by the tweetId), can be a tweet owned by the User.
     */
    
    func favorite(tweetId: String) {
        POST("1.1/favorites/create.json?id=\(tweetId)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Favoriting a tweet")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    /**
     * POST /favorites/destroy/
     * Params: String tweetId
     *
     * Unfavorites a status (specified by the tweetId), can be a tweet owned by the User.
     */
    
    func unfavorite(tweetId: String) {
        POST("/1.1/favorites/destroy.json?id=\(tweetId)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Unfavoriting a tweet")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    
    //*******************
    
    
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidlogoutNotification, object: nil)
    }
    
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> () ) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary

            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
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
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                 
                self.loginSucces?()
                
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
                
                
        }

        
        
     
        
    }

}
