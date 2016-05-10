//
//  BaseNavigationController.swift
//  ProjectFrame
//
//  Created by Rain on 16/1/15.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseNavigationController: UIViewController {
    //全局变量
    var navtitle:String!
    
    private var topView:UIView!
    private var titleLbl:UILabel!
    private var leftBtn:UIButton!
    private var rightBtn:UIButton!

    //MARK:内部方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //topView
        topView = UIView(frame: CGRectMake(0, 0, screen_width, top_height))
        topView.backgroundColor = UIColor(red:0.99, green:0.33, blue:0.17, alpha:1.00)
        view.addSubview(topView)
        //lblTitle
        titleLbl = UILabel(frame: CGRectMake(0, statusBar_height, screen_width, navigationBar_height))
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.textColor = UIColor.whiteColor()
        if let navtitle = navtitle{
            titleLbl.text = navtitle
        }
        view.addSubview(titleLbl)
        //btnLeft
        leftBtn = UIButton(frame: CGRectMake(14, statusBar_height, 50, navigationBar_height))
        leftBtn.titleLabel?.textColor = UIColor.whiteColor()
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        leftBtn.addTarget(self, action: #selector(self.clickLeftBtnEvent), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(leftBtn)
        //rightBtn
        rightBtn = UIButton(frame: CGRectMake(screen_width - 75 - 14, statusBar_height, 75, navigationBar_height))
        rightBtn.titleLabel?.textColor = UIColor.whiteColor()
        rightBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        rightBtn.addTarget(self, action: #selector(self.clickRightBtnEvent), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(rightBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:自定义方法
    
    //设置topView背景颜色
    func setTopViewBgColor(color:UIColor){
        topView.backgroundColor = color;
    }
    
    //设置lblTitle文本
    func setTopViewTitle(title:String){
        titleLbl.text = title
    }
    
    //设置lblTitle文本颜色
    func setTopViewTitleColor(titleColor:UIColor){
        titleLbl.textColor = titleColor
    }
    
    //设置btnLeft文本
    func setTopViewLeftBtn(leftTitle:String){
        leftBtn.setTitle(leftTitle, forState: UIControlState.Normal)
    }
    
    //设置btnLeft图片
    func setTopViewLeftBtnImg(leftImg:String){
        leftBtn.setImage(UIImage(named: leftImg), forState: UIControlState.Normal)
    }
    
    //设置btnLeft文本颜色
    func setTopViewLeftBtnColor(leftTitleColor:UIColor){
        leftBtn.setTitleColor(leftTitleColor, forState: UIControlState.Normal)
    }
    
    //设置rightBtn文本
    func setTopViewRightBtn(rightTitle:String){
        rightBtn.setTitle(rightTitle, forState: UIControlState.Normal)
    }
    
    //设置btnRight图片
    func setTopViewRightBtnImg(rightImg:String){
        rightBtn .setImage(UIImage(named: rightImg), forState: UIControlState.Normal)
    }
    
    //设置rightBtn文本颜色
    func setTopViewRightBtnColor(rightTitleColor:UIColor){
        rightBtn.setTitleColor(rightTitleColor, forState: UIControlState.Normal)
    }
    
    //点击左按钮触发事件
    func clickLeftBtnEvent(){
        if navigationController == nil {
            dismissViewControllerAnimated(false, completion: nil)
        }else{
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //点击右按钮触发事件
    func clickRightBtnEvent(){
        
    }
}
