//
//  FAQViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class FAQViewController: BaseNavigationController {
    
    //view
    var tableView: UITableView!
    
    //data
    var questionListData = [JSON]()
    var calllistData: JSON!
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
        tableView.bounces = false
        tableView.backgroundColor = UIColor.getGrayColorThird()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        questionListData.removeAll()
        pagenumber = 1
        //刷新结束
        self.tableView.mj_header.endRefreshing()
        DataProvider.sharedInstance.getQuestionList("\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                print(data)
                self.questionListData = data["data"].dictionaryValue["questionlist"]!.arrayValue
                self.calllistData = data["data"].dictionaryValue["calllist"]![0]
                if self.questionListData.count == data["data"]["page"]["total"].intValue{
                    // 所有数据加载完毕，没有更多的数据了
                    self.tableView.mj_footer.state = MJRefreshState.NoMoreData
                }
                //刷新数据
                self.tableView.reloadData()
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return questionListData.count
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FAQTableViewCell.tableViewCellWith(tableView, indexPath: indexPath)
        if indexPath.section == 0 {
            cell.firstTitleLbl.text = questionListData[indexPath.row]["question_name"].stringValue
        }else{
            if calllistData != nil {
                cell.secondTitleLbl.text = "客服热线"
                cell.secondDetail1Lbl.text = calllistData!["question_tel"].stringValue
                cell.secondDetail2Lbl.text = calllistData!["question_time"].stringValue
            }else{
                cell.secondTitleLbl.text = ""
                cell.secondDetail1Lbl.text = ""
                cell.secondDetail2Lbl.text = ""
            }
        }
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
        if indexPath.section == 0 {
            let faqDetailVC = FAQDetailViewController()
            faqDetailVC.questionId = questionListData[indexPath.row]["question_id"].stringValue
            faqDetailVC.navtitle = questionListData[indexPath.row]["question_name"].stringValue
            navigationController?.pushViewController(faqDetailVC, animated: true)
        }else if indexPath.section == 1{
            view.callPhone(self, title: "立即拨打北部湾理财客服电话", tels: calllistData!["question_tel"].stringValue)
        }
    }
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, screen_width, 0))
        headerView.backgroundColor = UIColor.getGrayColorThird()
        let titleLbl = UILabel(frame: CGRectMake(8, 40 - 18, screen_width, 15))
        titleLbl.textColor = UIColor.grayColor()
        titleLbl.font = UIFont.systemFontOfSize(15)
        titleLbl.text = "没有解决问题？请联系客服"
        headerView.addSubview(titleLbl)
        return headerView
    }
}