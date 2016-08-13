//
//  ContactUsViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/5.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseNavigationController {
    // view
    var tableView: UITableView!
    var logoutBtn: UIButton!
    
    // data
    var mQQ: String!
    var mWeixin: String!
    var mPhone: String!
    var mDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        view.backgroundColor = UIColor.getGrayColorThird()
        
        initData()
    }
    
    //MARK:自定义方法
    func initData(){
        DataProvider.sharedInstance.contactUs { (data) in
            print(data)
            self.mQQ = data["data"].dictionaryValue["touchlist"]!.arrayValue[3].dictionaryValue["touch_tag"]!.stringValue
            self.mWeixin = data["data"].dictionaryValue["touchlist"]!.arrayValue[0].dictionaryValue["touch_tag"]!.stringValue
            self.mPhone = data["data"].dictionaryValue["touchlist"]!.arrayValue[1].dictionaryValue["touch_tag"]!.stringValue
            self.mDate = data["data"].dictionaryValue["touchlist"]!.arrayValue[1].dictionaryValue["touch_about"]!.stringValue
            
            self.initView()
        }
    }
    
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, 4 * 45 + 16))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
    
    func clickEvent(sender: UIButton){
        switch sender.tag {
        case 1:
            break
        default:
            break
        }
    }

}

extension ContactUsViewController: UITableViewDataSource, UITableViewDelegate{
    
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ContactUsTableViewCell.tableViewCellWith(tableView, indexPath: indexPath)
        if indexPath.row == 0 {
            cell.ivThree.image = UIImage(named: "more_contactus_qq")
            cell.nameThree.text = "官方QQ群"
            cell.detailThree.text = mQQ
        }else if indexPath.row == 1{
            cell.ivOne.image = UIImage(named: "more_contactus_wechat")
            cell.nameOne.text = "官方微信号"
            cell.detailOne.text = mWeixin
        }else if indexPath.row == 2{
            cell.ivTwo.image = UIImage(named: "more_contactus_call")
            cell.nameTwo.text = "客服热线"
            cell.detail1Two.text = mPhone
            cell.detail2Two.text = mDate
        }else{
            cell.ivOne.image = UIImage(named: "more_contactus_feedback")
            cell.nameOne.text = "意见反馈"
            cell.detailOne.text = ""
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45;
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            view.viewAlert(self, title: "关注方法", msg: "打开微信>添加好友，搜索“yidingyinggw”或“宜人贷理财官微”在结果页中进行关注", cancelButtonTitle: nil, otherButtonTitle: "确定", handler: nil)
        }else if indexPath.row == 2{
            view.callPhone(self, title: "立即拨打宜人贷理财客服电话", tels: "4001234567")
        }else if indexPath.row == 3{
            let feedbackVC = FeedbackViewController()
            feedbackVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(feedbackVC, animated: true)
        }
    }
    
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
}