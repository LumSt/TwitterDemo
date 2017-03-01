//
//  detailViewController.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/27/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit
import AFNetworking

class detailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetsCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    var tweetId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileImageView.setImageWith(tweet!.profileImageUrl!)
        usernameLabel.text = tweet.name
        screenNameLabel.text = "@\(tweet.screenName!)"
        tweetLabel.text = tweet.text
        timeLabel.text = DateFormatter.localizedString(from: (tweet.timeStamp!), dateStyle: DateFormatter.Style(rawValue: 1)!, timeStyle: DateFormatter.Style(rawValue: 1)!)
        retweetsCount.text = "\(String(describing: tweet.retweetCount!)) RETWEETS"
        likesCount.text = "\(String(describing: tweet.favoriteCount!)) LIKES"
        
        tweetId = tweet.id as! Int
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        print("retweet button is clicked!")
        TwitterClient.sharedInstance!.retweet(param: ["id":tweetId], success: { (tweet) in
            self.retweetsCount.text = String(describing: tweet!.retweetCount!)
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }, failure: { (error:Error) in
            print("Error: \(error.localizedDescription)")
        })
    }

    @IBAction func onFavoriteButton(_ sender: Any) {
        print("favorite button is clicked!")
        TwitterClient.sharedInstance?.favorite(param: ["id":tweetId], success: { (tweet) in
            self.likesCount.text = String(describing: tweet!.favoriteCount!)
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
