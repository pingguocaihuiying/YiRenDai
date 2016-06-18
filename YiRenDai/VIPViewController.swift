//
//  VIPViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/1.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class VIPViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    let cellIdentifierNib = "ProductListCell"
    
    // view
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("会员")
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("升级攻略")
        
        initView()
    }
    
    override func clickRightBtnEvent() {
        let upgradeStrategyVC = UpgradeStrategyViewController()
        upgradeStrategyVC.upgradeStrategyType = UpgradeStrategyType.UpgradeStrategy
        navigationController?.pushViewController(upgradeStrategyVC, animated: true)
    }

    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.registerNib(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierNib)
        view.addSubview(tableView)
    }

}

extension VIPViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else{
            return 3
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 175
            }else if indexPath.row == 1{
                return 50
            }else if indexPath.row == 2{
                return 100
            }else{
                return 50
            }
        }else{
            return 100
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
            cell.selectionStyle = .None
            for itemView in cell.contentView.subviews {
                itemView.removeFromSuperview()
            }
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor.getRedColorFirst()
                // headerPhotoIv
                let headerPhotoIv = UIImageView(frame: CGRectMake((screen_width - 65) / 2, 20, 65, 65))
                headerPhotoIv.image = UIImage(named: "touxiang")
                cell.contentView.addSubview(headerPhotoIv)
                // vipLevelLbl
                let vipLevelLbl = UILabel(frame: CGRectMake(0, headerPhotoIv.viewBottomY + 5, screen_width, 15))
                vipLevelLbl.textColor = UIColor.whiteColor()
                vipLevelLbl.font = UIFont.systemFontOfSize(15)
                vipLevelLbl.textAlignment = .Center
                vipLevelLbl.text = "注册会员V0"
                cell.contentView.addSubview(vipLevelLbl)
                // whiteProgressView
                let whiteProgressView = UIView(frame: CGRectMake(screen_width * 0.3 / 2, vipLevelLbl.viewBottomY + 10, screen_width * 0.7, 12))
                whiteProgressView.backgroundColor = UIColor.getGrayColorThird()
                whiteProgressView.alpha = 0.4
                whiteProgressView.layer.masksToBounds = true
                whiteProgressView.layer.cornerRadius = 5
                cell.contentView.addSubview(whiteProgressView)
                // fillProgressView
                let fillProgressView = UIView(frame: CGRectMake(whiteProgressView.viewX, whiteProgressView.viewY, screen_width / 2 - 10, 12))
                fillProgressView.backgroundColor = UIColor.getGrayColorFirst()
                fillProgressView.alpha = 0.4
                fillProgressView.layer.masksToBounds = true
                fillProgressView.layer.cornerRadius = 5
                cell.contentView.addSubview(fillProgressView)
                // showProgressLbl
                let showProgressLbl = UILabel(frame: CGRectMake(fillProgressView.viewX + 10, fillProgressView.viewY, 100, 12))
                showProgressLbl.font = UIFont.systemFontOfSize(12)
                showProgressLbl.textColor = UIColor.whiteColor()
                showProgressLbl.text = "0/100"
                cell.contentView.addSubview(showProgressLbl)
                // detailLbl
                let detailLbl = UILabel(frame: CGRectMake(whiteProgressView.viewX, showProgressLbl.viewBottomY + 15, screen_width - showProgressLbl.viewX, 15))
                detailLbl.font = UIFont.systemFontOfSize(15)
                detailLbl.textColor = UIColor.whiteColor()
                detailLbl.text = "还差100点财富值升级理财童子V1"
                cell.contentView.addSubview(detailLbl)
            }else if indexPath.row == 1{
                cell.backgroundColor = UIColor.getGrayColorFourth()
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake((screen_width - 80) / 2, 0, 80, cell.viewHeight))
                titleLbl.textAlignment = .Center
                titleLbl.textColor = UIColor.grayColor()
                titleLbl.font = UIFont.systemFontOfSize(16)
                titleLbl.text = "我的特权"
                cell.contentView.addSubview(titleLbl)
                // leftLineView
                let leftLineView = UIView(frame: CGRectMake(titleLbl.viewX - 10 - 80, (cell.viewHeight - 1) / 2, 80, 1))
                leftLineView.backgroundColor = UIColor.getGrayColorFirst()
                cell.contentView.addSubview(leftLineView)
                // rightLineView
                let rightLineView = UIView(frame: CGRectMake(titleLbl.viewRightX + 10, (cell.viewHeight - 1) / 2, 80, 1))
                rightLineView.backgroundColor = UIColor.getGrayColorFirst()
                cell.contentView.addSubview(rightLineView)
            }else if indexPath.row == 2{
                let detailLbl = UILabel(frame: CGRectMake(0, 0, screen_width, cell.viewHeight))
                detailLbl.textColor = UIColor.grayColor()
                detailLbl.textAlignment = .Center
                detailLbl.font = UIFont.systemFontOfSize(14)
                detailLbl.numberOfLines = 0
                detailLbl.text = "您还没有特权\n认证身份，并升级到理财童子V1，即可享受特权"
                cell.contentView.addSubview(detailLbl)
            }else if indexPath.row == 3{
                cell.backgroundColor = UIColor.getGrayColorFourth()
                // titleLbl
                let titleLbl = UILabel(frame: CGRectMake((screen_width - 100) / 2, 0, 100, cell.viewHeight))
                titleLbl.textAlignment = .Center
                titleLbl.textColor = UIColor.grayColor()
                titleLbl.font = UIFont.systemFontOfSize(16)
                titleLbl.text = "升级购买推荐"
                cell.contentView.addSubview(titleLbl)
                // leftLineView
                let leftLineView = UIView(frame: CGRectMake(titleLbl.viewX - 10 - 80, (cell.viewHeight - 1) / 2, 80, 1))
                leftLineView.backgroundColor = UIColor.getGrayColorFirst()
                cell.contentView.addSubview(leftLineView)
                // rightLineView
                let rightLineView = UIView(frame: CGRectMake(titleLbl.viewRightX + 10, (cell.viewHeight - 1) / 2, 80, 1))
                rightLineView.backgroundColor = UIColor.getGrayColorFirst()
                cell.contentView.addSubview(rightLineView)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierNib, forIndexPath: indexPath) as! ProductListTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            for itemView in cell.contentView.subviews {
                if itemView.tag == 3001 || itemView.tag == 3002 {
                    itemView.removeFromSuperview()
                }
            }
            //let remainMoney = productListData![indexPath.section - 1]["remaining_amount"].floatValue
            //let startMoney = productListData![indexPath.section - 1]["min_amount"].floatValue
            let isSoldOut = false //remainMoney < startMoney ? true : false
            let is_tiro = 0 //productListData![indexPath.section - 1]["is_tiro"].intValue
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
                titleLbl.text = "宜定盈-S18月期"//productListData![indexPath.section - 1]["product_name"].stringValue
                cell.titleView.addSubview(titleLbl)
            }
            cell.shouyiLbl.text = "7.8%" //"\(productListData![indexPath.section - 1]["interest_rate"].stringValue)%"
            cell.fengbiqiLbl.text = "18个月" //productListData![indexPath.section - 1]["duration_type"].stringValue
            cell.amountLbl.text = "100元" //"\(productListData![indexPath.section - 1]["min_amount"].stringValue)元"
            if isSoldOut{
                let soldOutIv = UIImageView(frame: CGRectMake(screen_width - 50, 10, 50, 17))
                soldOutIv.tag == 3001
                soldOutIv.image = UIImage(named: "yishouqin")
                cell.addSubview(soldOutIv)
                cell.shouyiTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.shouyiLbl.textColor = UIColor.getGrayColorFirst()
                cell.fengbiqiTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.fengbiqiLbl.textColor = UIColor.getGrayColorFirst()
                cell.amountTitleLbl.textColor = UIColor.getGrayColorFirst()
                cell.amountLbl.textColor = UIColor.getGrayColorFirst()
            }else{
                let detailLbl = UILabel(frame: CGRectMake(screen_width - 50, 10, 200, 14))
                detailLbl.tag == 3002
                detailLbl.textColor = UIColor.getRedColorFirst()
                detailLbl.font = UIFont.systemFontOfSize(14)
                detailLbl.textAlignment = .Right
                detailLbl.text = "购买100元即可完成升级"
                cell.contentView.addSubview(detailLbl)
            }
            return cell
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
        if indexPath.section == 1 {
            let ljInvestBtnVC = LjInvestBtnViewController()
            //ljInvestBtnVC.productID = productListData![indexPath.section - 1]["product_id"].stringValue
            //ljInvestBtnVC.navtitle = productListData![indexPath.section - 1]["product_name"].stringValue
            //ljInvestBtnVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ljInvestBtnVC, animated: true)
        }
    }
}
