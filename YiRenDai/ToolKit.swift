//
//  CommonDef.swift
//  ProjectFrame
//
//  Created by Rain on 16/1/15.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit

// MARK: - 全局属性
let screen_width = UIScreen.mainScreen().bounds.size.width
let screen_height = UIScreen.mainScreen().bounds.size.height
let statusBar_height:CGFloat = 20
let navigationBar_height:CGFloat = 44
let top_height:CGFloat = 64
let tabBar_height:CGFloat = 49

//网络请求链接前缀
let URL = "http://115.28.67.86:8083/index.php?r=api"

//SMSSDK
let SMSSDK_AppKey = "1283183fef2d8"
let SMSSDK_Secret = "1a5a8f3bf629f5f834cca96f8b25ab8d"

// ShareSDK
let ShareSDK_AppKey = "1339d65a3e93b"

// MARK: - ToolKit
class ToolKit{
    // MARK: - 属性
    /// 获取用户手机号
    static var getUserPhone: String{
        get{
            return getValueByKey("userPhone") as! String
        }
    }
    
    // MARK: - 方法
    /**
     判断是否登录
     - returns: true：登录  false：退出
     */
    static func isLogin() ->Bool{
        let isLogin = NSUserDefaults.getUserDefaultValue("isLogin") == nil ? false : (NSUserDefaults.getUserDefaultValue("isLogin")?.boolValue)!
        return isLogin
    }
    
    /**
     获取登陆用户Id
     - returns: 返回用户Id
     */
    static func getUserId() -> String{
        if let userId = NSUserDefaults.getUserDefaultValue("userId"){
            return userId as! String
        }
        return ""
    }
    
    /**
     根据key获取value
     - parameter key: key
     - returns: 返回value
     */
    static func getValueByKey(key: String) -> AnyObject{
        let value = NSUserDefaults.getUserDefaultValue(key)
        if value == nil {
            return ""
        }else{
            return value!
        }
    }
    
    /**
     获取最顶层的view
     - returns: return view
     */
    static func getTopView() -> UIView{
        let view = UIApplication.sharedApplication().keyWindow?.subviews[0]
        return view!
    }
    
    /**
     对电话进行编辑 -- 中间四位替换为*
     - parameter phone: 手机号
     - returns: 返回修改后的手机号
     */
    static func phoneEdit(phone: String) -> String{
        let str = phone[phone.startIndex.advancedBy(3) ..< phone.startIndex.advancedBy(7)]
        return phone.stringByReplacingOccurrencesOfString(str, withString: "****")
    }
}