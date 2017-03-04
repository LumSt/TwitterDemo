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
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
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
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {

        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error: NSError) in
                self.loginFailure?(error)
            })
            
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
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
//            print("account: \(response)")
            let userDictionary = response as? NSDictionary
            
            let user = User(dictionary: userDictionary!)
            
            success(user)
//            print("name: \(user.name)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            failure(error as NSError)
//            print("GET error: \(error.localizedDescription)")
        })
    }
    
    func retweet(param: NSDictionary?, success: @escaping (_ tweet: Tweet?) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/statuses/retweet/\(param!["id"]!).json", parameters: param, progress: nil, success: { (task:URLSessionDataTask, reponse: Any?) in
            
            let tweet = Tweet.tweetAsDictionary(reponse as! NSDictionary)
            
            success(tweet)
            print("retweet is successful!")
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func favorite(param: NSDictionary?, success: @escaping (_ tweet: Tweet?) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/favorites/create.json", parameters: param, progress: nil, success: { (task:URLSessionDataTask, reponse: Any?) in
            let tweet = Tweet.tweetAsDictionary(reponse as! NSDictionary)
            
            success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func tweet (text:String, params:NSDictionary?, success: @escaping (Tweet) -> ()) {
        post("1.1/statuses/update.json?status=\(text)", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            success(tweet)
        }) { (task:URLSessionDataTask?, error:Error) in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func reply(replyTweet: String, statusID: Int, params: NSDictionary?, completion: @escaping (_ error: NSError?) -> () ){
        post("1.1/statuses/update.json?in_reply_to_status_id=\(statusID)&status=\(replyTweet)", parameters: params, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
            print("tweeted: \(replyTweet)")
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("Couldn't reply")
            completion(error as NSError?)
        }
        )
    }
}
