//
//  NSUserDefaultsExtension.swift
//  YiRenDai
//
//  Created by Rain on 16/4/23.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    
    /**
     设置NSUserDefaultValue值
     - parameter value: value值
     - parameter key:   key值
     */
    class func setUserDefaultValue(value: AnyObject?, forKey key: String){
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setValue(value, forKey: key)
    }
    
    /**
     获取NSUserDefaultValue值
     - parameter key: key值
     - returns: value值
     */
    class func getUserDefaultValue(key: String) -> AnyObject?{
        let userDefault = NSUserDefaults.standardUserDefaults()
        return userDefault.valueForKey(key)
    }
}
