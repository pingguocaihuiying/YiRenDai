//
//  HistoryRecordViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class HistoryRecordViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    // MARK: - 自定义方法
    func initView(){
        // clMenu
        let clMenu = CLMenu(frame: CGRectMake(0, top_height, screen_width, 40), menuArray: ["全部","收入","支出"])
        view.addSubview(clMenu)
        
        // tableView
        tableView = UITableView(frame: CGRectMake(0, top_height + clMenu.viewHeight, screen_width, screen_height - top_height - clMenu.viewHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }

}

extension HistoryRecordViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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