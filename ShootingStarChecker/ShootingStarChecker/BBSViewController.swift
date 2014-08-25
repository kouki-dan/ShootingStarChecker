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
    let refreshControl = UIRefreshControl()
    var bbs:BBS! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refreshControl.addTarget(self, action: Selector("refreshOccured:"), forControlEvents: UIControlEvents.ValueChanged)
        bbsTableView.alwaysBounceVertical = true
        bbsTableView.addSubview(refreshControl)
        
        bbs = BBS(bbsId: 1)
        bbs.addObserver(self, forKeyPath: "responses", options: NSKeyValueObservingOptions(), context: nil)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.bbs.more()
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>) {
        self.bbsTableView.reloadData()
    }
    
    func refreshOccured(sender:AnyObject!){
        print("reload")
        self.bbs.more()
    
        refreshControl.endRefreshing()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        if bbsTableView.contentOffset.y >= bbsTableView.contentSize.height - bbsTableView.bounds.size.height{
            self.bbs.less()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return bbs.responseCount()
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MainCell")
        cell.textLabel.text = bbs.responseWithNumber(indexPath.row).text
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
