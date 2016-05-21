//
//  NSDateExtension.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/27.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit

extension NSDate{
    
    /**
    * 获取当前时期
    * @param dateFormatter:日期格式 默认:"yyyy-MM-dd"
    */
    class func getCurrentDate(dateFormatter:String?) -> String{
        let mDateFormatter = NSDateFormatter()
        if dateFormatter == nil {
            mDateFormatter.dateFormat = "yyyy-MM-dd"
        }else{
            mDateFormatter.dateFormat = dateFormatter
        }
        return mDateFormatter.stringFromDate(NSDate())
    }
    
    /**
     * NSDate转化为String类型
     * @param date:指定日期
     * @param dateFormatter:日期格式 默认:"yyyy-MM-dd"
     */
    class func getStringFromDate(date: NSDate, dateFormatter: String?) -> String{
        let mDateFormatter = NSDateFormatter()
        if dateFormatter == nil {
            mDateFormatter.dateFormat = "yyyy-MM-dd"
        }else{
            mDateFormatter.dateFormat = dateFormatter
        }
        return mDateFormatter.stringFromDate(date)
    }
}