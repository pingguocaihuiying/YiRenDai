//
//  ManageTeamViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import AFImageHelper
import MJRefresh
import SwiftyJSON

class ManageTeamViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    
    //view
    var tableView: UITableView!
    
    //data
    var isExtension = Bool()
    var currentIndexPath: NSIndexPath?
    var teamManagerData = [JSON]()
    var pagenumber: Int!
    let pagesize = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")

        initView()
    }

    //MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 248
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "ManageTeamTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        tableView.mj_header.beginRefreshing()
        
        //上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }
    
    func refreshData(){
        teamManagerData.removeAll()
        pagenumber = 1
        //刷新结束
        self.tableView.mj_header.endRefreshing()
        DataProvider.sharedInstance.getTeamManage("\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            print(data)
            self.teamManagerData = data["data"]["managelist"].arrayValue
            if self.teamManagerData.count == data["data"]["page"]["total"].intValue{
                // 所有数据加载完毕，没有更多的数据了
                self.tableView.mj_footer.state = MJRefreshState.NoMoreData
            }else{
                // mj_footer设置为:普通闲置状态(Idle)
                self.tableView.mj_footer.state = MJRefreshState.Idle
            }
            //刷新数据
            self.tableView.reloadData()
        }
    }
    
    func loadMore(){
        pagenumber = pagenumber + 1
    }

}

extension ManageTeamViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamManagerData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if currentIndexPath != nil && currentIndexPath!.row == indexPath.row {
            if isExtension {
                return UITableViewAutomaticDimension
            }else{
                return 140
            }
        }else{
            return 140
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ManageTeamTableViewCell
        let photoStr = teamManagerData[indexPath.row]["manage_team_image"].stringValue
        cell.headIv.imageFromURL(photoStr, placeholder: UIImage(named: "acc_yrb_y")!)
        cell.nameLbl.text = teamManagerData[indexPath.row]["manage_team_name"].stringValue
        cell.positionLbl.text = teamManagerData[indexPath.row]["manage_team_tag"].stringValue
        let detailStr = teamManagerData[indexPath.row]["manage_team_about"].stringValue
        let number = Int(cell.detailLbl.frame.size.width / 13)
        if detailStr.characters.count > number * 2 {
            cell.detailLbl.text = detailStr.substringToIndex(detailStr.startIndex.advancedBy(number * 2))
        }else{
            cell.detailLbl.text = detailStr
        }
        if indexPath == currentIndexPath && isExtension {
            cell.moreDetailTv.hidden = false
            if detailStr.characters.count > number * 2 {
                cell.moreDetailTv.text = detailStr.substringFromIndex(detailStr.startIndex.advancedBy(number * 2))
            }else{
                cell.moreDetailTv.text = ""
            }
            cell.moreIv.image = UIImage(named: "more_intro_up")
        }else{
            cell.moreDetailTv.hidden = true
            cell.moreIv.image = UIImage(named: "guanlituandui_extend1")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if currentIndexPath == indexPath{
            isExtension = !isExtension
        }else{
            isExtension = true
        }
        currentIndexPath = indexPath
        tableView.reloadData()
    }
    //section
}
