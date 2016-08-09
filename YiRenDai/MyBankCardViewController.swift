//
//  MyBankCardViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/2.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import AFImageHelper

class MyBankCardViewController: BaseNavigationController, CLMenuDelegate {

    let myCardTableViewCell = "MyCardTableViewCell"
    let cellIdentifier = "CellIdentifier"
    
    // view
    var tableView: UITableView!
    
    // data
    var cardData = [JSON]()
    var selectItemIndex: Int = 0
    var pagenumber: Int!
    let pagesize = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("支持银行及限额")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    // MARK:自定义方法
    private func initView(){
        let clMenu = CLMenu(frame: CGRectMake(0, top_height, screen_width, 40), menuArray: ["支出","提现"])
        clMenu.delegate = self
        view.addSubview(clMenu)
        // tableView
        tableView = UITableView(frame: CGRectMake(0, top_height + clMenu.viewHeight, screen_width, screen_height - top_height - clMenu.viewHeight))
        tableView.backgroundColor = UIColor.getGrayColorThird()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: "MyCardTableViewCell", bundle: nil), forCellReuseIdentifier: myCardTableViewCell)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        cardData.removeAll()
        tableView.mj_header.endRefreshing()
        pagenumber = 1
        if selectItemIndex == 0 {
            DataProvider.sharedInstance.getBanCardkList(ToolKit.getStringByKey("userId"), status_id: "1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)", handler: { (data) in
                if data["status"].dictionaryValue["succeed"]?.intValue == 1{
                    self.cardData = data["data"].dictionaryValue["cardlist"]!.arrayValue
                    self.tableView.reloadData()
                }
            })
        }else if selectItemIndex == 1{
            cardData = []
        }
    }
    
    // CLMenuDelegate
    func clickMenuEvent(sender: UIButton) {
        selectItemIndex = sender.tag
        tableView.mj_header.beginRefreshing()
    }
}

extension MyBankCardViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cardData.count
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(myCardTableViewCell, forIndexPath: indexPath) as! MyCardTableViewCell
            cell.selectionStyle = .None
            print(cardData)
            cell.headerIv.imageFromURL("", placeholder: UIImage(named: "touxiang")!)
            cell.titleLbl.text = ToolKitObjC.returnBankName(cardData[indexPath.row]["card_number"].stringValue)
            cell.detailLbl.text = "限额：5万/笔"
            cell.endNoLbl.text = cardData[indexPath.row]["card_number"].stringValue
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            cell.selectionStyle = .None
            for itemView in cell.contentView.subviews {
                itemView.removeFromSuperview()
            }
            if indexPath.row == 0{
                cell.accessoryType = .DisclosureIndicator
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(16)
                titleLbl.text = selectItemIndex == 0 ? "添加支付银行卡" : "添加提现银行卡"
                cell.contentView.addSubview(titleLbl)
            }else{
                cell.backgroundColor = UIColor.getGrayColorThird()
                if selectItemIndex == 0 {
                    let iv = UIImageView(frame: CGRectMake(10, (cell.viewHeight - 20) / 2, 30, 20))
                    iv.image = UIImage(named: "bank")
                    cell.contentView.addSubview(iv)
                    // titleBtn
                    let str = NSMutableAttributedString(string: "支持银行及限额")
                    str.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, str.length))
                    let titleBtn = UIButton(frame: CGRectMake(iv.viewRightX + 3, 0, 120, cell.viewHeight))
                    titleBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    titleBtn.setAttributedTitle(str, forState: .Normal)
                    titleBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
                    cell.contentView.addSubview(titleBtn)
                }else{
                    // detailLbl
                    let detailLbl = UILabel(frame: CGRectMake(15, 5, screen_width  - 30, 60))
                    detailLbl.font = UIFont.systemFontOfSize(14)
                    detailLbl.textColor = UIColor.darkGrayColor()
                    detailLbl.numberOfLines = 0
                    detailLbl.text = "目前支持：建行、工行、招行、农行、中行、民生银行、兴大、光大、平安、浦发、广发、华夏、邮政、交行、中信。"
                    cell.contentView.addSubview(detailLbl)
                }
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        }else{
            if indexPath.row == 0 {
                return 45
            }else{
                if selectItemIndex == 0 {
                    return 45
                }else{
                    return 70
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            if selectItemIndex == 0 {
                let addPaymentBankCardVC = AddPaymentBankCardViewController()
                navigationController?.pushViewController(addPaymentBankCardVC, animated: true)
            }else{
                let addBankCardVC = AddBankCardViewController()
                navigationController?.pushViewController(addBankCardVC, animated: true)
            }
        }
    }
    
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 14
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, screen_width, 14))
        headView.backgroundColor = UIColor.getGrayColorThird()
        let upLineView = UIView(frame: CGRectMake(0, 0.25, screen_width, 0.25))
        upLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(upLineView)
        let downLineView = UIView(frame: CGRectMake(0, 14 - 0.25, screen_width, 0.25))
        downLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(downLineView)
        return headView
    }
    
}