//
//  User.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/5/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenName: NSString?
    var url: NSURL?
    var tagLine: NSString?
    
    init(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            url = NSURL(string: profileUrlString)
        }
        
        tagLine = dictionary["description"] as? String
        
    }
    

}
