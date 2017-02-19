//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Lum Situ on 2/18/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com"), consumerKey: "6AIJcovONDCExACdSFRyb41Qp", consumerSecret: "wwRyhcedhVsN0ARnUarQzgZF0b5BkHUPfB6e1dbWWw4cbrIgjL")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
//            print("I got a token!")
//            print(requestToken?.token! ?? "No token!")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
//            print(url ?? "No url!")
            UIApplication.shared.openURL((url as? URL)!)
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func handleOpenUrl(url: NSURL) {

        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.loginSuccess?()
            
        }, failure: { (error: Error?) in
            print("Access token error:\(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as? [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionary!)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    
    func currentAccount() {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
//            print("account: \(response)")
            let userDictionary = response as? NSDictionary
            
            let user = User(dictionary: userDictionary!)
            print("name: \(user.name)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("GET error: \(error.localizedDescription)")
        })
    }
}
