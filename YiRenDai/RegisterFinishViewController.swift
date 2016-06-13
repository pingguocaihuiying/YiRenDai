//
//  RegisterFinishViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/3.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterFinishViewController: BaseNavigationController, UITextFieldDelegate, ReSendSMSDelegate {
    
    var accountValue: String!
    var areaCode: String!
    var userName: String!
    var IDNo: String!
    
    var pwdIv: UIImageView!
    var pwdTxt: UITextField!
    var verificationTxt: UITextField!
    var invitationCodeTxt: UITextField!
    var okBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getGrayColorThird()
        setTopViewLeftBtnImg("left")

        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pwdTxt.resignFirstResponder()
        verificationTxt.resignFirstResponder()
        invitationCodeTxt.resignFirstResponder()
    }
    
    //MARK: - 自定义方法
    func initView(){
        //headerView
        let headerView = UIView(frame: CGRectMake(0, top_height, screen_width, 50))
        headerView.backgroundColor = UIColor.getRedColorFirst()
        view.addSubview(headerView)
        //lineView1
        let lineView1 = UIView(frame: CGRectMake(30, 5, (screen_width - 60 - 5) / 2, 1))
        lineView1.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(lineView1)
        //leftView
        let leftView = UIView(frame: CGRectMake(lineView1.viewX + (lineView1.viewWidth - 16 - 5 - 50) / 2, lineView1.viewBottomY + 5, lineView1.viewWidth, 20))
        headerView.addSubview(leftView)
        //iv1
        let iv1 = UIImageView(frame: CGRectMake(0, 4 + (20 - 17) / 2, 17, 17))
        iv1.image = UIImage(named: "authentication")
        leftView.addSubview(iv1)
        //detail1
        let detail1 = UILabel(frame: CGRectMake(iv1.viewRightX + 5, 4, 50, 20))
        detail1.textColor = UIColor.whiteColor()
        detail1.font = UIFont.systemFontOfSize(12)
        detail1.textAlignment = .Left
        detail1.text = "身份验证"
        leftView.addSubview(detail1)
        //lineView2
        let lineView2 = UIView(frame: CGRectMake(lineView1.viewRightX + 5, 5, (screen_width - 60 - 5) / 2, 1))
        lineView2.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(lineView2)
        //rightView
        let rightView = UIView(frame: CGRectMake(lineView2.viewX + (lineView2.viewWidth - 16 - 5 - 50) / 2, lineView2.viewBottomY + 5, lineView2.viewWidth, 20))
        headerView.addSubview(rightView)
        //iv2
        let iv2 = UIImageView(frame: CGRectMake(0, 4 + (20 - 17) / 2, 17, 17))
        iv2.image = UIImage(named: "complete_account")
        rightView.addSubview(iv2)
        //detail2
        let detail2 = UILabel(frame: CGRectMake(iv2.viewRightX + 5, 4, 50, 20))
        detail2.textColor = UIColor.whiteColor()
        detail2.font = UIFont.systemFontOfSize(12)
        detail2.textAlignment = .Left
        detail2.text = "完成开户"
        rightView.addSubview(detail2)
        //detail3
        let detail3 = UILabel(frame: CGRectMake(0, headerView.viewBottomY, screen_width, 35))
        detail3.font = UIFont.systemFontOfSize(12)
        detail3.textColor = UIColor.lightGrayColor()
        detail3.textAlignment = .Center
        detail3.text = "进行验证，完成开户"
        view.addSubview(detail3)
        //lineView3
        let lineView3 = UIView(frame: CGRectMake(0, detail3.viewBottomY, screen_width, 0.5))
        lineView3.backgroundColor = UIColor.getGrayColorFirst()
        view.addSubview(lineView3)
        
        //contentView
        let contentView = UIView(frame: CGRectMake(0, lineView3.viewBottomY, screen_width, 47 * 4))
        contentView.backgroundColor = UIColor.whiteColor()
        view.addSubview(contentView)
        //accountIv
        let accountIv = UIImageView(frame: CGRectMake(14, (47 - 16) / 2, 16, 16))
        accountIv.contentMode = .ScaleAspectFit
        accountIv.image = UIImage(named: "lg_us_click")
        contentView.addSubview(accountIv)
        //accountTxt
        let accountTxt = UITextField(frame: CGRectMake(accountIv.viewRightX + 15, 0, contentView.viewWidth - 28, 47))
        accountTxt.font = UIFont.systemFontOfSize(15)
        accountTxt.text = accountValue
        contentView.addSubview(accountTxt)
        //lineView4
        let lineView4 = UIView(frame: CGRectMake(accountTxt.viewX, accountTxt.viewBottomY, contentView.viewWidth - 14 - 30, 0.5))
        lineView4.backgroundColor = UIColor.getGrayColorFirst()
        contentView.addSubview(lineView4)
        //IDNoIv
        pwdIv = UIImageView(frame: CGRectMake(14, 47 + (47 - 16) / 2, 16, 16))
        pwdIv.contentMode = .ScaleAspectFit
        pwdIv.image = UIImage(named: "lg_psd_normal")
        contentView.addSubview(pwdIv)
        //IDNoTxt
        pwdTxt = UITextField(frame: CGRectMake(pwdIv.viewRightX + 15, 47, contentView.viewWidth - 28, 47))
        pwdTxt.delegate = self
        pwdTxt.secureTextEntry = true
        pwdTxt.font = UIFont.systemFontOfSize(15)
        pwdTxt.placeholder = "请输入6-16位字符"
        pwdTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(pwdTxt)
        //lineView5
        let lineView5 = UIView(frame: CGRectMake(pwdTxt.viewX, pwdTxt.viewBottomY, contentView.viewWidth - 14 - 30, 0.5))
        lineView5.backgroundColor = UIColor.getGrayColorFirst()
        contentView.addSubview(lineView5)
        //verificationTxt
        verificationTxt = UITextField(frame: CGRectMake(lineView5.viewX, 47 * 2, contentView.viewWidth - lineView5.viewX - 14, 47))
        verificationTxt.delegate = self
        verificationTxt.font = UIFont.systemFontOfSize(15)
        verificationTxt.placeholder = "请输入验证码"
        verificationTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(verificationTxt)
        //verificationCodeBtn
        let verificationCodeBtn = Timer(frame: CGRectMake(0, 5, 120, verificationTxt.viewHeight - 10))
        verificationCodeBtn.delegate = self
        verificationTxt.rightView = verificationCodeBtn
        verificationTxt.rightViewMode = .Always
        //lineView6
        let lineView6 = UIView(frame: CGRectMake(verificationTxt.viewX, verificationTxt.viewBottomY, contentView.viewWidth - 14 - 30, 0.5))
        lineView6.backgroundColor = UIColor.getGrayColorFirst()
        contentView.addSubview(lineView6)
        //invitationCodeTxt
        invitationCodeTxt = UITextField(frame: CGRectMake(lineView5.viewX, 47 * 3, contentView.viewWidth - 28, 47))
        invitationCodeTxt.delegate = self
        invitationCodeTxt.font = UIFont.systemFontOfSize(15)
        invitationCodeTxt.placeholder = "9位邀请码（选填）"
        invitationCodeTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(invitationCodeTxt)
        //lineView7
        let lineView7 = UIView(frame: CGRectMake(0, invitationCodeTxt.viewBottomY, contentView.viewWidth, 0.5))
        lineView7.backgroundColor = UIColor.getGrayColorFirst()
        contentView.addSubview(lineView7)
        
        // checkIv
        let checkIv = UIImageView(frame: CGRectMake(20, contentView.viewBottomY + 15, 20, 20))
        checkIv.image = UIImage(named: "xuanze")
        view.addSubview(checkIv)
        // protocolBtn
        let protocolBtn = UIButton(frame: CGRectMake(checkIv.viewRightX + 5, contentView.viewBottomY + 15, 120, 20))
        protocolBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        let str = NSMutableAttributedString(string: "我已同意注册协议")
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(4, 4))
        str.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(4, 4))
        protocolBtn.setAttributedTitle(str, forState: .Normal)
        view.addSubview(protocolBtn)
        
        //okBtn
        okBtn = UIButton(frame: CGRectMake(14, contentView.viewBottomY + 50, screen_width - 28, 45))
        okBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        okBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        okBtn.enabled = false
        okBtn.setTitle("确定", forState: .Normal)
        okBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(okBtn)
    }
    
    func clickEvent(sender: UIButton){
        LoadingAnimation.show()
        SMSSDK.commitVerificationCode(verificationTxt.text, phoneNumber: accountValue, zone: areaCode) { (error) in
            LoadingAnimation.dismiss()
            if error == nil{
                //注册
                DataProvider.sharedInstance.register(self.accountValue, password: self.pwdTxt.text!, userName: self.userName, IDNo: self.IDNo, handler: { (data) in
                    if data["status"]["succeed"].intValue == 1{
                        NSUserDefaults.setUserDefaultValue(true, forKey: "isLogin")
                        NSUserDefaults.setUserDefaultValue(data["member_id"].stringValue, forKey: "userId")
                        NSUserDefaults.setUserDefaultValue(data["member_phone"].stringValue, forKey: "userPhone")
                        NSNotificationCenter.defaultCenter().postNotificationName("updateMoreData", object: nil)
                        let customTabBarVC = CustomTabBarViewController()
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = customTabBarVC
                        NSNotificationCenter.defaultCenter().postNotificationName("setDefaultSelectTabBarItem", object: nil, userInfo: ["index":2])
                    }else{
                        self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
                    }
                })
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
        if textField == pwdTxt {
            if textField.text == "" {
                pwdIv.image = UIImage(named: "lg_psd_normal")
            }else{
                pwdIv.image = UIImage(named: "lg_psd_click")
            }
        }
        if pwdTxt.text == "" || verificationTxt.text == "" {
            okBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            okBtn.enabled = false
        }else{
            okBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            okBtn.enabled = true
        }
    }
    
    //MARK: - ReSendSMSDelegate
    func reSendSMS() {
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: accountValue, zone: areaCode, customIdentifier: nil) { (error) in
            if error != nil{
                self.view.viewAlert(self, title: "提示", msg: error.userInfo["getVerificationCode"]!.debugDescription, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }

}
