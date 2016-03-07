//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: NSString?
    var timeStamp: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone.localTimeZone()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            let times = formatter.dateFromString(timeStampString as String)?.timeIntervalSinceNow
            timeStamp = Tweet.gettingTimestamp(times!)
        
        }
        
    }
    
    
 
    
    
    
    class func tweetsWithArrays(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
            
        }
        
        return tweets
    }
    
    
    class func gettingTimestamp(time : NSTimeInterval) -> String {
        let timeSeconds = -Int(time)
        var timeSince: Int = 0
        
        if timeSeconds == 0 {
            return "Now"
        }
        
        if timeSeconds <= 60 {
            timeSince = timeSeconds
            return "\(timeSince)s"
        }
        
        if timeSeconds/60 < 60 {
            timeSince = timeSeconds/60
            return "\(timeSince)m"
        }
        
        if (timeSeconds/60)/60 < 24 {
            timeSince = (timeSeconds/60)/60
            return "\(timeSince)h"
        }
        
        if ((timeSeconds/60)/60)/24 < 365 {
            timeSince = ((timeSeconds/60)/60)/24
            return "\(timeSince)d"
        }
        
        if (((timeSeconds/60)/60)/24)/365 < 100 {
            timeSince = ((((timeSeconds)/60)/60)/24)/365
            return "\(timeSince)y"
        }
        
        return "\(timeSince)"
    }

}
