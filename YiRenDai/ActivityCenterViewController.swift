//
//  ActivityCenterViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/23.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class ActivityCenterViewController: BaseNavigationController {

    let activityCenterCell = "ActivityCenterCell"
    
    //view
    var tableView: UITableView!
    
    //data
    var activityListData: JSON?
    var pagenumber: Int!
    var pagesize = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("活动中心")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: "ActivityCenterTableViewCell", bundle: nil), forCellReuseIdentifier: activityCenterCell)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
        
        //上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }
    
    func refreshData(){
        pagenumber = 1
        DataProvider.sharedInstance.getArticleList("2", status_code: "1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.activityListData = data["data"]["articlelist"]
                //刷新结束
                self.tableView.mj_header.endRefreshing()
                if self.activityListData!.count == data["data"]["page"]["total"].intValue{
                    // 所有数据加载完毕，没有更多的数据了
                    self.tableView.mj_footer.state = MJRefreshState.NoMoreData
                }else{
                    // mj_footer设置为:普通闲置状态(Idle)
                    self.tableView.mj_footer.state = MJRefreshState.Idle
                }
                //刷新数据
                self.tableView.reloadData()
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
    
    func loadMore(){
        for _ in 1...3{
            //dataArray.append("新数据")
        }
        //刷新结束
        tableView.mj_footer.endRefreshing()
        //判断数据是否全部加载完
        if activityListData!.count >= 30{
            tableView.mj_footer.state = MJRefreshState.NoMoreData
        }
        //刷新数据
        tableView.reloadData()
    }

}

extension ActivityCenterViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return activityListData == nil ? 0 : activityListData!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(activityCenterCell, forIndexPath: indexPath) as! ActivityCenterTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.titleLbl.text = activityListData![indexPath.section]["article_title"].stringValue
        cell.dateLbl.text = "2016.04.20 - 2016.04.27"
        cell.stateLbl.textColor = UIColor.getRedColorSecond()
        cell.stateLbl.text = "已结束"
        cell.stateLbl.layer.masksToBounds = true
        cell.stateLbl.layer.cornerRadius = 8
        cell.stateLbl.layer.borderWidth = 1
        cell.stateLbl.layer.borderColor = UIColor.getRedColorSecond().CGColor
        cell.imageIv.imageFromURL(activityListData![indexPath.section]["article_image"].stringValue, placeholder: UIImage())
        cell.detailLbl.text = activityListData![indexPath.section]["article_content"].stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 226
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