//
//  BorrowListViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/8/24.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class BorrowListViewController: BaseNavigationController {
    
    let borrowListCell = "BorrowListTableViewCell"
    
    // view
    var mTableView: UITableView!
    var pagenumber: Int!
    var pagesize = 15
    
    // data
    var borrowListData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("借款列表")
        setTopViewLeftBtnImg("left")

        self.initView()
    }
    
    func initView(){
        mTableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.tableFooterView = UIView()
        mTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: borrowListCell)
        mTableView.registerNib(UINib(nibName: borrowListCell, bundle: nil), forCellReuseIdentifier: borrowListCell)
        self.view.addSubview(mTableView)
        
        //下拉刷新
        mTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        mTableView.mj_header.beginRefreshing()
        
        //上拉加载更多
        mTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }
    
    func refreshData(){
        borrowListData.removeAll()
        pagenumber = 1
        //刷新结束
        self.mTableView.mj_header.endRefreshing()
        DataProvider.sharedInstance.getBorrowList("1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.borrowListData = data["data"].dictionaryValue["ownerlist"]!.arrayValue
                if self.borrowListData.count == data["data"]["page"]["total"].intValue{
                    // 所有数据加载完毕，没有更多的数据了
                    self.mTableView.mj_footer.state = MJRefreshState.NoMoreData
                }else{
                    // mj_footer设置为:普通闲置状态(Idle)
                    self.mTableView.mj_footer.state = MJRefreshState.Idle
                }
                //刷新数据
                self.mTableView.reloadData()
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func loadMore(){
        pagenumber = pagenumber + 1
        DataProvider.sharedInstance.getBorrowList("1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                let dataArray = data["data"].dictionaryValue["productlist"]!.arrayValue
                for i in 0 ..< dataArray.count{
                    self.borrowListData.append(dataArray[i])
                }
                //刷新结束
                self.mTableView.mj_header.endRefreshing()
                if self.borrowListData.count == data["data"]["page"]["total"].intValue{
                    // 所有数据加载完毕，没有更多的数据了
                    self.mTableView.mj_footer.state = MJRefreshState.NoMoreData
                }else{
                    // mj_footer设置为:普通闲置状态(Idle)
                    self.mTableView.mj_footer.state = MJRefreshState.Idle
                }
                //刷新数据
                self.mTableView.reloadData()
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
        
    }

}

extension BorrowListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return borrowListData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(borrowListCell, forIndexPath: indexPath) as! BorrowListTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        print(borrowListData)
        let borrowTypeValue = borrowListData[indexPath.row]["loan_kinds"]
        if borrowTypeValue == "1"{
            cell.borrowType.text = "工薪贷"
        }else if borrowTypeValue == "2"{
            cell.borrowType.text = "助业贷"
        }else if borrowTypeValue == "3"{
            cell.borrowType.text = "物业贷"
        }else if borrowTypeValue == "4"{
            cell.borrowType.text = "车主贷"
        }
        cell.borrowMoney.text = "贷款金额：\(borrowListData[indexPath.row]["amounts"])"
        cell.borrowTerm.text = "借款期限：\(borrowListData[indexPath.row]["loan_term"])"
        let stateValue = borrowListData[indexPath.row]["status"]
        if stateValue == "0" {
            cell.borrowState.text = "审核中"
        }else if stateValue == "1"{
            cell.borrowState.text = "通过"
        }else if stateValue == "2"{
            cell.borrowState.text = "未通过"
        }
        cell.borrowDate.text = borrowListData[indexPath.row]["create_time"].stringValue
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}