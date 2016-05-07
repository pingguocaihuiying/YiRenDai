//
//  ActivityCenterViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/23.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh

class ActivityCenterViewController: BaseNavigationController {

    let activityCenterCell = "ActivityCenterCell"
    
    //view
    var tableView: UITableView!
    
    //data
    var productListData = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        productListData = []
        //刷新结束
        tableView.mj_header.endRefreshing()
        //mj_footer设置为:普通闲置状态(Idle)
        tableView.mj_footer.state = MJRefreshState.Idle
        //刷新数据
        tableView.reloadData()
    }
    
    func loadMore(){
        for _ in 1...3{
            //dataArray.append("新数据")
        }
        //刷新结束
        tableView.mj_footer.endRefreshing()
        //判断数据是否全部加载完
        if productListData.count >= 30{
            tableView.mj_footer.state = MJRefreshState.NoMoreData
        }
        //刷新数据
        tableView.reloadData()
    }

}

extension ActivityCenterViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(activityCenterCell, forIndexPath: indexPath) as! ActivityCenterTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.titleLbl.text = "浓情母亲节"
        cell.dateLbl.text = "2016.04.20 - 2016.04.27"
        let stateLbl = UILabel(frame: CGRectMake(0, 0, cell.stateView.viewWidth, cell.stateView.viewHeight))
        stateLbl.textColor = UIColor.lightGrayColor()
        stateLbl.font = UIFont.systemFontOfSize(12)
        stateLbl.text = "已结束"
        cell.stateView.addSubview(stateLbl)
        cell.imageIv.image = UIImage(named: "image1")
        cell.detailLbl.text = "赢价值1320元爱康国宾尊享体验卷送母亲"
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
        headView.backgroundColor = UIColor.getColorThird()
        let upLineView = UIView(frame: CGRectMake(0, 0.25, screen_width, 0.25))
        upLineView.backgroundColor = UIColor.getColorSecond()
        headView.addSubview(upLineView)
        let downLineView = UIView(frame: CGRectMake(0, 14 - 0.25, screen_width, 0.25))
        downLineView.backgroundColor = UIColor.getColorSecond()
        headView.addSubview(downLineView)
        return headView
    }
}