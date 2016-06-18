//
//  CLPickerView.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

protocol CLPickerViewDelegate {
    func selectRow(value: String)
}

class CLPickerView: UIView {
    
    // view
    var bgView: UIView!
    var pickerView: UIPickerView!
    var delegate: CLPickerViewDelegate?
    
    // data
    var selectRowIndex: Int!
    
    var showData = [String](){
        didSet{
            if self.showData.count > 0 {
                selectRowIndex = 0
            }
            pickerView.reloadAllComponents()
        }
    }
    
    var target: AnyObject!
    
    init(target: AnyObject) {
        super.init(frame: CGRectMake(0, screen_height - 220, screen_width, 220))
        
        self.target = target
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        // bgView
        bgView = UIView(frame: self.frame)
        target.view.addSubview(bgView)
        // topView
        let topView = UIView(frame: CGRectMake(0, 0, screen_width, 40))
        topView.backgroundColor = UIColor.whiteColor()
        bgView.addSubview(topView)
        // leftBtn
        let leftBtn = UIButton(frame: CGRectMake(10, 0, 40, topView.viewHeight))
        leftBtn.setTitle("取消", forState: .Normal)
        leftBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        leftBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        leftBtn.tag = 1
        leftBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        topView.addSubview(leftBtn)
        // rightBtn
        let rightBtn = UIButton(frame: CGRectMake(topView.viewWidth - 10 - 40, 0, 40, topView.viewHeight))
        rightBtn.setTitle("确定", forState: .Normal)
        rightBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        rightBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        rightBtn.tag = 2
        rightBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        topView.addSubview(rightBtn)
        // pickerView
        pickerView = UIPickerView(frame: CGRectMake(0, topView.viewBottomY, screen_width, bgView.viewHeight - topView.viewHeight))
        pickerView.backgroundColor = UIColor.lightGrayColor()
        pickerView.delegate = self
        pickerView.dataSource = self
        bgView.addSubview(pickerView)
    }
    
    func show(){
        target.view!.addSubview(bgView)
    }
    
    func dismiss(){
        bgView.removeFromSuperview()
    }
    
    func clickEvent(sender: UIButton){
        switch sender.tag {
        case 1:
            dismiss()
        case 2:
            if delegate != nil {
                delegate?.selectRow(showData[selectRowIndex])
            }
            dismiss()
        default:
            break
        }
    }
}

extension CLPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return showData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return showData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRowIndex = row
    }
}
