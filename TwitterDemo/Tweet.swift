//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/18/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int
    var favoritesCount: Int
    var name: NSString?
    var profileImageUrl: NSURL?
    
    var user: NSDictionary?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String as NSString?
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString) as NSDate?
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        user = dictionary["user"] as? NSDictionary
        
        name = user?["name"] as? NSString
        
        let profileImageUrlString = user?["profile_image_url"] as? String
        if let profileImageUrlString = profileImageUrlString {
            profileImageUrl = NSURL(string: profileImageUrlString)
            print(profileImageUrlString)
        } else {
            profileImageUrl = nil
            print("NO profile image url!")
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets 
    }
}
