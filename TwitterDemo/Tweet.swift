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
//    var retweetCount: Int
//    var favoritesCount: Int
    var name: String?
    var screenName: String!
    var profileImageUrl: URL?
    var id: NSNumber?
    var retweetCount:Int?
    var favoriteCount: Int?
    var retweetedStatus: NSDictionary?

    
    
//    var timestampString: String!
    
    var user: NSDictionary?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString) as Date?
//            print(timeStamp!)
        }
        
//        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
//        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
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
