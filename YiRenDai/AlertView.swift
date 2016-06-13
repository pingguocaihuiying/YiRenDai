//
//  AlertView.swift
//  YiRenDai
//
//  Created by Rain on 16/5/13.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

protocol AlertViewDelegate {
    func clickOK(password: String)
}

class AlertView: UIView, UITextFieldDelegate {
    
    var bgView: UIButton!
    var showView: UIView!
    var pwdTxt: UITextField!
    var okBtn: UIButton!
    
    var delegate: AlertViewDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        //bgView
        bgView = UIButton(frame: CGRectMake(0, 0, screen_width, screen_height))
        bgView.backgroundColor = UIColor.grayColor()
        bgView.alpha = 0.5
        bgView.tag = 0
        bgView.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        ToolKit.getTopView.addSubview(bgView)
        //showView
        showView = UIView(frame: frame)
        showView.backgroundColor = UIColor.whiteColor()
        showView.layer.masksToBounds = true
        showView.layer.cornerRadius = 8
        ToolKit.getTopView.addSubview(showView)
        //titleLbl
        let titleLbl = UILabel(frame: CGRectMake(0, 20, frame.size.width, 17))
        titleLbl.textAlignment = .Center
        titleLbl.text = "请输入登陆密码"
        showView.addSubview(titleLbl)
        //lineView
        let lineView = UIView(frame: CGRectMake(10, titleLbl.viewBottomY + 15, frame.size.width - 20, 0.5))
        lineView.backgroundColor = UIColor.lightGrayColor()
        showView.addSubview(lineView)
        //txtBorderLineView
        let txtBorderLineView = UIView(frame: CGRectMake(15, lineView.viewBottomY + 20, frame.size.width - 30, 40))
        txtBorderLineView.backgroundColor = UIColor.whiteColor()
        txtBorderLineView.layer.masksToBounds = true
        txtBorderLineView.layer.borderWidth = 0.5
        txtBorderLineView.layer.borderColor = UIColor.lightGrayColor().CGColor
        txtBorderLineView.layer.cornerRadius = 8
        showView.addSubview(txtBorderLineView)
        //pwdTitleLbl
        let pwdTitleLbl = UILabel(frame: CGRectMake(0, 0, 70, txtBorderLineView.viewHeight))
        pwdTitleLbl.textAlignment = .Center
        pwdTitleLbl.font = UIFont.systemFontOfSize(14)
        pwdTitleLbl.text = "登陆密码："
        //pwdTxt
        pwdTxt = UITextField(frame: CGRectMake(10, 0, txtBorderLineView.viewWidth - 20, txtBorderLineView.viewHeight))
        pwdTxt.delegate = self
        pwdTxt.becomeFirstResponder()
        pwdTxt.font = UIFont.systemFontOfSize(14)
        pwdTxt.placeholder = "宜人贷理财登录密码"
        pwdTxt.leftView = pwdTitleLbl
        pwdTxt.leftViewMode = .Always
        pwdTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        txtBorderLineView.addSubview(pwdTxt)
        //okBtn
        okBtn = UIButton(frame: CGRectMake(14, txtBorderLineView.viewBottomY + 25, frame.size.width - 28, 40))
        okBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        okBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        okBtn.enabled = false
        okBtn.setTitle("确定", forState: .Normal)
        okBtn.tag = 1
        okBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        showView.addSubview(okBtn)
    }
    
    func hiddenView(){
        bgView.removeFromSuperview()
        showView.removeFromSuperview()
    }
    
    //MARK: - clickEvent -- 点击事件
    func clickEvent(sender: UIButton){
        switch sender.tag {
        case 0:
            hiddenView()
            break
        case 1:
            hiddenView()
            if delegate != nil {
                delegate?.clickOK(pwdTxt.text!)
            }
        default:
            break
        }
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(textField: UITextField){
        if textField.text == "" {
            okBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            okBtn.enabled = false
        }else{
            okBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            okBtn.enabled = true
        }
    }
}
