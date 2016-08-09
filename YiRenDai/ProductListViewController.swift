//
//  ProductListViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/18.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class ProductListViewController: BaseNavigationController {

    let cellIdentifier = "CellIdentifier"
    let cellIdentifierNib = "ProductListCell"
    
    //view
    var tableView: UITableView!
    
    //data
    var productListData = [JSON]()
    var pagenumber: Int!
    let pagesize = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("产品列表")
        
        initView()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height - tabBar_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.registerNib(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierNib)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
        
        //上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
    }
    
    func refreshData(){
        productListData.removeAll()
        pagenumber = 1
        //刷新结束
        self.tableView.mj_header.endRefreshing()
        DataProvider.sharedInstance.getProductList("1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.productListData = data["data"].dictionaryValue["productlist"]!.arrayValue
                if self.productListData.count == data["data"]["page"]["total"].intValue{
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
        DataProvider.sharedInstance.getProductList("1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            if data["status"]["succeed"].intValue == 1{
                let dataArray = data["data"].dictionaryValue["productlist"]!.arrayValue
                for i in 0 ..< dataArray.count{
                    self.productListData.append(dataArray[i])
                }
                //刷新结束
                self.tableView.mj_header.endRefreshing()
                if self.productListData.count == data["data"]["page"]["total"].intValue{
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
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + productListData.count
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
            let textLbl = UILabel(frame: CGRectMake(14, 0, screen_width - 28, cell.viewHeight))
            textLbl.textColor = UIColor.grayColor()
            textLbl.font = UIFont.systemFontOfSize(14)
            textLbl.numberOfLines = 0
            textLbl.text = "5.8亿元风险备用金为您的资产安全保驾护航"
            cell.addSubview(textLbl)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierNib, forIndexPath: indexPath) as! ProductListTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            for itemView in cell.contentView.subviews {
                if itemView.tag == 2001 {
                    itemView.removeFromSuperview()
                }
            }
            let remainMoney = productListData[indexPath.section - 1]["remaining_amount"].floatValue
            let startMoney = productListData[indexPath.section - 1]["min_amount"].floatValue
            let isSoldOut = remainMoney < startMoney ? true : false
            let is_tiro = productListData[indexPath.section - 1]["is_tiro"].intValue
            if is_tiro == 1 {
                // starIv
                let starIv = UIImageView(frame: CGRectMake(0, (cell.titleView.viewHeight - 16) / 2, 16, 16))
                starIv.image = UIImage(named: "xingji")
                cell.titleView.addSubview(starIv)
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake(starIv.viewRightX + 5, 0, 100, cell.titleView.viewHeight))
                titleLbl.text = "新手专区"
                titleLbl.textColor = isSoldOut ? UIColor.getGrayColorFirst() : UIColor.getRedColorFirst()
                titleLbl.font = UIFont.systemFontOfSize(16)
                cell.titleView.addSubview(titleLbl)
            }else{
                let titleLbl = UILabel(frame: CGRectMake(0, 0, cell.titleView.viewWidth, cell.titleView.viewHeight))
                titleLbl.textColor = isSoldOut ? UIColor.getGrayColorFirst() : UIColor.darkGrayColor()
                titleLbl.font = UIFont.systemFontOfSize(16)
                titleLbl.text = productListData[indexPath.section - 1]["product_name"].stringValue
                cell.titleView.addSubview(titleLbl)
            }
            cell.shouyiLbl.text = "\(productListData[indexPath.section - 1]["interest_rate"].stringValue)%"
            cell.fengbiqiLbl.text = productListData[indexPath.section - 1]["duration_type"].stringValue
            cell.amountLbl.text = "\(productListData[indexPath.section - 1]["min_amount"].stringValue)元"
            if isSoldOut{
                let soldOutIv = UIImageView(frame: CGRectMake(screen_width - 50, 10, 50, 17))
                soldOutIv.tag = 2001
                soldOutIv.image = UIImage(named: "yishouqin")
                cell.contentView.addSubview(soldOutIv)
                cell.shouyiTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.shouyiLbl.textColor = UIColor.getGrayColorFirst()
                cell.fengbiqiTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.fengbiqiLbl.textColor = UIColor.getGrayColorFirst()
                cell.amountTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.amountLbl.textColor = UIColor.getGrayColorFirst()
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 40
        default:
            return 100
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
        if indexPath.section > 0 {
            let ljInvestBtnVC = LjInvestBtnViewController()
            ljInvestBtnVC.productID = productListData[indexPath.section - 1]["product_id"].stringValue
            ljInvestBtnVC.navtitle = productListData[indexPath.section - 1]["product_name"].stringValue
            ljInvestBtnVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ljInvestBtnVC, animated: true)
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
