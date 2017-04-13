//
//  NetWorkTools.swift
//  DYZB
//
//  Created by xue on 2017/4/12.
//  Copyright © 2017年 liangxue. All rights reserved.
//

import UIKit

import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkTools {
    

    //post请求
    class func requestDataWithPost(URLString:String,parameters:[String:NSString]? = nil,finishedCallBack:@escaping (_ result:AnyObject) -> ()) {
        
        Alamofire.request(URLString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            guard let JSON = response.result.value else {

                print(response.result.value)
                return
            }
            
            finishedCallBack(JSON as AnyObject)
        }
    }
    
    //get 请求
    class func requestDataWithGet(URLString:String,parameters:[String:NSString]? = nil,finishedCallBack:@escaping (_ result:AnyObject) -> ()) {
        
        Alamofire.request(URLString, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            guard let JSON = response.result.value else {
                
                print(response.result.value)
                return
            }
            
            finishedCallBack(JSON as AnyObject)
        }
    }

}
