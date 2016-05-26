//
//  VerificationCodeViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/2.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class VerificationCodeViewController: BaseNavigationController, UITextFieldDelegate {
    
    var accountValue: String!
    var areaCode: String!
    
    var verificationTxt: UITextField!
    var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getGrayColorThird()
        
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        verificationTxt.resignFirstResponder()
    }
    
    //MARK: - 自定义方法
    func initView(){
        let detailLbl = UILabel(frame: CGRectMake(20, top_height + 20, screen_width - 20, 14))
        detailLbl.textColor = UIColor.lightGrayColor()
        detailLbl.font = UIFont.systemFontOfSize(14)
        detailLbl.text = "已向您的手机\(ToolKit.phoneEdit(accountValue))发送验证码"
        view.addSubview(detailLbl)
        
        //账号view
        let verificationCodeView = UIView(frame: CGRectMake(0, detailLbl.viewBottomY + 10, screen_width, 47 + 1))
        verificationCodeView.backgroundColor = UIColor.whiteColor()
        view.addSubview(verificationCodeView)
        //accountTxt
        verificationTxt = UITextField(frame: CGRectMake(20, 0, verificationCodeView.viewWidth - 40, 47))
        verificationTxt.delegate = self
        verificationTxt.placeholder = "请输入验证码"
        verificationTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        verificationCodeView.addSubview(verificationTxt)
        //verificationCodeBtn
        let verificationCodeBtn = Timer(frame: CGRectMake(0, 5, 130, verificationTxt.viewHeight - 10))
        verificationTxt.rightView = verificationCodeBtn
        verificationTxt.rightViewMode = .Always
        
        //nextBtn
        nextBtn = UIButton(frame: CGRectMake(14, verificationCodeView.viewBottomY + 40, screen_width - 28, 45))
        nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        nextBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        nextBtn.enabled = false
        nextBtn.setTitle("下一步", forState: .Normal)
        nextBtn.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
        view.addSubview(nextBtn)
    }
    
    func clickEvent(){
        SMSSDK.commitVerificationCode(verificationTxt.text, phoneNumber: accountValue, zone: areaCode) { (error) in
            if error == nil{
                let resetPwdVC = ResetPwdViewController()
                resetPwdVC.accountVale = self.accountValue
                resetPwdVC.navtitle = "重设密码"
                self.navigationController?.pushViewController(resetPwdVC, animated: true)
            }else{
                self.verificationTxt.text = ""
                self.view.viewAlert(self, title: "提示", msg: error.userInfo["commitVerificationCode"]!.debugDescription, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(textField: UITextField){
        if textField.text == "" {
            nextBtn.enabled = false
            nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
        }else{
            nextBtn.enabled = true
            nextBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
        }
    }

}
