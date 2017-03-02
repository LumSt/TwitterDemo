//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/18/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timeStamp: Date?
    var name: String?
    var screenName: String!
    var profileImageUrl: URL?
    var id: NSNumber?
    var retweetCount:Int?
    var favoriteCount: Int?
    var retweetedStatus: NSDictionary?
    
    var user: NSDictionary?
    
    var profileBackgroudImageUrl: URL?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString) as Date?
//            print(timeStamp!)
        }
                
        user = dictionary["user"] as? NSDictionary
        
        name = user?["name"] as? String
        
        screenName = user?["screen_name"] as! String
        
        let profileImageUrlString = user?["profile_image_url"] as? String
        if let profileImageUrlString = profileImageUrlString {
            profileImageUrl = URL(string: profileImageUrlString)
            
        } else {
            profileImageUrl = nil
            print("NO profile image url!")
        }
        
        id = dictionary["id"] as? Int as NSNumber?
        
        retweetCount = dictionary["retweet_count"] as? Int ?? 0
        
        favoriteCount = dictionary["favorite_count"] as? Int ?? 0
        
        retweetedStatus = dictionary["retweet_status"] as? NSDictionary
        
        let profileBackgroundImageUrlString = user?["profile_background_image_url_https"] as? String
        if let profileBackgroundImageUrlString = profileBackgroundImageUrlString {
            profileBackgroudImageUrl = URL(string: profileBackgroundImageUrlString)
        } else {
            profileBackgroudImageUrl = nil
            print("NO backbround image url!")
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        

//        print("TWEETS!!!!!!")
        for tweet in tweets {
//            print( tweet.id! )
        }
        
        return tweets 
    }
    
    class func tweetAsDictionary(_ dic: NSDictionary) -> Tweet{
        let tweet = Tweet(dictionary: dic)
        
        return tweet
    }
}
