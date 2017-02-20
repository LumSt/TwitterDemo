//
//  User.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/18/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString?
    var screenName: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as! NSString?
        screenName = dictionary["screen_name"] as! NSString?
        
        let profileUrlString = dictionary["profile_image_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        tagline = dictionary["description"] as! NSString?
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
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
