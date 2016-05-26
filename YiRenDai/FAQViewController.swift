//
//  FAQViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class FAQViewController: BaseNavigationController {
    
    //view
    var tableView: UITableView!
    
    //data
    
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
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
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
            if indexPath.row == 0 {
                cell.firstTitleLbl.text = "产品介绍"
            }else if indexPath.row == 1{
                cell.firstTitleLbl.text = "安全保障"
            }else if indexPath.row == 2{
                cell.firstTitleLbl.text = "注册/登陆"
            }else if indexPath.row == 3{
                cell.firstTitleLbl.text = "购买理财"
            }else if indexPath.row == 4{
                cell.firstTitleLbl.text = "提现赎回"
            }else if indexPath.row == 5{
                cell.firstTitleLbl.text = "宜人币"
            }else if indexPath.row == 6{
                cell.firstTitleLbl.text = "优惠券"
            }else if indexPath.row == 7{
                cell.firstTitleLbl.text = "会员中心"
            }
        }else{
            cell.secondTitleLbl.text = "客服热线"
            cell.secondDetail1Lbl.text = "400-060-9191"
            cell.secondDetail2Lbl.text = "服务时间8:00-20:00"
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
            if indexPath.row == 0 {
                let faqDetailVC = FAQDetailViewController()
                faqDetailVC.navtitle = "产品介绍"
                navigationController?.pushViewController(faqDetailVC, animated: true)
            }
        }else if indexPath.section == 1{
            view.callPhone(self, title: "立即拨打宜人贷理财客服电话", tels: "4000609191")
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