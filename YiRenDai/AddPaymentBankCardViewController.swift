//
//  AddPaymentBankCardViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/14.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class AddPaymentBankCardViewController: BaseNavigationController, UITextFieldDelegate {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    var nameTxt: UITextField!
    var cardTxt: UITextField!
    var phoneTxt: UITextField!
    var nextBtn: UIButton!
    var bgView: UIButton!
    var showView: UIButton!
    var verificationTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("添加支付银行卡")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTxt.resignFirstResponder()
        cardTxt.resignFirstResponder()
        phoneTxt.resignFirstResponder()
    }
    
    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height -  top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.getGrayColorThird()
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        bgView = UIButton(frame: CGRectMake(0, 0, screen_width, screen_height))
        bgView.backgroundColor = UIColor.lightGrayColor()
        bgView.alpha = 0.4
        bgView.addTarget(self, action: #selector(clickBgEvent), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func clickBgEvent(){
        if bgView != nil {
            bgView.removeFromSuperview()
        }
        if showView != nil {
            showView.removeFromSuperview()
        }
    }
    
    func nextFunc(){
        if nameTxt.text == nil || cardTxt.text == nil || phoneTxt.text == nil{
            self.view.viewAlert(self, title: "提示", msg: "请先完善数据", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }
        let vericationCard = ToolKitObjC.returnBankName(cardTxt.text)
        if vericationCard == "" {
            self.view.viewAlert(self, title: "提示", msg: "输入的银行卡格式不正确", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }

        LoadingAnimation.show()
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: phoneTxt.text, zone: "86", customIdentifier: nil) { (error) in
            LoadingAnimation.dismiss()
            if error == nil{
                self.alertVericationView(CGRectMake((screen_width - 250) / 2, screen_height / 2 - 150, 250, 200))
            }else{
                self.view.viewAlert(self, title: "提示", msg: error.userInfo["getVerificationCode"]!.debugDescription, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func textFieldDidChange(textField: UITextField){
        if nameTxt.text != "" && cardTxt.text != "" && phoneTxt.text != ""{
            nextBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            nextBtn.enabled = true
        }else{
            nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            nextBtn.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func alertVericationView(frame: CGRect){
        
        self.view.endEditing(true)
        
        self.view.addSubview(bgView)
        // showView
        showView = UIButton(frame: CGRectMake((screen_width - frame.size.width) / 2, (screen_height - frame.size.height) / 2, frame.size.width, frame.size.height))
        showView.addTarget(self, action: #selector(clickShowView), forControlEvents: UIControlEvents.TouchUpInside)
        showView.backgroundColor = UIColor.whiteColor()
        showView.layer.masksToBounds = true
        showView.layer.cornerRadius = 5;
        UIView.animateWithDuration(2) { 
            self.view.addSubview(self.showView)
        }
        // titleLbl
        let titleLbl = UILabel(frame: CGRectMake(0, 10, showView.viewWidth, 30))
        titleLbl.textAlignment = .Center
        titleLbl.font = UIFont.systemFontOfSize(15)
        titleLbl.textColor = UIColor.darkGrayColor()
        titleLbl.text = "验证手机号"
        showView.addSubview(titleLbl)
        // lineView
        let lineView = UIView(frame: CGRectMake(12, titleLbl.viewBottomY + 5, showView.viewWidth - 24, 0.5))
        lineView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        showView.addSubview(lineView)
        // detailLbl
        let detailLbl = UILabel(frame: CGRectMake(12, lineView.viewBottomY + 10, screen_width - 24, 21))
        detailLbl.font = UIFont.systemFontOfSize(13)
        detailLbl.textColor = UIColor.darkGrayColor()
        detailLbl.text = "已向您的手机\(phoneTxt.text!)发送验证码"
        showView.addSubview(detailLbl)
        //verificationTxt
        verificationTxt = UITextField(frame: CGRectMake(12, detailLbl.viewBottomY + 15, showView.viewWidth - 24, 35))
        verificationTxt.delegate = self
        verificationTxt.keyboardType = .NumberPad
        verificationTxt.placeholder = "请输入验证码"
        verificationTxt.layer.masksToBounds = true
        verificationTxt.layer.cornerRadius = 6
        verificationTxt.layer.borderWidth = 1
        verificationTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
        showView.addSubview(verificationTxt)
        //okBtn
        let okBtn = UIButton(frame: CGRectMake(12, verificationTxt.viewBottomY + 15, showView.viewWidth - 24, 35))
        okBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
        okBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        okBtn.setTitle("确定", forState: .Normal)
        okBtn.addTarget(self, action: #selector(clickOkEvent), forControlEvents: .TouchUpInside)
        showView.addSubview(okBtn)
    }
    
    func clickOkEvent(){
        DataProvider.sharedInstance.addBankCard(nameTxt.text!, card_number: cardTxt.text!, tbl: phoneTxt.text!, member_id: ToolKit.getStringByKey("userId"), status_id: "1") { (data) in
            if data["status"].dictionaryValue["succeed"]?.intValue == 1{
                self.view.viewAlert(self, title: "提示", msg: "保存成功", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: { (buttonIndex, action) in
                    NSNotificationCenter.defaultCenter().postNotificationName("refreshData", object: nil)
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }else{
                self.view.viewAlert(self, title: "提示", msg: "保存失败", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func clickShowView(){
        if verificationTxt != nil {
            verificationTxt.resignFirstResponder()
        }
    }

}

extension AddPaymentBankCardViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.row == 0 {
            // iv
            let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 22) / 2, 22, 22))
            iv.image = UIImage(named: "add_bank_card")
            cell.contentView.addSubview(iv)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, screen_width - iv.viewRightX - 5, cell.viewHeight))
            detailLbl.font = UIFont.systemFontOfSize(15)
            detailLbl.textAlignment = .Left
            detailLbl.textColor = UIColor.darkGrayColor()
            detailLbl.text = "为保障您的账号安全，请进行实名认证"
            cell.contentView.addSubview(detailLbl)
        }else if indexPath.row == 1{
            // iv
            let iv = UIImageView(frame: CGRectMake(17, (cell.viewHeight - 19) / 2, 19, 19))
            iv.image = UIImage(named: "lg_us_normal")
            cell.contentView.addSubview(iv)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 70, cell.viewHeight))
            detailLbl.textAlignment = .Left
            detailLbl.textColor = UIColor.darkGrayColor()
            detailLbl.text = "真实姓名"
            cell.contentView.addSubview(detailLbl)
            // nameTxt
            nameTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
            nameTxt.placeholder = "您的真实姓名"
            nameTxt.delegate = self
            nameTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
            cell.contentView.addSubview(nameTxt)
        }else if indexPath.row == 2{
            // iv
            let iv = UIImageView(frame: CGRectMake(17, (cell.viewHeight - 19) / 2, 19, 19))
            iv.image = UIImage(named: "add_bank_cardnum")
            cell.contentView.addSubview(iv)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 70, cell.viewHeight))
            detailLbl.textAlignment = .Left
            detailLbl.textColor = UIColor.darkGrayColor()
            detailLbl.text = "卡号"
            cell.contentView.addSubview(detailLbl)
            // cardTxt
            cardTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
            cardTxt.placeholder = "银行卡号"
            cardTxt.keyboardType = UIKeyboardType.NumberPad
            cardTxt.delegate = self
            cardTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
            cell.contentView.addSubview(cardTxt)
        }else if indexPath.row == 3{
            // iv
            let iv = UIImageView(frame: CGRectMake(17, (cell.viewHeight - 19) / 2, 19, 19))
            iv.image = UIImage(named: "add_bank_phone")
            cell.contentView.addSubview(iv)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 70, cell.viewHeight))
            detailLbl.textAlignment = .Left
            detailLbl.textColor = UIColor.darkGrayColor()
            detailLbl.text = "手机号"
            cell.contentView.addSubview(detailLbl)
            // phoneTxt
            phoneTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
            phoneTxt.placeholder = "填写手机号"
            phoneTxt.keyboardType = UIKeyboardType.NumberPad
            phoneTxt.delegate = self
            phoneTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
            cell.contentView.addSubview(phoneTxt)
        }else if indexPath.row == 4{
            cell.backgroundColor = UIColor.getGrayColorThird()
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(17, 0, screen_width - 15, cell.viewHeight))
            titleLbl.textAlignment = .Left
            titleLbl.font = UIFont.systemFontOfSize(15)
            titleLbl.textColor = UIColor.darkGrayColor()
            titleLbl.text = "所填卡号与银行预留手机号需匹配"
            cell.contentView.addSubview(titleLbl)
        }else if indexPath.row == 5{
            cell.backgroundColor = UIColor.getGrayColorThird()
            // 下一步按钮
            nextBtn = UIButton(frame: CGRectMake(17, 5, screen_width - 30, cell.viewHeight - 10))
            nextBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
            nextBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
            nextBtn.enabled = false
            nextBtn.setTitle("下一步", forState: .Normal)
            nextBtn.addTarget(self, action: #selector(nextFunc), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(nextBtn)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector(Selector("setSeparatorInset:")){
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        if cell .respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")){
            cell.preservesSuperviewLayoutMargins = false
        }
    }
}
