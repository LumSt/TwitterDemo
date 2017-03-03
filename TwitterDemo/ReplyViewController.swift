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
    
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.delegate = self
        textView.becomeFirstResponder()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)         
    }
    
    @IBAction func onTweetButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance?.tweet(text: text, success: { (Tweet) in
            self.text = self.textView.text
            print(self.text)
            print("Tweet successfully!")
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
