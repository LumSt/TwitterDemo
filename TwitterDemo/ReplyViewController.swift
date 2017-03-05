//
//  ReplyViewController.swift
//  TwitterDemo
//
//  Created by Lum Situ on 3/1/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    var user: User!
    var tweet: Tweet!
    var text: String = ""
    var isToReply: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = User.currentUser
        textView.delegate = self
        textView.becomeFirstResponder()
        
        if isToReply {
            textView.text = "@\(tweet.screenName!) "
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)         
    }
    
    @IBAction func onTweetButton(_ sender: UIBarButtonItem) {
        text = textView.text
        let TweetMessage = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if isToReply == true {
            TwitterClient.sharedInstance?.reply(replyTweet: TweetMessage!, statusID: tweet.id as! Int, params: nil, completion: { (error:Error?) in
                print("Reply successfully!")
            })
        } else {
            TwitterClient.sharedInstance?.tweet(text: TweetMessage!, params:nil, success: { (Tweet) in
                
                print("Tweet successfully!")
                
            })
        }
        
        self.dismiss(animated: true)
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
