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
    func register(account: String, password: String, userName: String, IDNo: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/member/register"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\",\"member_truename\":\"\(userName)\",\"member_card\":\"\(IDNo)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
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
    
    /**
     修改密码
     - parameter account:  账号
     - parameter password: 原密码
     - parameter newPwd:   新密码
     - parameter handler:  回调方法
     */
    func changePwd(account: String, password: String, newPwd: String, handler: (data: JSON) -> Void){
        let url = "\(URL)/member/updatePassword"
        let params = ["json":"{\"member_username\":\"\(account)\",\"member_password\":\"\(password)\",\"member_new_password\":\"\(newPwd)\"}"]
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 首页
    
    /**
     获取活动列表
     - parameter handler: 回调方法
     */
    func getActivities(handler: (data: JSON) -> Void){
        let url = "\(URL)/activity/GetActivities"
        obj.postRequest(url: url, params: nil) { (json) in
            handler(data: json)
        }
    }
    
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
    
    //MARK: - 我要借款
    /*
    loans_id-贷款id
    loan_kinds-贷款类型：1-工薪贷，2-助业贷，3-物业贷，4-车主贷
    amounts-借款金额
    loan_purpose-借款目的
    loan_term-借款期限
    city-居住城市
    live_time-居住时间
    name-姓名
    sex-性别
    year-出生年份
    tel-手机号
    contact_time-联系时间
    house-房产情况
    car_port-车况情况
    avg_salary-月均收入
    card-信用卡
    brand-车辆信息
    model_of_car-车辆型号
    record_data-登记日期
    gearbox-变速箱
    list_the_mileage-表里里程
    price-购买价格
    cc-排量
    member_id-用户id
     */
    func jiekuanSubmit(loan_kinds: String, amounts: String, loan_purpose: String, loan_term: String, city: String, live_time: String, name: String, sex: String, year: String, tel: String, contact_time: String, house: String, car_port: String, avg_salary: String, card: String, brand: String, model_of_car: String, record_data: String, gearbox: String, list_the_mileage: String, price: String, cc: String, member_id: String, handler:(data: JSON) -> Void){
        let url = "\(URL)/owner/submit"
        let params = ["json":"{\"loan_kinds\":\"\(loan_kinds)\",\"amounts\":\"\(amounts)\",\"loan_purpose\":\"\(loan_purpose)\",\"loan_term\":\"\(loan_term)\",\"city\":\"\(city)\",\"live_time\":\"\(live_time)\",\"name\":\"\(name)\",\"sex\":\"\(sex)\",\"year\":\"\(year)\",\"tel\":\"\(tel)\",\"contact_time\":\"\(contact_time)\",\"house\":\"\(house)\",\"car_port\":\"\(car_port)\",\"avg_salary\":\"\(avg_salary)\",\"card\":\"\(card)\",\"brand\":\"\(brand)\",\"model_of_car\":\"\(model_of_car)\",\"record_data\":\"\(record_data)\",\"gearbox\":\"\(gearbox)\",\"list_the_mileage\":\"\(list_the_mileage)\",\"price\":\"\(price)\",\"cc\":\"\(cc)\",\"member_id\":\"\(member_id)\"}"];
        obj.postRequest(url: url, params: params) { (json) in
            handler(data: json)
        }
    }
    
    //MARK: - 更多
}