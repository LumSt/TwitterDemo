//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/19/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contributorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            contributorLabel.text = tweet!.name
            
            screenNameLabel.text = ("@\(tweet.screenName!)")
            
            dateLabel.text = DateFormatter.localizedString(from: tweet.timeStamp!, dateStyle: DateFormatter.Style(rawValue: 0)!, timeStyle: DateFormatter.Style(rawValue: 1)!)
            
            tweetTextLabel.text = tweet.text
            if let imageUrl = tweet.profileImageUrl {
                profileImage.setImageWith(imageUrl)
            } else {
                print("NO ImageUrl!")
            }
            
            replyButton.setImage(#imageLiteral(resourceName: "reply-icon"), for: .normal)
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
