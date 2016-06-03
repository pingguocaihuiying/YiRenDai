//
//  LoginViewController.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/22.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: BaseNavigationController, UITextFieldDelegate {
    
    var isShowBackBtn = Bool()
    
    //view
    var accountIv: UIImageView!
    var accountTxt: UITextField!
    var passwordIv: UIImageView!
    var passwordTxt: UITextField!
    var loginBtn: UIButton!
    var targetNav: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("登录")
        if isShowBackBtn {
            setTopViewLeftBtnImg("left")
        }
        setTopViewRightBtn("找回密码")
        view.backgroundColor = UIColor.getGrayColorThird()
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        accountTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        if accountTxt.text == "" {
            accountIv.image = UIImage(named: "lg_us_normal")
        }
        if passwordTxt.text == "" {
            passwordIv.image = UIImage(named: "lg_psd_normal")
        }
    }
    
    override func clickLeftBtnEvent() {
        if isShowBackBtn{
            super.clickLeftBtnEvent()
        }
    }
    
    override func clickRightBtnEvent() {
        let retrievePwdVC = RetrievePwdViewController()
        retrievePwdVC.navtitle = "找回密码"
        retrievePwdVC.hidesBottomBarWhenPushed = true
        targetNav.pushViewController(retrievePwdVC, animated: true)
    }
    
    //MARK: - 自定义方法
    func initView(){
        //账号和密码view
        let accountPwdView = UIView(frame: CGRectMake(0, top_height, screen_width, 94 + 0.5))
        accountPwdView.backgroundColor = UIColor.whiteColor()
        view.addSubview(accountPwdView)
        //accountIv
        accountIv = UIImageView(frame: CGRectMake(14, (47 - 18) / 2, 18, 18))
        accountIv.contentMode = .ScaleAspectFit
        accountIv.image = UIImage(named: "lg_us_normal")
        accountPwdView.addSubview(accountIv)
        //accountTxt
        accountTxt = UITextField(frame: CGRectMake(accountIv.viewRightX + 15, 0, accountPwdView.viewWidth - 28, 47))
        accountTxt.delegate = self
        accountTxt.placeholder = "邮箱/手机号码"
        accountTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        accountPwdView.addSubview(accountTxt)
        //lineView1
        let lineView1 = UIView(frame: CGRectMake(accountTxt.viewX, accountTxt.viewBottomY, accountPwdView.viewWidth - 14 - 30, 0.5))
        lineView1.backgroundColor = UIColor.lightGrayColor()
        accountPwdView.addSubview(lineView1)
        //passwordIv
        passwordIv = UIImageView(frame: CGRectMake(accountIv.viewX, lineView1.viewBottomY + (47 - 18) / 2, 18, 18))
        passwordIv.contentMode = .ScaleAspectFit
        passwordIv.image = UIImage(named: "lg_psd_normal")
        accountPwdView.addSubview(passwordIv)
        //passwordTxt
        passwordTxt = UITextField(frame: CGRectMake(accountTxt.viewX, lineView1.viewBottomY, accountPwdView.viewWidth - 28, 47))
        passwordTxt.delegate = self
        passwordTxt.secureTextEntry = true
        passwordTxt.placeholder = "输入密码"
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        accountPwdView.addSubview(passwordTxt)
        //lineVie2
        let lineVie2 = UIView(frame: CGRectMake(0, passwordTxt.viewBottomY, screen_width, 0.5))
        lineVie2.backgroundColor = UIColor.lightGrayColor()
        accountPwdView.addSubview(lineVie2)
        
        //登陆按钮
        loginBtn = UIButton(frame: CGRectMake(14, accountPwdView.viewBottomY + 15, screen_width - 28, 45))
        loginBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        loginBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        loginBtn.enabled = false
        loginBtn.setTitle("登陆", forState: .Normal)
        loginBtn.addTarget(self, action: #selector(loginEvent), forControlEvents: .TouchUpInside)
        view.addSubview(loginBtn)

        //免费注册领红包
        let registerBtn = UIButton(frame: CGRectMake(14, loginBtn.viewBottomY + 20, screen_width - 28, 45))
        registerBtn.setTitle("免费注册领红包", forState: .Normal)
        registerBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        registerBtn.setTitleColor(UIColor.getRedColorFirst(), forState: .Normal)
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor.getRedColorFirst().CGColor
        registerBtn.addTarget(self, action: #selector(registerEvent), forControlEvents: .TouchUpInside)
        view.addSubview(registerBtn)
        
        //转换身份
        //detailLbl
        let detailLbl = UILabel(frame: CGRectMake(0, screen_height - tabBar_height - 50, screen_width, 14))
        detailLbl.textColor = UIColor.lightGrayColor()
        detailLbl.textAlignment = .Center
        detailLbl.font = UIFont.systemFontOfSize(14)
        detailLbl.text = "宜人贷借款用户转换成宜人贷理财用户"
        view.addSubview(detailLbl)
        //changeSfBtn
        let changeSfBtn = UIButton(frame: CGRectMake((screen_width - 60) / 2, detailLbl.viewBottomY + 10, 70, 14))
        changeSfBtn.setTitleColor(UIColor(red:0.15, green:0.52, blue:0.70, alpha:1.00), forState: .Normal)
        changeSfBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        changeSfBtn.setTitle("去转换身份", forState: .Normal)
        view.addSubview(changeSfBtn)
    }
    
    func loginEvent(){
        DataProvider.sharedInstance.login(accountTxt.text!, password: passwordTxt.text!) { (state, message, data) in
            if state == 1{
                NSUserDefaults.setUserDefaultValue(true, forKey: "isLogin")
                NSUserDefaults.setUserDefaultValue(data["member_id"].stringValue, forKey: "userId")
                NSNotificationCenter.defaultCenter().postNotificationName("updateMoreData", object: nil)
                let customTabBarVC = CustomTabBarViewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window!.rootViewController = customTabBarVC
                NSNotificationCenter.defaultCenter().postNotificationName("setDefaultSelectTabBarItem", object: nil, userInfo: ["index":2])
            }else{
                self.passwordTxt.text = ""
                self.view.viewAlert(self, title: "提示", msg: message, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func registerEvent(){
        let registerVC = RegisterViewController()
        registerVC.navtitle = "注册"
        registerVC.hidesBottomBarWhenPushed = true
        targetNav.pushViewController(registerVC, animated: true)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == accountTxt {
            accountIv.image = UIImage(named: "lg_us_click")
            if passwordTxt.text == "" {
                passwordIv.image = UIImage(named: "lg_psd_normal")
            }
        }else if(textField == passwordTxt){
            passwordIv.image = UIImage(named: "lg_psd_click")
            if accountTxt.text == "" {
                accountIv.image = UIImage(named: "lg_us_normal")
            }
        }
    }
    
    func textFieldDidChange(textField: UITextField){
        if textField.text == "" {
            if textField == accountTxt {
                accountIv.image = UIImage(named: "lg_us_normal")
            }else if(textField == passwordTxt){
                passwordIv.image = UIImage(named: "lg_psd_normal")
            }
        }else{
            if textField == accountTxt {
                accountIv.image = UIImage(named: "lg_us_click")
            }else if(textField == passwordTxt){
                passwordIv.image = UIImage(named: "lg_psd_click")
            }
        }
        if accountTxt.text != "" && passwordTxt.text != "" {
            loginBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            loginBtn.enabled = true
        }else{
            loginBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            loginBtn.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
