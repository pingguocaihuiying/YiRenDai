//
//  RegisterViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/3.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class RegisterViewController: BaseNavigationController, UITextFieldDelegate {
    
    var nameIv: UIImageView!
    var nameTxt: UITextField!
    var IDNoIv: UIImageView!
    var IDNoTxt: UITextField!
    var phoneNoIv: UIImageView!
    var phoneNoTxt: UITextField!
    var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getColorThird()
        setTopViewLeftBtnImg("left")

        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTxt.resignFirstResponder()
        IDNoTxt.resignFirstResponder()
        phoneNoTxt.resignFirstResponder()
    }
    
    //MARK: - 自定义方法
    func initView(){
        //headerView
        let headerView = UIView(frame: CGRectMake(0, top_height, screen_width, 50))
        headerView.backgroundColor = UIColor.getColorFourth()
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
        lineView2.backgroundColor = UIColor.lightTextColor()
        headerView.addSubview(lineView2)
        //rightView
        let rightView = UIView(frame: CGRectMake(lineView2.viewX + (lineView2.viewWidth - 16 - 5 - 50) / 2, lineView2.viewBottomY + 5, lineView2.viewWidth, 20))
        headerView.addSubview(rightView)
        //iv2
        let iv2 = UIImageView(frame: CGRectMake(0, 4 + (20 - 17) / 2, 17, 17))
        iv2.image = UIImage(named: "account_normal")
        rightView.addSubview(iv2)
        //detail2
        let detail2 = UILabel(frame: CGRectMake(iv2.viewRightX + 5, 4, 50, 20))
        detail2.textColor = UIColor.lightTextColor()
        detail2.font = UIFont.systemFontOfSize(12)
        detail2.textAlignment = .Left
        detail2.text = "完成开户"
        rightView.addSubview(detail2)
        
        //detail3
        let detail3 = UILabel(frame: CGRectMake(0, headerView.viewBottomY, screen_width, 35))
        detail3.font = UIFont.systemFontOfSize(12)
        detail3.textColor = UIColor.lightGrayColor()
        detail3.textAlignment = .Center
        detail3.text = "为保障账户资金安全，请使用真实身份注册"
        view.addSubview(detail3)
        //lineView3
        let lineView3 = UIView(frame: CGRectMake(0, detail3.viewBottomY, screen_width, 0.5))
        lineView3.backgroundColor = UIColor.getColorSecond()
        view.addSubview(lineView3)
        
        //contentView
        let contentView = UIView(frame: CGRectMake(0, lineView3.viewBottomY, screen_width, 47 * 3))
        contentView.backgroundColor = UIColor.whiteColor()
        view.addSubview(contentView)
        //nameIv
        nameIv = UIImageView(frame: CGRectMake(14, (47 - 16) / 2, 16, 16))
        nameIv.contentMode = .ScaleAspectFit
        nameIv.image = UIImage(named: "lg_us_normal")
        contentView.addSubview(nameIv)
        //nameTxt
        nameTxt = UITextField(frame: CGRectMake(nameIv.viewRightX + 15, 0, contentView.viewWidth - 28, 47))
        nameTxt.delegate = self
        nameTxt.font = UIFont.systemFontOfSize(15)
        nameTxt.placeholder = "真实姓名"
        nameTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(nameTxt)
        //lineView4
        let lineView4 = UIView(frame: CGRectMake(nameTxt.viewX, nameTxt.viewBottomY, contentView.viewWidth - 14 - 30, 0.5))
        lineView4.backgroundColor = UIColor.getColorSecond()
        contentView.addSubview(lineView4)
        //IDNoIv
        IDNoIv = UIImageView(frame: CGRectMake(14, 47 + (47 - 16) / 2, 16, 16))
        IDNoIv.contentMode = .ScaleAspectFit
        IDNoIv.image = UIImage(named: "account_normal")
        contentView.addSubview(IDNoIv)
        //IDNoTxt
        IDNoTxt = UITextField(frame: CGRectMake(IDNoIv.viewRightX + 15, 47, contentView.viewWidth - 28, 47))
        IDNoTxt.delegate = self
        IDNoTxt.font = UIFont.systemFontOfSize(15)
        IDNoTxt.placeholder = "身份证号"
        IDNoTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(IDNoTxt)
        //lineView5
        let lineView5 = UIView(frame: CGRectMake(IDNoTxt.viewX, IDNoTxt.viewBottomY, contentView.viewWidth - 14 - 30, 0.5))
        lineView5.backgroundColor = UIColor.getColorSecond()
        contentView.addSubview(lineView5)
        //phoneNoIv
        phoneNoIv = UIImageView(frame: CGRectMake(14, 47 * 2 + (47 - 16) / 2, 16, 16))
        phoneNoIv.contentMode = .ScaleAspectFit
        phoneNoIv.image = UIImage(named: "mobile_normal")
        contentView.addSubview(phoneNoIv)
        //phoneNoTxt
        phoneNoTxt = UITextField(frame: CGRectMake(phoneNoIv.viewRightX + 15, 47 * 2, contentView.viewWidth - 28, 47))
        phoneNoTxt.delegate = self
        phoneNoTxt.font = UIFont.systemFontOfSize(15)
        phoneNoTxt.placeholder = "手机号"
        phoneNoTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        contentView.addSubview(phoneNoTxt)
        //lineView6
        let lineView6 = UIView(frame: CGRectMake(0, phoneNoTxt.viewBottomY, contentView.viewWidth, 0.5))
        lineView6.backgroundColor = UIColor.getColorSecond()
        contentView.addSubview(lineView6)
        
        //nextBtn
        nextBtn = UIButton(frame: CGRectMake(14, contentView.viewBottomY + 40, screen_width - 28, 45))
        nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        nextBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        nextBtn.enabled = false
        nextBtn.setTitle("下一步", forState: .Normal)
        nextBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(nextBtn)
    }
    
    func clickEvent(sender: UIButton){
        if !ToolKitObjC.hyb_isValidPersonID(IDNoTxt.text) {
            view.viewAlert(self, title: "提示", msg: "输入的身份号格式不正确", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }
        
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: phoneNoTxt.text, zone: "86", customIdentifier: nil) { (error) in
            if error == nil{
                let registerFinishVC = RegisterFinishViewController()
                registerFinishVC.navtitle = "注册"
                registerFinishVC.accountValue = self.phoneNoTxt.text
                registerFinishVC.areaCode = "86"
                registerFinishVC.userName = self.nameTxt.text
                registerFinishVC.IDNo = self.IDNoTxt.text
                self.navigationController?.pushViewController(registerFinishVC, animated: true)
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
        if textField == nameTxt {
            if textField.text == "" {
                nameIv.image = UIImage(named: "lg_us_normal")
            }else{
                nameIv.image = UIImage(named: "lg_us_click")
            }
        }else if textField == IDNoTxt{
            if textField.text == "" {
                IDNoIv.image = UIImage(named: "account_normal")
            }else{
                IDNoIv.image = UIImage(named: "account_click")
            }
        }else if textField == phoneNoTxt{
            if textField.text == "" {
                phoneNoIv.image = UIImage(named: "mobile_normal")
            }else{
                phoneNoIv.image = UIImage(named: "mobile_click")
            }
        }
        if nameTxt != "" && IDNoTxt.text != "" && phoneNoTxt.text != "" {
            nextBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            nextBtn.enabled = true
        }else{
            nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            nextBtn.enabled = false
        }
    }

}
