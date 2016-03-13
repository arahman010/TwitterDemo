//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/6/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // Buttons
    
    @IBOutlet weak var replyButton: UIButton!
  
    @IBOutlet weak var retweetButton: UIButton!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    //
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweetId : String?
    var currentUserDidRetweet: Bool = false
    var currentUserDidFavorite: Bool = false
    
    
    
    
    var tweet: Tweet! {
        didSet {
            tweetId = String(tweet.tweetId)
            tweetTextLabel.text = tweet.text as? String
            timeStampLabel.text = tweet.timeStamp
            nameLabel.text = tweet.user!.name as? String
            usernameLabel.text = "@\(tweet.user!.screenName!)"
            
            let imageUrl = tweet.user?.url
            
            profileImageView.setImageWithURL(imageUrl!)
           
            
            profileImageButton.setImageForState(UIControlState.Normal, withURL: imageUrl!)
            
            
            //
            if tweet.retweetCount == 0 {
                retweetCount.text = ""
            } else {
                retweetCount.text = String(tweet.retweetCount)
            }
            
            if tweet.retweetedByCurrentUser == true {
                retweetButton.setImage(UIImage(named: "retweet-action-on-green.png"), forState: UIControlState.Normal)
            }
            
            if tweet.favoriteCount == 0 {
                favoriteCount.text = ""
            } else {
                favoriteCount.text = String(tweet.favoriteCount)
            }
            
            if tweet.favoritedByCurrentUser == true {
                favoriteButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
            }
            
            currentUserDidRetweet = tweet.retweetedByCurrentUser!
            currentUserDidFavorite = tweet.favoritedByCurrentUser!
            
            retweetButton.setImage(UIImage(named: "retweet-action-inactive.png"), forState: UIControlState.Normal)
            
            retweetButton.enabled = true
            if tweet.user?.screenName == User._currentUser?.screenName {
                retweetButton.enabled = false
            } else {
                retweetButton.setImage(UIImage(named: "retweet-action_default.png"), forState: UIControlState.Normal)
            }
            
            if currentUserDidRetweet {
                retweetButton.setImage(UIImage(named: "retweet-action-on-green.png"), forState: UIControlState.Normal)
            }
            
            favoriteButton.setImage(UIImage(named: "like-action-off.png"), forState: UIControlState.Normal)
            
            if currentUserDidFavorite {
                favoriteButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
            }
            
            
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if (profileImageView == nil )
        {
            print("imageView is nil")
        }
        else {
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        }
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        usernameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        usernameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //
    
    @IBAction func onTapOnImage(sender: AnyObject) {
        print("Tapped")
    
    
    }
    

    

    
    
    
    
    
    
    
    //
    
    @IBAction func onRetweet(sender: AnyObject) {
        
        if !currentUserDidRetweet {
            twitterClient.sharedInstance.retweet(tweetId!)
            
            
            retweetButton.setImage(UIImage(named: "retweet-action-on-pressed_green.png"), forState: UIControlState.Highlighted)
            retweetButton.setImage(UIImage(named: "retweet-action-on-green.png"), forState: UIControlState.Normal)
            
            tweet.retweetCount += 1
            retweetCount.text = "\(tweet.retweetCount)"
            currentUserDidRetweet = true
            
        } else {
            twitterClient.sharedInstance.unretweet(tweetId!)
            
            retweetButton.setImage(UIImage(named: "retweet-action_default.png"), forState: UIControlState.Normal)
            tweet.retweetCount -= 1
            
            if tweet.retweetCount == 0 {
                retweetCount.text = ""
            } else {
                retweetCount.text = "\(tweet.retweetCount)"
            }
            currentUserDidRetweet = false
            
        }
        
        
    
    
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        if !currentUserDidFavorite {
            twitterClient.sharedInstance.favorite(tweetId!)
            
            favoriteButton.setImage(UIImage(named: "like-action-on-pressed-red.png"), forState: UIControlState.Highlighted)
            favoriteButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
            
            tweet.favoriteCount += 1
            favoriteCount.text = "\(tweet.favoriteCount)"
            currentUserDidFavorite = true
            
        } else {
            twitterClient.sharedInstance.unfavorite(tweetId!)
            favoriteButton.setImage(UIImage(named: "like-action-off.png"), forState: UIControlState.Normal)
            tweet.favoriteCount -= 1
            
            if tweet.favoriteCount == 0 {
                favoriteCount.text = ""
                
            } else {
                favoriteCount.text = "\(tweet.favoriteCount)"
                
            }
            currentUserDidFavorite = false
            
        }
    }

    
    
  
    

}
