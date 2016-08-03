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

class ApplyBorrowViewController: BaseNavigationController, CLPickerViewDelegate {

    let cellIdentifier = "CellIdentifier"
    
    var applyType: ApplyType!
    
    // view
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
    
    var amountValue: String!
    var purposeValue: String!
    var deadlineValue: String!
    var cityValue: String!
    var timeValue: String!
    var checkSexValue: Int!
    var birthdayValue: String!
    var contactTimeValue: String!
    var houseValue: Int!
    var carValue: Int!
    var incomeValue: String!
    var cardValue: Int!
    
    var bgView: CLPickerView!
    var pickerView: UIPickerView!
    
    // data
    var clickControl: Int!
    var currentShowData = [String]()
    
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
        let footerView = UIView(frame: CGRectMake(0, screen_height - 105, screen_width, 105))
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
        let okBtn = UIButton(frame: CGRectMake(20, protocolBtn.viewBottomY + 15, footerView.viewWidth - 40, 40))
        okBtn.setTitle("完成", forState: .Normal)
        okBtn.backgroundColor = UIColor.getRedColorFirst()
        okBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        okBtn.addTarget(self, action: #selector(clickCompleteEvent), forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(okBtn)
    }
    
    func clickCompleteEvent(){
        DataProvider.sharedInstance.jiekuanSubmit("1", amounts: "5000", loan_purpose: "消费", loan_term: "三个月", city: "临沂", live_time: "半年", name: "姓名", sex: "男", year: "22", tel: "12345678901", contact_time: "不限时间", house: "无", car_port: "无", avg_salary: "5000", card: "无", brand: "无", model_of_car: "无", record_data: "无", gearbox: "无", list_the_mileage: "无", price: "无", cc: "无", member_id: ToolKit.getStringByKey("userId")) { (data) in
            print(data)
        }
    }
    
    func clickTextField(sender: UIButton) {
        currentShowData = []
        clickControl = sender.tag
        if bgView == nil {
            bgView = CLPickerView(target: self)
            bgView.delegate = self
        }
        bgView.show()
        clickControl = sender.tag
        if sender.tag == 1 {
            currentShowData = ["消费","装修","深造","医疗","创业","扩大经营","资金周转","其它用途"]
        }else if sender.tag == 2{
            currentShowData = ["3月期"]
        }else if sender.tag == 3{
            currentShowData = ["临沂","济南","青岛"]
        }else if sender.tag == 4{
            currentShowData = ["小于6个月","6个月-1年","1年-3年","3年-5年","5年以上"]
        }else if sender.tag == 5{
            for i in 1954 ... 2016  {
                currentShowData.append("\(i)")
            }
        }else if sender.tag == 6{
            currentShowData = ["不限时间","请尽快联系我","周一至周五9：00-18：00","周一至周五18：00-21：00","周末9：00-18：00","周末18：00-21：00"]
        }
        bgView.showData = currentShowData
    }
    
