//
//  User.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String
    var screenName: String
    var url: NSURL?
    var tagLine: String
    var dictionary: NSDictionary?
    var id: Int                                        //
    var tweetsCount: Int?
    var likesCount: Int?
    var followingCount: Int
    var followersCount: Int
    
    var profileBannerImage: NSURL?
    var profileBackgroundImage: NSURL?
    var location: String
    
    
    

    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = (dictionary["name"] as? String)!
        screenName = (dictionary["screen_name"] as! String)
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            url = NSURL(string: profileUrlString)
        }
        
        let profileBannerImageString = dictionary["profile_banner_url"] as? String
        
        if let profileBannerImageString = profileBannerImageString {
            profileBannerImage = NSURL(string: profileBannerImageString)
        }
        
        let profileBackgroundImageString = dictionary["profile_background_image_url"] as? String
        
        if let profileBackgroundImageString = profileBackgroundImageString {
            profileBackgroundImage = NSURL(string: profileBackgroundImageString)
        }

     
        
        tagLine = (dictionary["description"] as? String)!
        
        //
        
        id = (dictionary["id"] as? Int)!
        
        tweetsCount = dictionary["statuses_count"] as? Int
        likesCount = dictionary["favourites_count"] as? Int
        followingCount = (dictionary["friends_count"] as? Int)!
        followersCount = (dictionary["followers_count"] as? Int)!
        
        location = (dictionary["location"] as! String)
        
    }
    
    static var _currentUser: User?
    
    static let userDidlogoutNotification = "UserDidLogout"
    
    class var currentUser : User? {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
        if let userData = userData {
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as? NSDictionary
        
        _currentUser = User(dictionary: dictionary!)
                }
        
            }
        
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }
            else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
    

}
