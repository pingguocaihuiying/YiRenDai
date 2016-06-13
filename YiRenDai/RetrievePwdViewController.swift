//
//  RetrievePwdViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/2.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class RetrievePwdViewController: BaseNavigationController, UITextFieldDelegate {
    
    var accountIv: UIImageView!
    var accountTxt: UITextField!
    var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getGrayColorThird()
        
        setTopViewLeftBtnImg("left")

        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        accountTxt.resignFirstResponder()
    }
    
    //MARK: - 自定义方法
    func initView(){
        let detailLbl = UILabel(frame: CGRectMake(20, top_height + 20, 100, 12))
        detailLbl.textColor = UIColor.lightGrayColor()
        detailLbl.font = UIFont.systemFontOfSize(12)
        detailLbl.text = "请填写账号"
        view.addSubview(detailLbl)
        
        //账号view
        let accountView = UIView(frame: CGRectMake(0, detailLbl.viewBottomY + 10, screen_width, 47 + 1))
        accountView.backgroundColor = UIColor.whiteColor()
        view.addSubview(accountView)
        //lineView1
        let lineView1 = UIView(frame: CGRectMake(0, 0, screen_width, 0.5))
        lineView1.backgroundColor = UIColor.lightGrayColor()
        accountView.addSubview(lineView1)
        //accountIv
        accountIv = UIImageView(frame: CGRectMake(20, (47 - 18) / 2, 18, 18))
        accountIv.contentMode = .ScaleAspectFit
        accountIv.image = UIImage(named: "lg_us_normal")
        accountView.addSubview(accountIv)
        //accountTxt
        accountTxt = UITextField(frame: CGRectMake(accountIv.viewRightX + 15, 0, accountView.viewWidth - 28, 47))
        accountTxt.delegate = self
        accountTxt.placeholder = "手机号码"
        accountTxt.keyboardType = .PhonePad
        accountTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        accountView.addSubview(accountTxt)
        //lineView2
        let lineView2 = UIView(frame: CGRectMake(0, accountTxt.viewBottomY, screen_width, 0.5))
        lineView2.backgroundColor = UIColor.lightGrayColor()
        accountView.addSubview(lineView2)
        
        //nextBtn
        nextBtn = UIButton(frame: CGRectMake(14, accountView.viewBottomY + 40, screen_width - 28, 45))
        nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        nextBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        nextBtn.enabled = false
        nextBtn.setTitle("下一步", forState: .Normal)
        nextBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(nextBtn)
    }
    
    func clickEvent(sender: UIButton){
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: accountTxt.text, zone: "86", customIdentifier: nil) { (error) in
            if error == nil{
                let verificationCodeVC = VerificationCodeViewController()
                verificationCodeVC.accountValue = self.accountTxt.text
                verificationCodeVC.areaCode = "86"
                verificationCodeVC.navtitle = "填写验证码"
                self.navigationController?.pushViewController(verificationCodeVC, animated: true)
            }else{
                self.view.viewAlert(self, title: "提示", msg: error.userInfo["getVerificationCode"]!.debugDescription, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
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
            accountIv.image = UIImage(named: "lg_us_normal")
            nextBtn.enabled = false
            nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
        }else{
            accountIv.image = UIImage(named: "lg_us_click")
            nextBtn.enabled = true
            nextBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
        }
    }

}
