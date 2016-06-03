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
     - parameter handler:  回调方法
     */
    func register(account: String, password: String, userName: String, IDNo: String, handler: (state: Int, message: String) -> Void){
        let url = "\(URL)/member/register"
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
     - parameter handler:  回调方法
     */
    func login(account: String, password: String, handler: (state: Int, message: String, data: JSON) -> Void){
        let url = "\(URL)/member/login"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            let state = json["status"]["succeed"].intValue
            let message = json["status"]["message"].stringValue
            let data = json["data"]
            handler(state: state, message: message, data: data)
        }
    }
    
    /**
     重新设置密码
     - parameter account:  账号
     - parameter password: 密码
     - parameter handler:  回调方法
     */
    func resetPwd(account: String, password: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/member/resetPassword"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 首页
    /**
     获取安全保障
     - parameter slide_type: 1 首页  2 安全保障
     - parameter handler:    回调方法
     */
    func getSlide(slide_type: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/slide/getSlides"
        let params = ["json":"{\"slide_type\":\"\(slide_type)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    /**
     支付 - 获取charge
     - parameter product_id:   产品id
     - parameter member_id:    用户id
     - parameter order_amount: 支付金额
     - parameter pay_method:   支付方式
     - parameter handler:      回调方法
     */
    func getCharge(product_id: String, member_id: String, order_amount: String, pay_method: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/order/create"
        let params = ["json":"{\"product_id\":\"\(product_id)\",\"member_id\":\"\(member_id)\",\"order_amount\":\"\(order_amount)\",\"pay_method\":\"\(pay_method)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 产品列表
    /**
     获取产品列表
     - parameter is_sell:    上架，1：是；0：否
     - parameter pagenumber: 页码
     - parameter pagesize:   每页个数
     - parameter handler:    回调方法
     */
    func getProductList(is_sell: String,pagenumber: String, pagesize: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/product/getProductList"
        let params = ["json":"{\"is_sell\":\"\(is_sell)\"}","page":"{\"pagenumber\":\"\(pagenumber)\",\"pagesize\":\"\(pagesize)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    /**
     根据产品ID获取产品详情
     - parameter product_id: 产品ID
     - parameter handler:    回调方法
     */
    func getProductDetail(product_id: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/product/getProductList"
        let params = ["json":"{\"product_id\":\"\(product_id)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 我的财富
    
    //MARK: - 理财圈
    /**
     获取文章列表
     - parameter channel_id:  文章分类ID,1:理财圈；2：活动中心
     - parameter status_code: 隐藏或者显示的标识，1：显示；0：隐藏
     - parameter pagenumber:  页码
     - parameter pagesize:    每页个数
     - parameter handler:     回调方法
     */
    func getArticleList(channel_id: String, status_code: String, pagenumber: String, pagesize: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/article/getArticles"
        let params = ["json":"{\"channel_id\":\"\(channel_id)\",\"status_code\":\"\(status_code)\"}","page":"{\"pagenumber\":\"\(pagenumber)\",\"pagesize\":\"\(pagesize)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    /**
     根据ID获取文章详情
     - parameter article_id: 文章ID
     - parameter handler:    回调方法
     */
    func getArticleDetail(article_id: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/article/getArticles"
        let params = ["json":"{\"article_id\":\"\(article_id)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 更多
}