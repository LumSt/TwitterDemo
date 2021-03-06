//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Lum Situ on 3/1/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    var tweet: Tweet!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = User.currentUser
        
        if tweet.profileBackgroundImageUrl != nil {
            backgroundImageView.setImageWith(tweet.profileBackgroundImageUrl!)
        }
        profileImageView.setImageWith(tweet.profileImageUrl!)
        usernameLabel.text = tweet.name
        screenNameLabel.text = "@\(tweet.screenName!)"
        introductionLabel.text = user.tagline!
        tweetsCount.text = "\(String(describing: user.tweetsCount!)) Tweets"
        followersCount.text = "\(String(describing: user.follwersCount!)) Followers"
        followingCount.text = "\(String(describing: user.follweringsCount!)) Followings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
