//
//  ResetPwdViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/3.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ChangePwdViewController: BaseNavigationController, UITextFieldDelegate {
    
    var accountVale: String!
    
    var pwdIv: UIImageView!
    var oldPwdTxt: UITextField!
    var pwdTxt: UITextField!
    var rePwdTxt: UITextField!
    var finishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getGrayColorThird()
        
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        oldPwdTxt.resignFirstResponder()
        pwdTxt.resignFirstResponder()
        rePwdTxt.resignFirstResponder()
    }
    
    //MARK: - 自定义方法
    func initView(){
        let detailLbl = UILabel(frame: CGRectMake(20, top_height + 20, 100, 12))
        detailLbl.textColor = UIColor.lightGrayColor()
        detailLbl.font = UIFont.systemFontOfSize(12)
        detailLbl.text = "重新设置密码"
        view.addSubview(detailLbl)
        
        //密码view
        let pwdView = UIView(frame: CGRectMake(0, detailLbl.viewBottomY + 10, screen_width, 47 * 3 + 2))
        pwdView.backgroundColor = UIColor.whiteColor()
        view.addSubview(pwdView)
        //lineView1
        let lineView1 = UIView(frame: CGRectMake(0, 0, screen_width, 0.5))
        lineView1.backgroundColor = UIColor.lightGrayColor()
        pwdView.addSubview(lineView1)
        //pwdIv
        pwdIv = UIImageView(frame: CGRectMake(20, (47 - 18) / 2, 18, 18))
        pwdIv.contentMode = .ScaleAspectFit
        pwdIv.image = UIImage(named: "lg_psd_normal")
        pwdView.addSubview(pwdIv)
        //oldPwdTxt
        oldPwdTxt = UITextField(frame: CGRectMake(pwdIv.viewRightX + 15, 0, pwdView.viewWidth - 28, 47))
        oldPwdTxt.delegate = self
        oldPwdTxt.secureTextEntry = true
        oldPwdTxt.placeholder = "请输入原密码"
        oldPwdTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        pwdView.addSubview(oldPwdTxt)
        //lineView2
        let lineView2 = UIView(frame: CGRectMake(oldPwdTxt.viewX, oldPwdTxt.viewBottomY, screen_width, 0.5))
        lineView2.backgroundColor = UIColor.lightGrayColor()
        pwdView.addSubview(lineView2)
        //pwdTxt
        pwdTxt = UITextField(frame: CGRectMake(oldPwdTxt.viewX, lineView2.viewBottomY, oldPwdTxt.viewWidth - 28, 47))
        pwdTxt.delegate = self
        pwdTxt.secureTextEntry = true
        pwdTxt.placeholder = "新密码（6-16位字符）"
        pwdTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        pwdView.addSubview(pwdTxt)
        //lineView3
        let lineView3 = UIView(frame: CGRectMake(pwdTxt.viewX, pwdTxt.viewBottomY, lineView2.viewWidth, 0.5))
        lineView3.backgroundColor = UIColor.lightGrayColor()
        pwdView.addSubview(lineView3)
        //rePwdTxt
        rePwdTxt = UITextField(frame: CGRectMake(pwdIv.viewRightX + 15, lineView3.viewBottomY, pwdView.viewWidth - 28, 47))
        rePwdTxt.delegate = self
        rePwdTxt.secureTextEntry = true
        rePwdTxt.placeholder = "请再次输入密码"
        rePwdTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        pwdView.addSubview(rePwdTxt)
        //lineView4
        let lineView4 = UIView(frame: CGRectMake(0, rePwdTxt.viewBottomY, screen_width, 0.5))
        lineView4.backgroundColor = UIColor.lightGrayColor()
        pwdView.addSubview(lineView4)
        
        //nextBtn
        finishBtn = UIButton(frame: CGRectMake(14, pwdView.viewBottomY + 40, screen_width - 28, 45))
        finishBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        finishBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        finishBtn.setTitle("完成", forState: .Normal)
        finishBtn.enabled = false
        finishBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(finishBtn)
    }
    
    func clickEvent(sender: UIButton){
        self.view.endEditing(true)
        if oldPwdTxt.text == "" || pwdTxt.text == "" || rePwdTxt.text == "" {
            view.viewAlert(self, title: "提示", msg: "密码不能为空", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }
        if pwdTxt.text != rePwdTxt.text {
            view.viewAlert(self, title: "提示", msg: "两次输入的密码不一致", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }
        DataProvider.sharedInstance.changePwd(accountVale, password: oldPwdTxt.text!, newPwd: pwdTxt.text!) { (data) in
            if data["status"]["succeed"].intValue == 1{
                let customTabBarVC = CustomTabBarViewController()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = customTabBarVC
                NSNotificationCenter.defaultCenter().postNotificationName("setDefaultSelectTabBarItem", object: nil, userInfo: ["index":2])
                LoadingAnimation.showSuccess(CustomTabBarViewController(), msg: "修改成功~")
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(textField: UITextField){
        if oldPwdTxt.text == "" {
            pwdIv.image = UIImage(named: "lg_psd_normal")
        }else{
            pwdIv.image = UIImage(named: "lg_psd_click")
            
            if oldPwdTxt.text?.characters.count > 0 && pwdTxt.text?.characters.count >= 6 && rePwdTxt.text?.characters.count >= 6 {
                finishBtn.enabled = true
                finishBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            }else{
                finishBtn.enabled = false
                finishBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            }
        }
    }
    
}
