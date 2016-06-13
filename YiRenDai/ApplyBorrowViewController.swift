//
//  ApplyBorrowViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/31.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

enum ApplyType {
    case Gongxindai
    case Zhuyedai
    case Wuyedai
    case Chezhudai
}

class ApplyBorrowViewController: BaseNavigationController {

    let cellIdentifier = "CellIdentifier"
    
    var applyType: ApplyType!
    
    //view
    var tableView: UITableView!
    var amountTxt: UITextField!
    var purposeTxt: UITextField!
    var deadlineTxt: UITextField!
    var cityTxt: UITextField!
    var timeTxt: UITextField!
    var nameTxt: UITextField!
    var birthdayTxt: UITextField!
    var phoneTxt: UITextField!
    var contactTimeTxt: UITextField!
    var incomeTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("借款说明")
        
        initView()
    }
    
    override func clickRightBtnEvent() {
        let introductionsVC = IntroductionsViewController()
        navigationController?.pushViewController(introductionsVC, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if amountTxt != nil{
            amountTxt.resignFirstResponder()
        }
        if purposeTxt != nil{
            purposeTxt.resignFirstResponder()
        }
        if deadlineTxt != nil{
            deadlineTxt.resignFirstResponder()
        }
        if cityTxt != nil{
            cityTxt.resignFirstResponder()
        }
        if timeTxt != nil{
            timeTxt.resignFirstResponder()
        }
        if nameTxt != nil{
            nameTxt.resignFirstResponder()
        }
        if birthdayTxt != nil{
            birthdayTxt.resignFirstResponder()
        }
        if phoneTxt != nil{
            phoneTxt.resignFirstResponder()
        }
        if contactTimeTxt != nil{
            contactTimeTxt.resignFirstResponder()
        }
        if incomeTxt != nil{
            incomeTxt.resignFirstResponder()
        }
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        // footerView
        let footerView = UIView(frame: CGRectMake(0, screen_height - 100, screen_width, 100))
        //footerView.backgroundColor = UIColor.lightTextColor()
        tableView.tableFooterView = footerView
        // protocolBtn
        let protocolBtn = UIButton(frame: CGRectMake((footerView.viewWidth - 120) / 2 + 20, 5, 120, 20))
        protocolBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        let str = NSMutableAttributedString(string: "我已同意注册协议")
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(4, 4))
        str.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(4, 4))
        protocolBtn.setAttributedTitle(str, forState: .Normal)
        footerView.addSubview(protocolBtn)
        // protocolIv
        let protocolIv = UIImageView(frame: CGRectMake(protocolBtn.viewX - 5 - 20, 5, 20, 20))
        protocolIv.image = UIImage(named: "xuanze")
        footerView.addSubview(protocolIv)
        // okBtn
        let okBtn = UIButton(frame: CGRectMake(20, protocolBtn.viewBottomY + 15, footerView.viewWidth - 40, 35))
        okBtn.setTitle("完成", forState: .Normal)
        okBtn.backgroundColor = UIColor.getRedColorFirst()
        okBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        footerView.addSubview(okBtn)
    }

}

