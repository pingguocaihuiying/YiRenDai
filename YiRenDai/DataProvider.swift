//
//  DataProvider.swift
//  YiRenDai
//
//  Created by Rain on 16/5/5.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataProvider {
    
    //获取单例对象
    static private let obj = NetworkRequest.sharedInstance
    
    //MARK: - 登陆、注册
    
    //注册
    static func register(account: String, password: String, userName: String, IDNo: String, handler: (state: Int, message: String) -> Void){
        let url = "\(URL)member/register"
        let params = ["json":"{\"member_username\":\(account),\"member_password\":\(password),\"member_truename\":\(userName),\"member_card\":\(IDNo)}"]
        obj.postRequest(url: url, params: params) { (json) in
            let state = json["status"]["succeed"].intValue
            let message = json["status"]["message"].stringValue
            handler(state: state, message: message)
        }
    }
    
    //MARK: - 首页
    
    //MARK: - 产品列表
    
    //MARK: - 我的财富
    
    //MARK: - 理财圈
    
    //MARK: - 更多
}