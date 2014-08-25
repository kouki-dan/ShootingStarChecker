//
//  BBS.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/08/24.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class BBS : NSObject{
    let apiPath:String
    var maxId = Int.min
    var minId = Int.max
    var responses:Array<Response> = Array()
    var loading = false
    var allLoaded = false
    
    init(bbsId:Int){
        apiPath = API_ROOT + "/BBS/" + String(bbsId)
        super.init()
        fetchResponses()
    }
    
    func responseWithNumber(num:Int)->Response{
        return responses[num]
    }

    func responseCount()->Int{
        return responses.count
    }
    
    func more(){
        var params:Dictionary<String, String> = ["more_than" : String(maxId)]
        fetchResponses(params: params)
    }
    
    func less(){
        var params:Dictionary<String, String> = ["less_than" : String(minId)]
        fetchResponses(params: params)
    }
    
    func fetchResponses(params :Dictionary<String, String>! = nil){
        
        if(self.loading){
            return
        }
        self.loading = true
        
        SVProgressHUD.show()
        let manager = AFHTTPRequestOperationManager()
        manager.GET(API_ROOT+"/BBS/1", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                SVProgressHUD.dismiss()
                
                var responseBuffer:Array<Response> = Array()
                let responses = responseObject as? Array<AnyObject>
                for response in responses! {
                    responseBuffer = responseBuffer + [self.parseResponse(response)]
                }
                
                if(responseBuffer.count == 0){
                    print("no more values")
                    self.loading = false
                    return
                }
                
                self.willChangeValueForKey("responses")
                
                if(responseBuffer.last!.id > self.maxId){
                    self.maxId = responseBuffer.first!.id
                    self.responses = responseBuffer + self.responses
                }
                else if(responseBuffer.first!.id < self.minId){
                    self.minId = responseBuffer.last!.id
                    self.responses = self.responses + responseBuffer
                }
                self.maxId = self.responses.first!.id
                self.minId = self.responses.last!.id
                
                self.didChangeValueForKey("responses")

                
                println(self.responses)
                println("max:\(self.maxId)")
                println("min:\(self.minId)")
                self.loading = false
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                SVProgressHUD.showErrorWithStatus("Network error")
                println("Error: \(error)")
                self.loading = false
        })
    }
    
    func parseResponse(res:AnyObject!)->Response{
        let dictResponse = res as Dictionary<String, String>!
        let response = Response(id: dictResponse["id"]!.toInt()!, name: dictResponse["username"]!, text: dictResponse["text"]!)
        
        return response
        
    }
    
}

