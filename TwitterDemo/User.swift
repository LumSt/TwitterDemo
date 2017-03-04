//
//  User.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/18/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String!
    var profileUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary?
    var tweetsCount:Int?
    var follwersCount:Int?
    var follweringsCount:Int?
    
    var backgroundImageUrl: URL?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as! String?
        screenName = dictionary["screen_name"] as! String?
        
        let profileUrlString = dictionary["profile_image_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as! String?
        tweetsCount = dictionary["statuses_count"] as! Int?
        follwersCount = dictionary["followers_count"] as! Int?
        follweringsCount = dictionary["friends_count"] as! Int?
        
        let backgroundImageUrlString = dictionary["profile_background_image_url_https"] as? String
        print(backgroundImageUrlString ?? 0)
        if let backgroundImageUrlString = backgroundImageUrlString {
            backgroundImageUrl = URL(string: backgroundImageUrlString)
        } else {
            backgroundImageUrl = nil
            print("NO backbround image url!")
        }
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
    
        get {
            
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    if let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as? NSDictionary {
                        print(dictionary)
                        _currentUser = User(dictionary: dictionary)
                    } else {
                        _currentUser = nil
                    }
                    
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = _currentUser {
                
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
//                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
