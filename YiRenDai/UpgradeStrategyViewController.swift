//
//  UpgradeStrategyViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/2.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class UpgradeStrategyViewController: BaseNavigationController {
    
    let cellIdentifierNib = "CellIdentifierNib"
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("升级攻略")
        setTopViewLeftBtnImg("left")

        initView()
    }
    
    // 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: "UpgradeStrategyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierNib)
        view.addSubview(tableView)
    }

}

extension UpgradeStrategyViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierNib, forIndexPath: indexPath) as! UpgradeStrategyTableViewCell
        cell.titleLbl.text = "第\(indexPath.row + 1)个问题"
        cell.detailLbl.text = "详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息详细信息"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
