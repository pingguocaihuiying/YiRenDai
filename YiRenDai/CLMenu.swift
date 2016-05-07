//
//  CLMenu.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

protocol CLMenuDelegate {
    func clickMenuEvent(sender: UIButton)
}

class CLMenu: UIView {
    
    private var menuArray = [String]()
    private var delegate: CLMenuDelegate?
    
    init(frame: CGRect, menuArray: [String]){
        super.init(frame: frame)
        self.menuArray = menuArray
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        //menuView
        let menuView = UIView(frame: CGRectMake(0, 0, self.viewWidth, self.viewHeight))
        self.addSubview(menuView)
        //每个item宽度
        let itemWidth = self.viewWidth / CGFloat(menuArray.count)
        //填充数据
        for i in 0 ..< menuArray.count{
            //itemBtn
            let itemBtn = UIButton(frame: CGRectMake(CGFloat(i) * itemWidth, 0, itemWidth, menuView.viewHeight))
            itemBtn.tag = i
            itemBtn.addTarget(self, action: #selector(clickMenuEvent(_:)), forControlEvents: .TouchUpInside)
            if i == 0 {
                itemBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }else{
                itemBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
            }
            itemBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
            itemBtn.setTitle(menuArray[i], forState: .Normal)
            menuView.addSubview(itemBtn)
            //底部线
            let lineView = UIView(frame: CGRectMake(CGFloat(i) * itemWidth, menuView.viewHeight, itemWidth, 0.5))
            if i == 0 {
                lineView.backgroundColor = UIColor.getColorFourth()
            }else{
                lineView.backgroundColor = UIColor.getColorFive()
            }
            menuView.addSubview(lineView)
        }
    }
    
    func clickMenuEvent(sender: UIButton){
        let menuView = (sender.superview?.subviews)!
        //清空所有样式
        for itemView in menuView{
            if itemView.isKindOfClass(UIButton) {
                (itemView as! UIButton).setTitleColor(UIColor.grayColor(), forState: .Normal)
            }else if itemView.isKindOfClass(UIView){
                itemView.backgroundColor = UIColor.getColorFive()
            }
        }
        //设置选中样式
        let itemBtn = menuView[sender.tag * 2] as! UIButton
        let lineView = menuView[sender.tag * 2 + 1]
        itemBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        lineView.backgroundColor = UIColor.getColorFourth()
        
        //CLMenuDelegate
        if delegate != nil {
            self.delegate?.clickMenuEvent(sender)
        }
    }
}
