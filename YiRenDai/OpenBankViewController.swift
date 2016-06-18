//
//  OpenBankViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

protocol OpenBankViewControllerDellegate {
    func selectValue(value: String)
}

class OpenBankViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    var delegate: OpenBankViewControllerDellegate?
    
    // data
    var bankData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("选择开户银行")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        tableView.mj_header.endRefreshing()
        bankData = ["工商银行","农业银行","建设银行","中国银行"]
        tableView.reloadData()
    }

}

extension OpenBankViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        for itemView in cell.contentView.subviews{
            itemView.removeFromSuperview()
        }
        // iv
        let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 45) / 2, 45, 45))
        iv.image = UIImage(named: "touxiang")
        cell.contentView.addSubview(iv)
        
        // nameLbl
        let nameLbl = UILabel(frame: CGRectMake(iv.viewRightX + 10, 0, 200, cell.viewHeight))
        nameLbl.font = UIFont.systemFontOfSize(16)
        nameLbl.textAlignment = .Left
        nameLbl.text = bankData[indexPath.row].string
        cell.contentView.addSubview(nameLbl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if delegate != nil {
            delegate?.selectValue(bankData[indexPath.row].stringValue)
            self.navigationController?.popViewControllerAnimated(true)
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
}
