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
    }
    
    func nextFunc(){
        
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
            let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 20) / 2, 20, 20))
            iv.image = UIImage(named: "lg_us_normal")
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
            let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 20) / 2, 20, 20))
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
            let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 20) / 2, 20, 20))
            iv.image = UIImage(named: "lg_us_normal")
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
            cardTxt.delegate = self
            cardTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
            cell.contentView.addSubview(cardTxt)
        }else if indexPath.row == 3{
            // iv
            let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 20) / 2, 20, 20))
            iv.image = UIImage(named: "lg_us_normal")
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
            phoneTxt.delegate = self
            phoneTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
            cell.contentView.addSubview(phoneTxt)
        }else if indexPath.row == 4{
            cell.backgroundColor = UIColor.getGrayColorThird()
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(15, 0, screen_width - 15, cell.viewHeight))
            titleLbl.textAlignment = .Left
            titleLbl.font = UIFont.systemFontOfSize(15)
            titleLbl.textColor = UIColor.darkGrayColor()
            titleLbl.text = "所填卡号与银行预留手机号需匹配"
            cell.contentView.addSubview(titleLbl)
        }else if indexPath.row == 5{
            cell.backgroundColor = UIColor.getGrayColorThird()
            // 下一步按钮
            nextBtn = UIButton(frame: CGRectMake(15, 5, screen_width - 30, cell.viewHeight - 10))
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