    func checkEvent(tap: UITapGestureRecognizer){
        let view = tap.view
        let iFlagValue = view!.tag
        if iFlagValue == 1 || iFlagValue == 2 {
            checkSexValue = iFlagValue
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .Automatic)
        }else if iFlagValue == 3 || iFlagValue == 4 || iFlagValue == 5{
            houseValue = iFlagValue
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
        }else if iFlagValue == 6 || iFlagValue == 7 || iFlagValue == 8{
            carValue = iFlagValue
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
        }else if iFlagValue == 9 || iFlagValue == 10{
            cardValue = iFlagValue
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
        }
    }
    
    // CLPickerViewDelegate
    func selectRow(value: String) {
        print(value)
        switch clickControl {
        case 1:
            purposeValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
        case 2:
            deadlineValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
        case 3:
            cityValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .Automatic)
        case 4:
            timeValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .Automatic)
        case 5:
            birthdayValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .Automatic)
        case 6:
            contactTimeValue = value
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .Automatic)
        default:
            break
        }
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
                amountTxt.keyboardType = .NumberPad
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
                purposeTxt.text = purposeValue
                purposeTxt.layer.borderWidth = 1
                purposeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(purposeTxt)
                // purposeBtn
                let purposeBtn = UIButton(frame: purposeTxt.frame)
                purposeBtn.tag = 1
                purposeBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(purposeBtn)
                // dropdownIv1
                let dropdownIv1 = UIImageView(frame: CGRectMake(purposeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv1.image = UIImage(named: "sanjiaoxing")
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
                deadlineTxt.text = deadlineValue
                deadlineTxt.textAlignment = .Center
                deadlineTxt.layer.borderWidth = 1
                deadlineTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(deadlineTxt)
                // deadlineBtn
                let deadlineBtn = UIButton(frame: deadlineTxt.frame)
                deadlineBtn.tag = 2
                deadlineBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(deadlineBtn)
                // dropdownIv2
                let dropdownIv2 = UIImageView(frame: CGRectMake(purposeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv2.image = UIImage(named: "sanjiaoxing")
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
                cityTxt.text = cityValue
                cityTxt.textAlignment = .Center
                cityTxt.layer.borderWidth = 1
                cityTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(cityTxt)
                // cityBtn
                let cityBtn = UIButton(frame: cityTxt.frame)
                cityBtn.tag = 3
                cityBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(cityBtn)
                // dropdownIv0
                let dropdownIv0 = UIImageView(frame: CGRectMake(cityTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv0.image = UIImage(named: "sanjiaoxing")
                // add dropdownIv0
                cityTxt.addSubview(dropdownIv0)
                
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
                timeTxt.text = timeValue
                timeTxt.textAlignment = .Center
                timeTxt.layer.borderWidth = 1
                timeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(timeTxt)
                // timeBtn
                let timeBtn = UIButton(frame: timeTxt.frame)
                timeBtn.tag = 4
                timeBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(timeBtn)
                // dropdownIv1
                let dropdownIv1 = UIImageView(frame: CGRectMake(timeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv1.image = UIImage(named: "sanjiaoxing")
                // add dropdownIv1
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
                manIv.image = UIImage(named: checkSexValue == nil || checkSexValue == 1 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(manIv)
                manIv.tag = 1
                let tapMan = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                manIv.userInteractionEnabled = true
                manIv.addGestureRecognizer(tapMan)
                
                // manTitleLbl
                let manTitleLbl = UILabel(frame: CGRectMake(manIv.viewRightX + 5, sexTitleLbl.viewY, 20, 30))
                manTitleLbl.textAlignment = .Left
                manTitleLbl.font = UIFont.systemFontOfSize(15)
                manTitleLbl.textColor = UIColor.grayColor()
                manTitleLbl.text = "男"
                cell.contentView.addSubview(manTitleLbl)
                // womanIv
                let womanIv = UIImageView(frame: CGRectMake(manTitleLbl.viewRightX + 30, sexTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                womanIv.image = UIImage(named: checkSexValue != nil && checkSexValue == 2 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(womanIv)
                womanIv.tag = 2
                let tapWoman = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                womanIv.userInteractionEnabled = true
                womanIv.addGestureRecognizer(tapWoman)
                
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
                birthdayTxt.text = birthdayValue
                birthdayTxt.textAlignment = .Center
                birthdayTxt.layer.borderWidth = 1
                birthdayTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(birthdayTxt)
                // birthdayBtn
                let birthdayBtn = UIButton(frame: birthdayTxt.frame)
                birthdayBtn.tag = 5
                birthdayBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(birthdayBtn)
                // dropdownIv2
                let dropdownIv2 = UIImageView(frame: CGRectMake(birthdayTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv2.image = UIImage(named: "sanjiaoxing")
                // add dropdownIv2
                birthdayTxt.addSubview(dropdownIv2)
                
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
                phoneTxt.keyboardType = .PhonePad
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
                contactTimeTxt.text = contactTimeValue
                contactTimeTxt.textAlignment = .Center
                contactTimeTxt.layer.borderWidth = 1
                contactTimeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(contactTimeTxt)
                // contactTimeBtn
                let contactTimeBtn = UIButton(frame: contactTimeTxt.frame)
                contactTimeBtn.tag = 6
                contactTimeBtn.addTarget(self, action: #selector(clickTextField(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(contactTimeBtn)
                // dropdownIv3
                let dropdownIv3 = UIImageView(frame: CGRectMake(contactTimeTxt.viewWidth - 20, (30 - 12) / 2, 15, 12))
                dropdownIv3.image = UIImage(named: "sanjiaoxing")
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
                firstIv.image = UIImage(named: houseValue != nil && houseValue == 3 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(firstIv)
                firstIv.tag = 3
                let tapFirst = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                firstIv.userInteractionEnabled = true
                firstIv.addGestureRecognizer(tapFirst)
                // firstTitleLbl
                let firstTitleLbl = UILabel(frame: CGRectMake(firstIv.viewRightX + 3, houseTitleLbl.viewY, 30, 30))
                firstTitleLbl.textAlignment = .Left
                firstTitleLbl.font = UIFont.systemFontOfSize(15)
                firstTitleLbl.textColor = UIColor.grayColor()
                firstTitleLbl.text = "无房"
                cell.contentView.addSubview(firstTitleLbl)
                // secondIv
                let secondIv = UIImageView(frame: CGRectMake(firstTitleLbl.viewRightX + 3, houseTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                secondIv.image = UIImage(named: houseValue == nil || houseValue == 4 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(secondIv)
                secondIv.tag = 4
                let tapSecond = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                secondIv.userInteractionEnabled = true
                secondIv.addGestureRecognizer(tapSecond)
                // secondTitleLbl
                let secondTitleLbl = UILabel(frame: CGRectMake(secondIv.viewRightX + 3, houseTitleLbl.viewY, 60, 30))
                secondTitleLbl.textAlignment = .Left
                secondTitleLbl.font = UIFont.systemFontOfSize(15)
                secondTitleLbl.textColor = UIColor.grayColor()
                secondTitleLbl.text = "有房无贷"
                cell.contentView.addSubview(secondTitleLbl)
                // thirdIv
                let thirdIv = UIImageView(frame: CGRectMake(secondTitleLbl.viewRightX + 3, houseTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                thirdIv.image = UIImage(named: houseValue != nil && houseValue == 5 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(thirdIv)
                thirdIv.tag = 5
                let tapThird = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                thirdIv.userInteractionEnabled = true
                thirdIv.addGestureRecognizer(tapThird)
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
                carTitleLbl.text = "车产情况"
                cell.contentView.addSubview(carTitleLbl)
                // firstIv2
                let firstIv2 = UIImageView(frame: CGRectMake(carTitleLbl.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                firstIv2.image = UIImage(named: carValue != nil && carValue == 6 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(firstIv2)
                firstIv2.tag = 6
                let tapFirstIv2 = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                firstIv2.userInteractionEnabled = true
                firstIv2.addGestureRecognizer(tapFirstIv2)
                // firstTitleLbl2
                let firstTitleLbl2 = UILabel(frame: CGRectMake(firstIv2.viewRightX + 3, carTitleLbl.viewY, 30, 30))
                firstTitleLbl2.textAlignment = .Left
                firstTitleLbl2.font = UIFont.systemFontOfSize(15)
                firstTitleLbl2.textColor = UIColor.grayColor()
                firstTitleLbl2.text = "无车"
                cell.contentView.addSubview(firstTitleLbl2)
                // secondIv2
                let secondIv2 = UIImageView(frame: CGRectMake(firstTitleLbl2.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                secondIv2.image = UIImage(named: carValue == nil || carValue == 7 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(secondIv2)
                secondIv2.tag = 7
                let tapSecondIv2 = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                secondIv2.userInteractionEnabled = true
                secondIv2.addGestureRecognizer(tapSecondIv2)
                // secondTitleLbl2
                let secondTitleLbl2 = UILabel(frame: CGRectMake(secondIv2.viewRightX + 3, carTitleLbl.viewY, 60, 30))
                secondTitleLbl2.textAlignment = .Left
                secondTitleLbl2.font = UIFont.systemFontOfSize(15)
                secondTitleLbl2.textColor = UIColor.grayColor()
                secondTitleLbl2.text = "有车无贷"
                cell.contentView.addSubview(secondTitleLbl2)
                // thirdIv2
                let thirdIv2 = UIImageView(frame: CGRectMake(secondTitleLbl2.viewRightX + 3, carTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                thirdIv2.image = UIImage(named: carValue != nil && carValue == 8 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(thirdIv2)
                thirdIv2.tag = 8
                let tapThirdIv2 = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                thirdIv2.userInteractionEnabled = true
                thirdIv2.addGestureRecognizer(tapThirdIv2)
                // thirdTitleLbl2
                let thirdTitleLbl2 = UILabel(frame: CGRectMake(thirdIv2.viewRightX + 3, carTitleLbl.viewY, 60, 30))
                thirdTitleLbl2.textAlignment = .Left
                thirdTitleLbl2.font = UIFont.systemFontOfSize(15)
                thirdTitleLbl2.textColor = UIColor.grayColor()
                thirdTitleLbl2.text = "有车有贷"
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
                incomeTxt.keyboardType = .NumberPad
                incomeTxt.text = incomeValue
                incomeTxt.textAlignment = .Center
                incomeTxt.layer.borderWidth = 1
                incomeTxt.layer.borderColor = UIColor.lightGrayColor().CGColor
                cell.contentView.addSubview(incomeTxt)
                // yuanLbl
                let yuanLbl = UILabel(frame: CGRectMake(incomeTxt.viewRightX + 2, incomeTxt.viewY, 30, 30))
                yuanLbl.text = "元"
                yuanLbl.textColor = UIColor.grayColor()
                yuanLbl.font = UIFont.systemFontOfSize(15)
                cell.contentView.addSubview(yuanLbl)
                
                // cardTitleLbl
                let cardTitleLbl = UILabel(frame: CGRectMake(20, incomeTxt.viewBottomY + 10, 65, 30))
                cardTitleLbl.textAlignment = .Left
                cardTitleLbl.font = UIFont.systemFontOfSize(15)
                cardTitleLbl.textColor = UIColor.grayColor()
                cardTitleLbl.text = "信用卡"
                cell.contentView.addSubview(cardTitleLbl)
                // noIv
                let noIv = UIImageView(frame: CGRectMake(cardTitleLbl.viewRightX + 30, cardTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                noIv.image = UIImage(named: cardValue != nil && cardValue == 9 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(noIv)
                noIv.tag = 9
                let tapNoIv = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                noIv.userInteractionEnabled = true
                noIv.addGestureRecognizer(tapNoIv)
                // noTitleLbl
                let noTitleLbl = UILabel(frame: CGRectMake(noIv.viewRightX + 5, cardTitleLbl.viewY, 20, 30))
                noTitleLbl.textAlignment = .Left
                noTitleLbl.font = UIFont.systemFontOfSize(15)
                noTitleLbl.textColor = UIColor.grayColor()
                noTitleLbl.text = "无"
                cell.contentView.addSubview(noTitleLbl)
                // yesIv
                let yesIv = UIImageView(frame: CGRectMake(noTitleLbl.viewRightX + 30, cardTitleLbl.viewY + (30 - 20) / 2, 20, 20))
                yesIv.image = UIImage(named: cardValue == nil || cardValue == 10 ? "xuanze" : "wuxuanze")
                cell.contentView.addSubview(yesIv)
                yesIv.tag = 10
                let tapYesIv = UITapGestureRecognizer(target: self, action: #selector(checkEvent(_:)))
                yesIv.userInteractionEnabled = true
                yesIv.addGestureRecognizer(tapYesIv)
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