extension ApplyBorrowViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        }else{
            if indexPath.section == 0 {
                return 155
            }else if indexPath.section == 1{
                return 295
            }else{
                return 165
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // iv
                let iv = UIImageView(frame: CGRectMake(20, (cell.viewHeight - 20) / 2, 20, 20))
                iv.image = UIImage(named: "jiekuanxinxi")
                cell.contentView.addSubview(iv)
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 200, cell.viewHeight))
                titleLbl.text = "借款信息"
                titleLbl.textAlignment = .Left
                cell.contentView.addSubview(titleLbl)
            }else{
                // typeTitleLbl
                let typeTitleLbl = UILabel(frame: CGRectMake(20, 10, screen_width, 15))
                typeTitleLbl.font = UIFont.systemFontOfSize(15)
                typeTitleLbl.text = "借款类型：\(self.navtitle)"
                typeTitleLbl.textColor = UIColor.grayColor()
                cell.contentView.addSubview(typeTitleLbl)
                
                // amountTitleLbl
                let amountTitleLbl = UILabel(frame: CGRectMake(20, typeTitleLbl.viewBottomY + 10, 65, 30))
                amountTitleLbl.textAlignment = .Left
                amountTitleLbl.font = UIFont.systemFontOfSize(15)
                amountTitleLbl.textColor = UIColor.grayColor()
                amountTitleLbl.text = "借款金额"
                cell.contentView.addSubview(amountTitleLbl)
                // amountTxt
                amountTxt = UITextField(frame: CGRectMake(amountTitleLbl.viewRightX, typeTitleLbl.viewBottomY + 10, screen_width * 0.6, 30))
                amountTxt.placeholder = "最高5000"
                amountTxt.textAlignment = .Center
                amountTxt.layer.borderWidth = 1
                amountTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(amountTxt)
                // yuanLbl
                let yuanLbl = UILabel(frame: CGRectMake(amountTxt.viewRightX + 2, amountTxt.viewY, 30, 30))
                yuanLbl.text = "元"
                yuanLbl.textColor = UIColor.grayColor()
                yuanLbl.font = UIFont.systemFontOfSize(15)
                cell.contentView.addSubview(yuanLbl)
                
                // purposeTitleLbl
                let purposeTitleLbl = UILabel(frame: CGRectMake(20, amountTxt.viewBottomY + 10, 65, 30))
                purposeTitleLbl.textAlignment = .Left
                purposeTitleLbl.font = UIFont.systemFontOfSize(15)
                purposeTitleLbl.textColor = UIColor.grayColor()
                purposeTitleLbl.text = "借款目的"
                cell.contentView.addSubview(purposeTitleLbl)
                // purposeTxt
                purposeTxt = UITextField(frame: CGRectMake(amountTitleLbl.viewRightX, amountTxt.viewBottomY + 10, screen_width * 0.6, 30))
                purposeTxt.placeholder = "请选择"
                purposeTxt.textAlignment = .Center
                purposeTxt.layer.borderWidth = 1
                purposeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(purposeTxt)
                // dropdownIv1
                let dropdownIv1 = UIImageView(frame: CGRectMake(purposeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv1.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv1)
                // add dropdownIv1
                purposeTxt.addSubview(dropdownIv1)
                
                // deadlineTitleLbl
                let deadlineTitleLbl = UILabel(frame: CGRectMake(20, purposeTxt.viewBottomY + 10, 65, 30))
                deadlineTitleLbl.textAlignment = .Left
                deadlineTitleLbl.font = UIFont.systemFontOfSize(15)
                deadlineTitleLbl.textColor = UIColor.grayColor()
                deadlineTitleLbl.text = "借款期限"
                cell.contentView.addSubview(deadlineTitleLbl)
                // deadlineTxt
                deadlineTxt = UITextField(frame: CGRectMake(deadlineTitleLbl.viewRightX, purposeTxt.viewBottomY + 10, screen_width * 0.6, 30))
                deadlineTxt.placeholder = "请选择"
                deadlineTxt.textAlignment = .Center
                deadlineTxt.layer.borderWidth = 1
                deadlineTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(deadlineTxt)
                // dropdownIv2
                let dropdownIv2 = UIImageView(frame: CGRectMake(purposeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv2.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv2)
                // add dropdownIv2
                deadlineTxt.addSubview(dropdownIv2)
            }
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                // iv
                let iv = UIImageView(frame: CGRectMake(20, (cell.viewHeight - 20) / 2, 20, 20))
                iv.image = UIImage(named: "jibenxinxi")
                cell.contentView.addSubview(iv)
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 200, cell.viewHeight))
                titleLbl.text = "基本信息"
                titleLbl.textAlignment = .Left
                cell.contentView.addSubview(titleLbl)
            }else{
                // cityTitleLbl
                let cityTitleLbl = UILabel(frame: CGRectMake(20, 10, 65, 30))
                cityTitleLbl.textAlignment = .Left
                cityTitleLbl.font = UIFont.systemFontOfSize(15)
                cityTitleLbl.textColor = UIColor.grayColor()
                cityTitleLbl.text = "居住城市"
                cell.contentView.addSubview(cityTitleLbl)
                // cityTxt
                cityTxt = UITextField(frame: CGRectMake(cityTitleLbl.viewRightX, cityTitleLbl.viewY, screen_width * 0.6, 30))
                cityTxt.placeholder = "请选择居住城市"
                cityTxt.textAlignment = .Center
                cityTxt.layer.borderWidth = 1
                cityTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(cityTxt)
                
                // timeTitleLbl
                let timeTitleLbl = UILabel(frame: CGRectMake(20, cityTxt.viewBottomY + 10, 65, 30))
                timeTitleLbl.textAlignment = .Left
                timeTitleLbl.font = UIFont.systemFontOfSize(15)
                timeTitleLbl.textColor = UIColor.grayColor()
                timeTitleLbl.text = "居住时长"
                cell.contentView.addSubview(timeTitleLbl)
                // timeTxt
                timeTxt = UITextField(frame: CGRectMake(timeTitleLbl.viewRightX, timeTitleLbl.viewY, screen_width * 0.6, 30))
                timeTxt.placeholder = "请选择"
                timeTxt.textAlignment = .Center
                timeTxt.layer.borderWidth = 1
                timeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(timeTxt)
                // dropdownIv1
                let dropdownIv1 = UIImageView(frame: CGRectMake(timeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv1.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv1)
                // add dropdownIv2
                timeTxt.addSubview(dropdownIv1)
                
                // nameTitleLbl
                let nameTitleLbl = UILabel(frame: CGRectMake(20, timeTxt.viewBottomY + 10, 65, 30))
                nameTitleLbl.textAlignment = .Left
                nameTitleLbl.font = UIFont.systemFontOfSize(15)
                nameTitleLbl.textColor = UIColor.grayColor()
                nameTitleLbl.text = "您的姓名"
                cell.contentView.addSubview(nameTitleLbl)
                // nameTxt
                nameTxt = UITextField(frame: CGRectMake(nameTitleLbl.viewRightX, nameTitleLbl.viewY, screen_width * 0.6, 30))
                nameTxt.placeholder = "请填写您的姓名"
                nameTxt.textAlignment = .Center
                nameTxt.layer.borderWidth = 1
                nameTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(nameTxt)
                
                // sexTitleLbl
                let sexTitleLbl = UILabel(frame: CGRectMake(20, nameTxt.viewBottomY + 10, 65, 30))
                sexTitleLbl.textAlignment = .Left
                sexTitleLbl.font = UIFont.systemFontOfSize(15)
                sexTitleLbl.textColor = UIColor.grayColor()
                sexTitleLbl.text = "您的性别"
                cell.contentView.addSubview(sexTitleLbl)
                // manIv
                let manIv = UIImageView(frame: CGRectMake(sexTitleLbl.viewRightX + 30, sexTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                manIv.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(manIv)
                // manTitleLbl
                let manTitleLbl = UILabel(frame: CGRectMake(manIv.viewRightX + 5, sexTitleLbl.viewY, 20, 30))
                manTitleLbl.textAlignment = .Left
                manTitleLbl.font = UIFont.systemFontOfSize(15)
                manTitleLbl.textColor = UIColor.grayColor()
                manTitleLbl.text = "男"
                cell.contentView.addSubview(manTitleLbl)
                // womanIv
                let womanIv = UIImageView(frame: CGRectMake(manTitleLbl.viewRightX + 30, sexTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                womanIv.image = UIImage(named: "xuanze")
                cell.contentView.addSubview(womanIv)
                // womanTitleLbl
                let womanTitleLbl = UILabel(frame: CGRectMake(womanIv.viewRightX + 5, sexTitleLbl.viewY, 20, 30))
                womanTitleLbl.textAlignment = .Left
                womanTitleLbl.font = UIFont.systemFontOfSize(15)
                womanTitleLbl.textColor = UIColor.grayColor()
                womanTitleLbl.text = "女"
                cell.contentView.addSubview(womanTitleLbl)
                
                // birthdayTitleLbl
                let birthdayTitleLbl = UILabel(frame: CGRectMake(20, sexTitleLbl.viewBottomY + 10, 65, 30))
                birthdayTitleLbl.textAlignment = .Left
                birthdayTitleLbl.font = UIFont.systemFontOfSize(15)
                birthdayTitleLbl.textColor = UIColor.grayColor()
                birthdayTitleLbl.text = "出生年份"
                cell.contentView.addSubview(birthdayTitleLbl)
                // birthdayTxt
                birthdayTxt = UITextField(frame: CGRectMake(birthdayTitleLbl.viewRightX, birthdayTitleLbl.viewY, screen_width * 0.6, 30))
                birthdayTxt.placeholder = "请选择"
                birthdayTxt.textAlignment = .Center
                birthdayTxt.layer.borderWidth = 1
                birthdayTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(birthdayTxt)
                // dropdownIv2
                let dropdownIv2 = UIImageView(frame: CGRectMake(birthdayTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv2.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv2)
                // add dropdownIv2
                nameTxt.addSubview(dropdownIv2)
                
                // phoneTitleLbl
                let phoneTitleLbl = UILabel(frame: CGRectMake(20, birthdayTxt.viewBottomY + 10, 65, 30))
                phoneTitleLbl.textAlignment = .Left
                phoneTitleLbl.font = UIFont.systemFontOfSize(15)
                phoneTitleLbl.textColor = UIColor.grayColor()
                phoneTitleLbl.text = "手机号码"
                cell.contentView.addSubview(phoneTitleLbl)
                // phoneTxt
                phoneTxt = UITextField(frame: CGRectMake(phoneTitleLbl.viewRightX, phoneTitleLbl.viewY, screen_width * 0.6, 30))
                phoneTxt.placeholder = "请填写您的手机号"
                phoneTxt.textAlignment = .Center
                phoneTxt.layer.borderWidth = 1
                phoneTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(phoneTxt)
                
                // contactTimeTitleLbl
                let contactTimeTitleLbl = UILabel(frame: CGRectMake(20, phoneTxt.viewBottomY + 10, 65, 30))
                contactTimeTitleLbl.textAlignment = .Left
                contactTimeTitleLbl.font = UIFont.systemFontOfSize(15)
                contactTimeTitleLbl.textColor = UIColor.grayColor()
                contactTimeTitleLbl.text = "联系时间"
                cell.contentView.addSubview(contactTimeTitleLbl)
                // contactTimeTxt
                contactTimeTxt = UITextField(frame: CGRectMake(contactTimeTitleLbl.viewRightX, contactTimeTitleLbl.viewY, screen_width * 0.6, 30))
                contactTimeTxt.placeholder = "请选择"
                contactTimeTxt.textAlignment = .Center
                contactTimeTxt.layer.borderWidth = 1
                contactTimeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(contactTimeTxt)
                // dropdownIv3
                let dropdownIv3 = UIImageView(frame: CGRectMake(contactTimeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv3.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv3)
                // add dropdownIv3
                contactTimeTxt.addSubview(dropdownIv3)
            }
        }else{
            if indexPath.row == 0{
                // iv
                let iv = UIImageView(frame: CGRectMake(20, (cell.viewHeight - 20) / 2, 20, 20))
                iv.image = UIImage(named: "zichanxinxi")
                cell.contentView.addSubview(iv)
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake(iv.viewRightX + 5, 0, 200, cell.viewHeight))
                titleLbl.text = "资产信息"
                titleLbl.textAlignment = .Left
                cell.contentView.addSubview(titleLbl)
            }else{
                // houseTitleLbl
                let houseTitleLbl = UILabel(frame: CGRectMake(20, 10, 60, 30))
                houseTitleLbl.textAlignment = .Left
                houseTitleLbl.font = UIFont.systemFontOfSize(15)
                houseTitleLbl.textColor = UIColor.grayColor()
                houseTitleLbl.text = "房产情况"
                cell.contentView.addSubview(houseTitleLbl)
                // firstIv
                let firstIv = UIImageView(frame: CGRectMake(houseTitleLbl.viewRightX + 3, houseTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                firstIv.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(firstIv)
                // firstTitleLbl
                let firstTitleLbl = UILabel(frame: CGRectMake(firstIv.viewRightX + 3, houseTitleLbl.viewY, 30, 30))
                firstTitleLbl.textAlignment = .Left
                firstTitleLbl.font = UIFont.systemFontOfSize(15)
                firstTitleLbl.textColor = UIColor.grayColor()
                firstTitleLbl.text = "无房"
                cell.contentView.addSubview(firstTitleLbl)
                // secondIv
                let secondIv = UIImageView(frame: CGRectMake(firstTitleLbl.viewRightX + 3, houseTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                secondIv.image = UIImage(named: "xuanze")
                cell.contentView.addSubview(secondIv)
                // secondTitleLbl
                let secondTitleLbl = UILabel(frame: CGRectMake(secondIv.viewRightX + 3, houseTitleLbl.viewY, 60, 30))
                secondTitleLbl.textAlignment = .Left
                secondTitleLbl.font = UIFont.systemFontOfSize(15)
                secondTitleLbl.textColor = UIColor.grayColor()
                secondTitleLbl.text = "有房无贷"
                cell.contentView.addSubview(secondTitleLbl)
                // thirdIv
                let thirdIv = UIImageView(frame: CGRectMake(secondTitleLbl.viewRightX + 3, houseTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                thirdIv.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(thirdIv)
                // thirdTitleLbl
                let thirdTitleLbl = UILabel(frame: CGRectMake(thirdIv.viewRightX + 3, houseTitleLbl.viewY, 60, 30))
                thirdTitleLbl.textAlignment = .Left
                thirdTitleLbl.font = UIFont.systemFontOfSize(15)
                thirdTitleLbl.textColor = UIColor.grayColor()
                thirdTitleLbl.text = "有房有贷"
                cell.contentView.addSubview(thirdTitleLbl)
                
                // carTitleLbl
                let carTitleLbl = UILabel(frame: CGRectMake(20, houseTitleLbl.viewBottomY + 10, 60, 30))
                carTitleLbl.textAlignment = .Left
                carTitleLbl.font = UIFont.systemFontOfSize(15)
                carTitleLbl.textColor = UIColor.grayColor()
                carTitleLbl.text = "房产情况"
                cell.contentView.addSubview(carTitleLbl)
                // firstIv2
                let firstIv2 = UIImageView(frame: CGRectMake(carTitleLbl.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                firstIv2.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(firstIv2)
                // firstTitleLbl2
                let firstTitleLbl2 = UILabel(frame: CGRectMake(firstIv2.viewRightX + 3, carTitleLbl.viewY, 30, 30))
                firstTitleLbl2.textAlignment = .Left
                firstTitleLbl2.font = UIFont.systemFontOfSize(15)
                firstTitleLbl2.textColor = UIColor.grayColor()
                firstTitleLbl2.text = "无房"
                cell.contentView.addSubview(firstTitleLbl2)
                // secondIv2
                let secondIv2 = UIImageView(frame: CGRectMake(firstTitleLbl2.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                secondIv2.image = UIImage(named: "xuanze")
                cell.contentView.addSubview(secondIv2)
                // secondTitleLbl2
                let secondTitleLbl2 = UILabel(frame: CGRectMake(secondIv2.viewRightX + 3, carTitleLbl.viewY, 60, 30))
                secondTitleLbl2.textAlignment = .Left
                secondTitleLbl2.font = UIFont.systemFontOfSize(15)
                secondTitleLbl2.textColor = UIColor.grayColor()
                secondTitleLbl2.text = "有房无贷"
                cell.contentView.addSubview(secondTitleLbl2)
                // thirdIv2
                let thirdIv2 = UIImageView(frame: CGRectMake(secondTitleLbl2.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                thirdIv2.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(thirdIv2)
                // thirdTitleLbl2
                let thirdTitleLbl2 = UILabel(frame: CGRectMake(thirdIv2.viewRightX + 3, carTitleLbl.viewY, 60, 30))
                thirdTitleLbl2.textAlignment = .Left
                thirdTitleLbl2.font = UIFont.systemFontOfSize(15)
                thirdTitleLbl2.textColor = UIColor.grayColor()
                thirdTitleLbl2.text = "有房有贷"
                cell.contentView.addSubview(thirdTitleLbl2)
                
                // incomeTitleLbl
                let incomeTitleLbl = UILabel(frame: CGRectMake(20, carTitleLbl.viewBottomY + 10, 65, 30))
                incomeTitleLbl.textAlignment = .Left
                incomeTitleLbl.font = UIFont.systemFontOfSize(15)
                incomeTitleLbl.textColor = UIColor.grayColor()
                incomeTitleLbl.text = "月均收入"
                cell.contentView.addSubview(incomeTitleLbl)
                // incomeTxt
                incomeTxt = UITextField(frame: CGRectMake(incomeTitleLbl.viewRightX, incomeTitleLbl.viewY, screen_width * 0.6, 30))
                incomeTxt.placeholder = "请选择"
                incomeTxt.textAlignment = .Center
                incomeTxt.layer.borderWidth = 1
                incomeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(incomeTxt)
                // dropdownIv
                let dropdownIv = UIImageView(frame: CGRectMake(incomeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv.image = UIImage(named: "sanjiaoxing")
                cell.contentView.addSubview(dropdownIv)
                // add dropdownIv
                incomeTxt.addSubview(dropdownIv)
                
                // cardTitleLbl
                let cardTitleLbl = UILabel(frame: CGRectMake(20, incomeTxt.viewBottomY + 10, 65, 30))
                cardTitleLbl.textAlignment = .Left
                cardTitleLbl.font = UIFont.systemFontOfSize(15)
                cardTitleLbl.textColor = UIColor.grayColor()
                cardTitleLbl.text = "信用卡"
                cell.contentView.addSubview(cardTitleLbl)
                // noIv
                let noIv = UIImageView(frame: CGRectMake(cardTitleLbl.viewRightX + 30, cardTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                noIv.image = UIImage(named: "wuxuanze")
                cell.contentView.addSubview(noIv)
                // noTitleLbl
                let noTitleLbl = UILabel(frame: CGRectMake(noIv.viewRightX + 5, cardTitleLbl.viewY, 20, 30))
                noTitleLbl.textAlignment = .Left
                noTitleLbl.font = UIFont.systemFontOfSize(15)
                noTitleLbl.textColor = UIColor.grayColor()
                noTitleLbl.text = "无"
                cell.contentView.addSubview(noTitleLbl)
                // yesIv
                let yesIv = UIImageView(frame: CGRectMake(noTitleLbl.viewRightX + 30, cardTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                yesIv.image = UIImage(named: "xuanze")
                cell.contentView.addSubview(yesIv)
                // yesTitleLbl
                let yesTitleLbl = UILabel(frame: CGRectMake(yesIv.viewRightX + 5, cardTitleLbl.viewY, 20, 30))
                yesTitleLbl.textAlignment = .Left
                yesTitleLbl.font = UIFont.systemFontOfSize(15)
                yesTitleLbl.textColor = UIColor.grayColor()
                yesTitleLbl.text = "有"
                cell.contentView.addSubview(yesTitleLbl)
            }
        }
        return cell
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
}
