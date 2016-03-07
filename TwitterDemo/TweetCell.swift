//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Azizur Rahman on 3/6/16.
//  Copyright © 2016 Azizur Rahman. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text as? String
            timeStampLabel.text = tweet.timeStamp
            nameLabel.text = tweet.user!.name as? String
            usernameLabel.text = "@\(tweet.user!.screenName!)"
            profileImageView.setImageWithURL(tweet.user!.url!)
            
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
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

}
