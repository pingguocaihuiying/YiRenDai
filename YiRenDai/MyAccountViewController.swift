//
//  MyAccountViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/26.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseNavigationController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height - tabBar_height))
        tableView.backgroundColor = UIColor.getColorThird()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        //headerView
        let headerView = UIView(frame: CGRectMake(0, 0, screen_width, 150))
        headerView.backgroundColor = UIColor.getColorThird()
        tableView.tableHeaderView = headerView
        //imageView
        let imageView = UIImageView(frame: CGRectMake((screen_width - 80) / 2, (150 - 80) / 2 - 20, 80, 80))
        imageView.image = UIImage(named: "iv_acc_user_img_bg_normal")
        headerView.addSubview(imageView)
        //nameLbl
        let nameLbl = UILabel(frame: CGRectMake(0, imageView.viewBottomY + 5, screen_width, 21))
        nameLbl.textColor = UIColor.grayColor()
        nameLbl.textAlignment = .Center
        nameLbl.text = "姓名"
        headerView.addSubview(nameLbl)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }

}

extension MyAccountViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRectMake(0, 0, screen_width, 0))
        cell.selectionStyle = .None
        if indexPath.section == 0 {
            //detailLeftLbl
            let detailLeftLbl = UILabel(frame: CGRectMake(20, 0, 120, 50))
            detailLeftLbl.textAlignment = .Left
            detailLeftLbl.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            detailLeftLbl.text = "账户信息"
            cell.addSubview(detailLeftLbl)
            //detailRightLbl
            let detailRightLbl = UILabel(frame: CGRectMake(screen_width - 20 - 120, 0, 120, 50))
            detailRightLbl.textAlignment = .Right
            detailRightLbl.font = UIFont.systemFontOfSize(14)
            detailRightLbl.textColor = UIColor.grayColor()
            let phoneStr = "15165561652"
            if phoneStr.characters.count >= 11 {
                detailRightLbl.text = "\(phoneStr.substringToIndex(phoneStr.startIndex.advancedBy(3)))****\(phoneStr.substringFromIndex(phoneStr.startIndex.advancedBy(8)))"
            }else{
                detailRightLbl.text = phoneStr
            }
            cell.addSubview(detailRightLbl)
        }else if indexPath.section == 1{
            cell.accessoryType = .DisclosureIndicator
            //detailLeftLbl
            let detailLeftLbl = UILabel(frame: CGRectMake(20, 0, 120, 50))
            detailLeftLbl.textAlignment = .Left
            detailLeftLbl.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            detailLeftLbl.text = "会员"
            cell.addSubview(detailLeftLbl)
            //detailRightLbl
            let detailRightLbl = UILabel(frame: CGRectMake(screen_width - 30 - 120, 0, 120, 50))
            detailRightLbl.textAlignment = .Right
            detailRightLbl.font = UIFont.systemFontOfSize(14)
            detailRightLbl.textColor = UIColor.grayColor()
            detailRightLbl.text = "注册会员V0"
            cell.addSubview(detailRightLbl)
        }else if indexPath.section == 2{
            cell.accessoryType = .DisclosureIndicator
            //detailLeftLbl
            let detailLeftLbl = UILabel(frame: CGRectMake(20, 0, 120, 50))
            detailLeftLbl.textAlignment = .Left
            detailLeftLbl.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            detailLeftLbl.text = "我的银行卡"
            cell.addSubview(detailLeftLbl)
            //detailRightLbl
            let detailRightLbl = UILabel(frame: CGRectMake(screen_width - 30 - 120, 0, 120, 50))
            detailRightLbl.textAlignment = .Right
            detailRightLbl.font = UIFont.systemFontOfSize(14)
            detailRightLbl.textColor = UIColor.grayColor()
            detailRightLbl.text = "管理银行卡"
            cell.addSubview(detailRightLbl)
        }else if indexPath.section == 3{
            cell.accessoryType = .DisclosureIndicator
            //detailLeftLbl
            let detailLeftLbl = UILabel(frame: CGRectMake(20, 0, 120, 50))
            detailLeftLbl.textAlignment = .Left
            detailLeftLbl.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            detailLeftLbl.text = "风险等级测评"
            cell.addSubview(detailLeftLbl)
            //detailRightLbl
            let detailRightLbl = UILabel(frame: CGRectMake(screen_width - 30 - 120, 0, 120, 50))
            detailRightLbl.textAlignment = .Right
            detailRightLbl.font = UIFont.systemFontOfSize(14)
            detailRightLbl.textColor = UIColor.grayColor()
            detailRightLbl.text = "去测评"
            cell.addSubview(detailRightLbl)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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
    
}