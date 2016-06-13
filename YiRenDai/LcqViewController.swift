//
//  LcqViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/21.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class LcqViewController: BaseNavigationController {

    let cellIdentifier = "CellIdentifier"
    let lcqCell = "LcqCell"
    
    //view
    var tableView: UITableView!
    
    //data
    var lcqData = [JSON]()
    var pagenumber: Int!
    var pagesize = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("理财圈")
        
        initView()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height - tabBar_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.registerNib(UINib(nibName: "LcqTableViewCell", bundle: nil), forCellReuseIdentifier: lcqCell)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
        
        //上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }
    
    func refreshData(){
        pagenumber = 1
        DataProvider.sharedInstance.getArticleList("1", status_code: "1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.lcqData = data["data"].dictionaryValue["articlelist"]!.arrayValue
                //刷新结束
                self.tableView.mj_header.endRefreshing()
                if self.lcqData.count == data["data"]["page"]["total"].intValue{
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
        pagenumber = pagenumber + 1
        for _ in 1...3{
            //dataArray.append("新数据")
        }
        //刷新结束
        tableView.mj_footer.endRefreshing()
        //判断数据是否全部加载完
        if lcqData.count >= 30{
            tableView.mj_footer.state = MJRefreshState.NoMoreData
        }
        //刷新数据
        tableView.reloadData()
    }

}

extension LcqViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + lcqData.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            //先清空已存在控件
            for itemView in cell.subviews{
                itemView.removeFromSuperview()
            }
            //imageView
            let imageView = UIImageView(frame: CGRectMake(14, (45 - 20) / 2, 20, 20))
            imageView.image = UIImage(named: "bt_acc_withdraw_normal")
            cell.addSubview(imageView)
            //textLbl
            let textLbl = UILabel(frame: CGRectMake(imageView.viewRightX + 5, 0, screen_width - 28, cell.viewHeight))
            textLbl.font = UIFont.systemFontOfSize(14)
            textLbl.numberOfLines = 0
            textLbl.text = "测测多久变首富"
            cell.addSubview(textLbl)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(lcqCell, forIndexPath: indexPath) as! LcqTableViewCell
            cell.titleLbl.text = lcqData[indexPath.section - 1]["article_title"].stringValue
            cell.detailLbl.text = lcqData[indexPath.section - 1]["article_content"].stringValue
            cell.typeIv.image = UIImage(named: "community_article")
            cell.dateLbl.text = lcqData[indexPath.section - 1]["create_time"].stringValue
            let url = "\(lcqData[indexPath.section - 1]["article_image"].stringValue)"
            cell.imageIv.imageFromURL(url, placeholder: UIImage())
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 45
        default:
            return 200
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
        if indexPath.section == 0 {
            
        }else{
            let lcqDetailVC = LcqDetailViewController()
            lcqDetailVC.navtitle = lcqData[indexPath.section - 1]["article_title"].stringValue
            lcqDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(lcqDetailVC, animated: true)
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
