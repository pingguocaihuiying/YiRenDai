//
//  ManageTeamViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import AFImageHelper

class ManageTeamViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    
    //view
    var tableView: UITableView!
    
    //data
    var isExtension = Bool()
    var currentIndexPath: NSIndexPath?

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
    }
}

extension ManageTeamViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        cell.headIv.imageFromURL("", placeholder: UIImage(named: "acc_yrb_y")!)
        cell.nameLbl.text = "唐宁先生"
        cell.positionLbl.text = "董事局主席 / 创始人"
        let detailStr = "唐宁先生是宜人贷也是宜信的创始人，自宜信公司创立以来一直担任公司董事长以及首席执行官一职，并兼任宜人贷董事长。\n2014年12月，唐宁当选北京市网贷行业协会会长"
        let number = Int(cell.detailLbl.frame.size.width / 13)
        
        cell.detailLbl.text = detailStr.substringToIndex(detailStr.startIndex.advancedBy(number * 2))
        if indexPath == currentIndexPath && isExtension {
            cell.moreDetailTv.hidden = false
            cell.moreDetailTv.text = detailStr.substringFromIndex(detailStr.startIndex.advancedBy(number * 2))
            cell.moreIv.backgroundColor = UIColor.redColor()
        }else{
            cell.moreDetailTv.hidden = true
            cell.moreIv.backgroundColor = UIColor.blueColor()
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
