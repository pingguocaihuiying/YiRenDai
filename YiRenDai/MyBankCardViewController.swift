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
        tableView.registerNib(UINib(nibName: "MyCardTableViewCell", bundle: nil), forCellReuseIdentifier: myCardTableViewCell)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
        
        // footerView
        let footerView = UIView(frame: CGRectMake(0, 0, 100, 40))
        tableView.tableFooterView = footerView
        // titleBtn
        let str = NSMutableAttributedString(string: "支持银行及限额")
        str.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, str.length))
        let titleBtn = UIButton(frame: CGRectMake(10, 10, 100, 14))
        titleBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        titleBtn.setAttributedTitle(str, forState: .Normal)
        titleBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        footerView.addSubview(titleBtn)
    }
    
    func refreshData(){
        cardData.removeAll()
        tableView.mj_header.endRefreshing()
        if selectItemIndex == 0 {
            var item = Dictionary<String, String>()
            item["name"] = "中国银行"
            item["detail"] = "限额：5万/笔"
            item["endNo"] = "（尾号7997）"
            cardData.append(JSON(item))
        }else if selectItemIndex == 1{
            cardData = []
        }
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
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
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(myCardTableViewCell, forIndexPath: indexPath) as! MyCardTableViewCell
            cell.selectionStyle = .None
            print(cardData)
            cell.headerIv.imageFromURL("", placeholder: UIImage(named: "touxiang")!)
            cell.titleLbl.text = cardData[indexPath.row]["name"].stringValue
            cell.detailLbl.text = cardData[indexPath.row]["detail"].stringValue
            cell.endNoLbl.text = cardData[indexPath.row]["endNo"].stringValue
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            cell.selectionStyle = .None
            cell.accessoryType = .DisclosureIndicator
            for itemView in cell.contentView.subviews {
                itemView.removeFromSuperview()
            }
            let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
            titleLbl.textAlignment = .Left
            titleLbl.font = UIFont.systemFontOfSize(16)
            titleLbl.text = "添加支付银行卡"
            cell.contentView.addSubview(titleLbl)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        }else{
            return 45
        }
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            let addBankCardVC = AddBankCardViewController()
            navigationController?.pushViewController(addBankCardVC, animated: true)
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