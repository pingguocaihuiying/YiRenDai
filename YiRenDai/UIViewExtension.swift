//
//  UIViewExtension.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/17.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit

extension UIView {
    //MARK: - 属性
    /**
     * x坐标
     */
    var viewX: CGFloat{
        get{
            return self.frame.origin.x
        }
    }
    
    /**
     * y坐标
     */
    var viewY: CGFloat{
        get{
            return self.frame.origin.y
        }
    }
    
    /**
     * view的宽度
     */
    var viewWidth: CGFloat{
        get{
            return self.frame.size.width
        }
    }
    
    /**
     * view的高度
     */
    var viewHeight: CGFloat{
        get{
            return self.frame.size.height
        }
    }
    
    /**
     * view右边的x坐标
     */
    var viewRightX: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    /**
     * view下边的y坐标
     */
    var viewBottomY: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    //MARK: - 方法
    /**
     * alert弹框
     */
    func viewAlert(target: AnyObject, title: String?, msg: String?, cancelButtonTitle: String?, otherButtonTitle: String?, handler: ((buttonIndex: Int,action: UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        if cancelButtonTitle != nil{
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                if handler != nil{
                    handler!(buttonIndex: 0,action: action)
                }
            })
            alertController.addAction(cancelAction)
        }
        if otherButtonTitle != nil{
            let otherAction = UIAlertAction(title: otherButtonTitle, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                if handler != nil{
                    handler!(buttonIndex: 1,action: action)
                }
            })
            alertController.addAction(otherAction)
        }
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //ActionSheet
    func viewActionSheet(target: AnyObject, title: String?, msg: String?, cancelButtonTitle: String?, otherButtonTitles: [String], handler: ((buttonIndex: Int,action: UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.ActionSheet)
        if cancelButtonTitle != nil{
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                if handler != nil{
                    handler!(buttonIndex: 0,action: action)
                }
            })
            alertController.addAction(cancelAction)
        }
        for i in 0 ..< otherButtonTitles.count {
            let otherAction = UIAlertAction(title: otherButtonTitles[i], style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                if handler != nil{
                    handler!(buttonIndex: i + 1,action: action)
                }
            })
            alertController.addAction(otherAction)
        }
        target.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**
    * 拨打电话
    */
    func callPhone(target: AnyObject, title: String, tels: String...){
        var telStrs = [String]()
        for i in 0 ..< tels.count {
            let telStr:NSMutableString = NSMutableString(string: tels[i])
            if telStr.length == 10 {
                telStr.insertString("-", atIndex: 3)
                telStr.insertString("-", atIndex: 7)
            }else if telStr.length == 11 {
                telStr.insertString("-", atIndex: 3)
                telStr.insertString("-", atIndex: 8)
            }
            telStrs.append(telStr as String)
        }
        viewActionSheet(target, title: title, msg: nil, cancelButtonTitle: "取消", otherButtonTitles: telStrs) { (buttonIndex, action) in
            if buttonIndex != 0{
                let telUrl = NSURL(string: "tel://\(telStrs[buttonIndex - 1])")
                UIApplication.sharedApplication().openURL(telUrl!)
            }
        }
    }
    
}