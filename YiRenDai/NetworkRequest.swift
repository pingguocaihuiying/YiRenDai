//
//  NetworkRequest.swift
//  YiRenDai
//
//  Created by Rain on 16/5/5.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkRequest {
    
    //创建单例对象
    static let sharedInstance = NetworkRequest()
    
    //私有化对象，只能通过单例对象调用
    private init(){}
    
    /**
     GET请求
     - parameter url: url地址
     */
    func getRequest(url url: String){
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            if let json = response.result.value{
                print("json：\(json)")
            }
        }
    }
    
    /**
     POST请求
     - parameter url:    url地址
     - parameter params: 参数
     */
    func postRequest(url url: String, params: [String:String], handler:(json: JSON) -> Void){
        LoadingAnimation.show()
        Alamofire.request(.POST, url, parameters: params).responseJSON { (response) -> Void in
            if let json = response.result.value{
                LoadingAnimation.dismiss()
                handler(json: JSON(json))
            }
        }
    }
}