//
//  OpenBankAddressViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFImageHelper
import MJRefresh

protocol OpenBankAddressViewControllerDellegate {
    func selectAddressValue(value: String)
}

class OpenBankAddressViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    var delegate: OpenBankAddressViewControllerDellegate?
    
    // data
    var openBankAddressData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("选择开户地区")
        setTopViewLeftBtnImg("left")

        initView()
    }

    //MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        tableView.mj_header.endRefreshing()
        openBankAddressData = ["北京市","天津市","河北省","陕西省"]
        tableView.reloadData()
    }

}

extension OpenBankAddressViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openBankAddressData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        for itemView in cell.contentView.subviews{
            itemView.removeFromSuperview()
        }
        
        // nameLbl
        let nameLbl = UILabel(frame: CGRectMake(15, 0, 200, cell.viewHeight))
        nameLbl.font = UIFont.systemFontOfSize(16)
        nameLbl.textAlignment = .Left
        nameLbl.text = openBankAddressData[indexPath.row].string
        cell.contentView.addSubview(nameLbl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if delegate != nil {
            delegate?.selectAddressValue(openBankAddressData[indexPath.row].stringValue)
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
