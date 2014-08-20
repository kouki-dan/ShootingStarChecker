//
//  BBSViewController.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/08/12.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

class BBSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var bbsTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var inputField: UIView!
    
    @IBOutlet weak var inputFieldBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden"), name: UIKeyboardWillHideNotification, object: nil)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        self.bbsTableView.addGestureRecognizer(gestureRecognizer)
        
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    func keyboardWasShown(sender: NSNotification){
        let s = sender.userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue;
        let rect :CGRect = s.CGRectValue();

        self.inputFieldBottom.constant = rect.height-49;

    }
    
    func hideKeyboard() {
        self.textField.resignFirstResponder()
    }
    
    func keyboardWillBeHidden(){
        self.inputFieldBottom.constant = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return 10
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MainCell")
        cell.textLabel.text = "testing"
        return cell;
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        println(indexPath.row)
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
