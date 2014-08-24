//
//  ComposeViewController.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/08/24.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

var prevText = ""

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toolBarBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden"), name: UIKeyboardWillHideNotification, object: nil)

        /*
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        self.textView.addGestureRecognizer(gestureRecognizer)
        */
        
        textView.becomeFirstResponder()
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        prevText = textView.text
    }
    
    override func viewWillAppear(animated: Bool) {
        textView.text = prevText
    }
    
    func keyboardWasShown(sender: NSNotification){
        let s = sender.userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue;
        let rect :CGRect = s.CGRectValue();
        
        self.toolBarBottom.constant = rect.height-49;
    }
    
    func hideKeyboard() {
        self.textView.resignFirstResponder()
    }
    
    func keyboardWillBeHidden(){
        self.toolBarBottom.constant = 0;
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendResponse(sender: AnyObject) {
    
        print(textView.text)
        //TODO: send to server
        
        SVProgressHUD.show()
    
        
        let manager = AFHTTPRequestOperationManager()
        var param:Dictionary<String, String> = ["username" : "your name", "text" : textView.text]
        manager.POST(API_ROOT+"/BBS/1", parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                println("response: \(responseObject)")
                
                self.textView.text = ""
                SVProgressHUD.showSuccessWithStatus("Success!!")
                self.navigationController.popViewControllerAnimated(true)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("Error: \(error)")
                
                SVProgressHUD.showErrorWithStatus("Network error")
        })

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
