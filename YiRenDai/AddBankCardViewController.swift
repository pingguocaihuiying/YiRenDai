//
//  AddBankCardViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/13.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class AddBankCardViewController: BaseNavigationController, UITextFieldDelegate, OpenBankViewControllerDellegate, OpenBankAddressViewControllerDellegate {
    
    let cellIdentifier = "CellIdentifier"
    
    // view
    var tableView: UITableView!
    var nameTxt: UITextField!
    var cardTxt: UITextField!
    var openBankTxt: UITextField!
    var openBankAddressTxt: UITextField!
    var zhihangTxt: UITextField!
    var OKBtn: UIButton!
    
    // data
    var openBankValue: String!
    var openBankAddressValue: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("添加提现银行卡")
        setTopViewLeftBtnImg("left")

        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTxt.resignFirstResponder()
        cardTxt.resignFirstResponder()
        openBankTxt.resignFirstResponder()
        openBankAddressTxt.resignFirstResponder()
        zhihangTxt.resignFirstResponder()
    }
    
    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    
    func OKFunc(){
        let vericationCard = ToolKitObjC.returnBankName(cardTxt.text)
        if vericationCard == "" {
            self.view.viewAlert(self, title: "提示", msg: "输入的银行卡格式不正确", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            return
        }
        
        DataProvider.sharedInstance.addTixianBankCard(nameTxt.text!, card_number: cardTxt.text!, bank_name: openBankValue, bank_area: openBankAddressValue, bank_branch: zhihangTxt.text!, member_id: ToolKit.getStringByKey("userId"), status_id: "2") { (data) in
            print(data)
            if data["status"]["succeed"].intValue == 1{
                self.view.viewAlert(self, title: "提示", msg: "保存成功", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: { (buttonIndex, action) in
                    NSNotificationCenter.defaultCenter().postNotificationName("refreshData", object: nil)
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }else{
                self.view.viewAlert(self, title: "提示", msg: "保存失败", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func textFieldDidChange(textField: UITextField){
        if nameTxt.text != "" && cardTxt.text != "" && openBankTxt.text != "" && openBankAddressTxt.text != "" && zhihangTxt.text != ""{
            OKBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
            OKBtn.enabled = true
        }else{
            OKBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            OKBtn.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - OpenBankViewControllerDellegate
    func selectValue(value: String) {
        openBankValue = value
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 2)], withRowAnimation: .Automatic)
    }
    
    // MARK: - OpenBankAddressViewControllerDellegate
    func selectAddressValue(value: String) {
        openBankAddressValue = value
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
    }

}

extension AddBankCardViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return 2
        }else if section == 2{
            return 3
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return 50
        }else{
            return 200
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.section == 0 {
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
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
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
                nameTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
                cell.contentView.addSubview(nameTxt)
            }else{
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
                cardTxt.keyboardType = .NumberPad
                cardTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
                cell.contentView.addSubview(cardTxt)
            }
        }else if indexPath.section == 2{
            if indexPath.row == 0 {
                cell.accessoryType = .DisclosureIndicator
                // detailLbl
                let detailLbl = UILabel(frame: CGRectMake(17, 0, 105, cell.viewHeight))
                detailLbl.textAlignment = .Left
                detailLbl.textColor = UIColor.darkGrayColor()
                detailLbl.text = "开户银行"
                cell.contentView.addSubview(detailLbl)
                // openBankTxt
                openBankTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
                openBankTxt.placeholder = "请选择银行"
                openBankTxt.text = openBankValue
                openBankTxt.userInteractionEnabled = false
                cell.contentView.addSubview(openBankTxt)
            }else if indexPath.row == 1{
                cell.accessoryType = .DisclosureIndicator
                // detailLbl
                let detailLbl = UILabel(frame: CGRectMake(17, 0, 105, cell.viewHeight))
                detailLbl.textAlignment = .Left
                detailLbl.textColor = UIColor.darkGrayColor()
                detailLbl.text = "开户银行地区"
                cell.contentView.addSubview(detailLbl)
                // openBankAddressTxt
                openBankAddressTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
                openBankAddressTxt.placeholder = "请选择地区"
                openBankAddressTxt.text = openBankAddressValue
                openBankAddressTxt.userInteractionEnabled = false
                cell.contentView.addSubview(openBankAddressTxt)
            }else if indexPath.row == 2{
                // detailLbl
                let detailLbl = UILabel(frame: CGRectMake(17, 0, 105, cell.viewHeight))
                detailLbl.textAlignment = .Left
                detailLbl.textColor = UIColor.darkGrayColor()
                detailLbl.text = "支行"
                cell.contentView.addSubview(detailLbl)
                // zhihangTxt
                zhihangTxt = UITextField(frame: CGRectMake(detailLbl.viewRightX + 5, (cell.viewHeight - 17) / 2, 200, 17))
                zhihangTxt.placeholder = "填写支行名称"
                zhihangTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
                cell.contentView.addSubview(zhihangTxt)
            }
        }else{
            // OKBtn
            OKBtn = UIButton(frame: CGRectMake(17, 10, screen_width - 17 * 2, 40))
            OKBtn.setTitle("确定", forState: .Normal)
            OKBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            OKBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            OKBtn.addTarget(self, action: #selector(OKFunc), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(OKBtn)
            // promptLbl
            let promptLbl = UILabel(frame: CGRectMake(15, OKBtn.viewBottomY + 20, 100, 21))
            promptLbl.font = UIFont.systemFontOfSize(16)
            promptLbl.text = "温馨提示"
            promptLbl.textColor = UIColor.grayColor()
            cell.contentView.addSubview(promptLbl)
            // dotsView
            let dotsView = DotsView(frame: CGRectMake(20, promptLbl.viewBottomY + 5 + 7, 6, 6))
            cell.contentView.addSubview(dotsView)
            
            // detailLbl1
            let detailLbl1 = UILabel(frame: CGRectMake(dotsView.viewRightX + 5, promptLbl.viewBottomY + 5, screen_width - dotsView.viewRightX - 5 - 17, 40))
            detailLbl1.numberOfLines = 0
            detailLbl1.font = UIFont.systemFontOfSize(16)
            detailLbl1.textColor = UIColor.grayColor()
            detailLbl1.text = "提现免手续费，如果您填写的银行卡信息不正确将无法成功提现。"
            cell.contentView.addSubview(detailLbl1)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 {
            if cell.respondsToSelector(Selector("setLayoutMargins:")) {
                cell.layoutMargins = UIEdgeInsets(top: 0, left: screen_width, bottom: 0, right: 0)
            }
            
            if cell.respondsToSelector(Selector("setSeparatorInset:")){
                cell.separatorInset = UIEdgeInsets(top: 0, left: screen_width, bottom: 0, right: 0)
            }
            
            if cell .respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")){
                cell.preservesSuperviewLayoutMargins = false
            }
        }else{
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            self.view.endEditing(true)
            if indexPath.row == 0 {
                let openBankVC = OpenBankViewController()
                openBankVC.delegate = self
                navigationController?.pushViewController(openBankVC, animated: true)
            }else if indexPath.row == 1{
                let  openBankAddressVC = OpenBankAddressViewController()
                openBankAddressVC.delegate = self
                navigationController?.pushViewController(openBankAddressVC, animated: true)
            }
        }
    }
    
    // section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 8
        }else{
            return 10
        }
    }
}
