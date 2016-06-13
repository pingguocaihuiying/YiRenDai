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
    /// 获取最顶层的view
    static var getTopView: UIView{
        get{
            let view = UIApplication.sharedApplication().keyWindow?.subviews[0]
            return view!
        }
    }
    
    // MARK: - 方法
    /**
     根据key获取String值
     - parameter key: key
     - parameter defaultValue: 默认值
     - returns: 返回String值
     */
    static func getStringByKey(key: String, defaultValue: String = "") -> String{
        let value = NSUserDefaults.getUserDefaultValue(key)
        if value == nil {
            return defaultValue
        }else{
            return value as! String
        }
    }
    
    /**
     根据key获取Bool值
     - parameter key: key
     - parameter defaultValue: 默认值
     - returns: 返回Bool值
     */
    static func getBoolByKey(key: String, defaultValue: Bool = false) -> Bool{
        let value = NSUserDefaults.getUserDefaultValue(key)
        if value == nil {
            return defaultValue
        }else{
            return value as! Bool
        }
    }
    
    /**
     根据key获取AnyObject值
     - parameter key: key
     - parameter defaultValue: 默认值
     - returns: 返回AnyObject值
     */
    static func getAnyObjectByKey(key: String, defaultValue: AnyObject = "") -> AnyObject{
        let value = NSUserDefaults.getUserDefaultValue(key)
        if value == nil {
            return defaultValue
        }else{
            return value!
        }
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