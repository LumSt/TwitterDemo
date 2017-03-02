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
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var segueButton: UIButton!
    
    
    var tweetId: NSNumber?
    
    
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
            
            retweetCountLabel.text = String(describing: tweet.retweetCount!)
            
            favoriteCountLabel.text = String(describing: tweet.favoriteCount!)
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            
            if tweet.retweetedStatus != nil {
                let retweet = Tweet.tweetAsDictionary(tweet.retweetedStatus!)
                tweetId = retweet.id
                
//                tweetId = Tweet.tweetAsDictionary(dic: tweet).id
            } else {
                tweetId = tweet.id
            }

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
    
    
    @IBAction func onRetweetButton(_ sender: Any) {
        print("retweet button is clicked!")
        TwitterClient.sharedInstance!.retweet(param: ["id":tweetId!], success: { (tweet) in
            self.retweetCountLabel.text = String(describing: tweet!.retweetCount!)
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }, failure: { (error:Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        print("favorite button is clicked!")
        TwitterClient.sharedInstance?.favorite(param: ["id":tweetId!], success: { (tweet) in
            self.favoriteCountLabel.text = String(describing: tweet!.favoriteCount!)
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }

}
