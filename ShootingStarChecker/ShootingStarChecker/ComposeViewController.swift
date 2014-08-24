//
//  ComposeViewController.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/08/24.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

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

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
