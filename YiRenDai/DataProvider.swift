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
    
    //创建单例对象
    static let sharedInstance = DataProvider()
    
    //私有化对象，只能通过单例对象调用
    private init(){}
    
    //获取单例对象
    private let obj = NetworkRequest.sharedInstance
    
    //MARK: - 登陆、注册
    
    /**
     注册
     
     - parameter account:  账号
     - parameter password: 密码
     - parameter userName: 用户名
     - parameter IDNo:     身份证号
     - parameter handler:  回调
     */
    func register(account: String, password: String, userName: String, IDNo: String, handler: (state: Int, message: String) -> Void){
        let url = "\(URL)member/register"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\",\"member_truename\":\"\(userName)\",\"member_card\":\"\(IDNo)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            let state = json["status"]["succeed"].intValue
            let message = json["status"]["message"].stringValue
            handler(state: state, message: message)
        }
    }
    
    /**
     登陆
     
     - parameter account:  账号
     - parameter password: 密码
     - parameter handler:  回调
     */
    func login(account: String, password: String, handler: (state: Int, message: String) -> Void){
        let url = "\(URL)member/login"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            let state = json["status"]["succeed"].intValue
            let message = json["status"]["message"].stringValue
            print(json)
            handler(state: state, message: message)
        }
    }
    
    //MARK: - 首页
    
    //MARK: - 产品列表
    
    //MARK: - 我的财富
    
    //MARK: - 理财圈
    
    //MARK: - 更多
}