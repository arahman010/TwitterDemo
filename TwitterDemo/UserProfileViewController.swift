//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/13/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var locationLabe: UILabel!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var followerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "@\(user!.screenName)"
        nameLabel.text = user?.name
        tagLineLabel.text = user?.tagLine
        
        if (user?.followersCount > 1000)
        {
            followerLabel.text = "\(user!.followersCount/1000)K"
        }
        else {
            followerLabel.text = "\(user!.followersCount)"
            
        }
        if (user?.followingCount > 1000 )
            {
                followingLabel.text = "\(user!.followingCount/1000)k"
                
        }
        else {
            followingLabel.text = "\(user!.followingCount)"
        }
        
        if (user?.profileBannerImage != nil)
        {
        bannerImageView.setImageWithURL((user?.profileBannerImage)!)
        }
        
        profileImageview.setImageWithURL(user!.url!)
        locationLabe.text = user?.location
        
        

        // Do any additional setup after loading the view.
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
