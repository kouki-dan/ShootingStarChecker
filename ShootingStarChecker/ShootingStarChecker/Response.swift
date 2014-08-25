//
//  Response.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/08/25.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Response : NSObject{
    let id:Int
    let name:String
    let text:String
    
    init(id:Int, name:String, text:String){
        self.id = id
        self.name = name
        self.text = text
    }
    
    override var description: String{
        return "\(id):\(text)\n"
    }

}