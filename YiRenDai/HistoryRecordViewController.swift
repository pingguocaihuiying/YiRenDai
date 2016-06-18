//
//  HistoryRecordViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

enum HistorySelectType: String {
    case All
    case Income
    case Payment
}

class HistoryRecordViewController: BaseNavigationController, CLMenuDelegate {
    
    let cellIdentifier = "CellIdentifier"
    
    // view
    var tableView: UITableView!
    var historySelectType: HistorySelectType = HistorySelectType.All
    var noRecordIv: UIImageView!
    var noRecordDetailLbl: UILabel!
    
    // data
    var historyRecordData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    // MARK: - 自定义方法
    func initView(){
        // clMenu
        let clMenu = CLMenu(frame: CGRectMake(0, top_height, screen_width, 40), menuArray: ["全部","收入","支出"])
        clMenu.delegate = self
        view.addSubview(clMenu)
        
        // tableView
        tableView = UITableView(frame: CGRectMake(0, top_height + clMenu.viewHeight, screen_width, screen_height - top_height - clMenu.viewHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        historyRecordData = []
        tableView.mj_header.endRefreshing()
        if historySelectType == HistorySelectType.All {
            historyRecordData = []
        }else if historySelectType == HistorySelectType.Income{
            historyRecordData = [""]
        }else if historySelectType == HistorySelectType.Payment{
            historyRecordData = ["", ""]
        }
        if historyRecordData.count <= 0 {
            // noRecordIv
            if noRecordIv == nil {
                noRecordIv = UIImageView(frame: CGRectMake((screen_width - 70) / 2, top_height + (tableView.viewHeight - 70) / 2, 70, 70))
                noRecordIv.contentMode = .ScaleAspectFit
                noRecordIv.image = UIImage(named: "yrb_list_no_image")
                view.addSubview(noRecordIv)
            }else{
                noRecordIv.hidden = false
            }
            
            // noRecordDetailLbl
            if noRecordDetailLbl == nil {
                noRecordDetailLbl = UILabel(frame: CGRectMake(0, noRecordIv.viewBottomY + 10, screen_width, 21))
                noRecordDetailLbl.textAlignment = .Center
                noRecordDetailLbl.textColor = UIColor.grayColor()
                noRecordDetailLbl.font = UIFont.systemFontOfSize(16)
                noRecordDetailLbl.text = "暂无记录"
                view.addSubview(noRecordDetailLbl)
            }else{
                noRecordDetailLbl.hidden = false
            }
        }else{
            if noRecordIv != nil && noRecordIv.hidden == false {
                noRecordIv.hidden = true
            }
            if noRecordDetailLbl != nil && noRecordDetailLbl.hidden == false {
                noRecordDetailLbl.hidden = true
            }
        }
        
        // 刷新tableView
        tableView.reloadData()
    }
    
    func clickMenuEvent(sender: UIButton) {
        switch sender.tag {
        case 0:
            historySelectType = HistorySelectType.All
        case 1:
            historySelectType = HistorySelectType.Income
        case 2:
            historySelectType = HistorySelectType.Payment
        default:
            break
        }
        tableView.mj_header.beginRefreshing()
    }

}

extension HistoryRecordViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyRecordData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        return cell
    }
}