//
//  YouhuiquanViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class YouhuiquanViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    
    // data
    var youhuiquanData = [JSON]()
    var pagenumber: Int!
    let pagesize = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("我的优惠券")
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("使用说明")

        initView()
    }

    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        pagenumber = 1
        DataProvider.sharedInstance.getYouhuiquanList(ToolKit.getStringByKey("userId"), pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
            self.tableView.mj_header.endRefreshing()
            print(data)
            if data["status"]["succeed"].intValue == 1{
                self.youhuiquanData = data["data"]["couponlist"].arrayValue;
                if self.youhuiquanData.count == data["data"]["page"]["total"].intValue{
                    // 所有数据加载完毕，没有更多的数据了
                    self.tableView.mj_footer.state = MJRefreshState.NoMoreData
                }else{
                    // mj_footer设置为:普通闲置状态(Idle)
                    self.tableView.mj_footer.state = MJRefreshState.Idle
                }
                self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    func alertAddYouhuiquanView(){
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: "添加优惠券", message: nil, preferredStyle: .Alert)
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "请输入优惠券卡号（16位英文和数字）"
            }
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelAction)
            let okAction = UIAlertAction(title: "添加", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                let youhuiquanTxt = alertController.textFields?.first
                if !youhuiquanTxt!.text!.isEmpty{
                    DataProvider.sharedInstance.addYouhuiquan(ToolKit.getStringByKey("userId"), coupon_code: youhuiquanTxt!.text!, handler: { (data) in
                        print(data)
                    })
                }
            })
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func clickRightBtnEvent() {
        let upgradeStrategyVC = UpgradeStrategyViewController()
        upgradeStrategyVC.upgradeStrategyType = UpgradeStrategyType.Youhuiquan
        navigationController?.pushViewController(upgradeStrategyVC, animated: true)
    }

}

extension YouhuiquanViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 2//youhuiquanData.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }else{
            return 100
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.section == 0 {
            // bgIv
            let bgIv = UIImageView(frame: CGRectMake(10, 10, screen_width - 20, cell.viewHeight - 20))
            bgIv.image = UIImage(named: "youhuiquan_bg")
            cell.contentView.addSubview(bgIv)
            // plusView1
            let plusView1 = UIView(frame: CGRectMake((100 - 35) / 2, (bgIv.viewHeight - 3) / 2, 35, 3))
            plusView1.backgroundColor = UIColor.getGrayColorFirst()
            bgIv.addSubview(plusView1)
            // plusView2
            let plusView2 = UIView(frame: CGRectMake((100 - 3) / 2, (bgIv.viewHeight - 35) / 2, 3, 35))
            plusView2.backgroundColor = UIColor.getGrayColorFirst()
            bgIv.addSubview(plusView2)
            // lineView
            let lineView = UIView(frame: CGRectMake(100, 20, 0.5, bgIv.viewHeight - 40))
            lineView.backgroundColor = UIColor.lightGrayColor()
            bgIv.addSubview(lineView)
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(lineView.viewRightX + 10, 16, 200, 21))
            titleLbl.textColor = UIColor.grayColor()
            titleLbl.text = "添加优惠券"
            bgIv.addSubview(titleLbl)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(titleLbl.viewX, titleLbl.viewBottomY + 8, 200, 21))
            detailLbl.textColor = UIColor.grayColor()
            detailLbl.font = UIFont.systemFontOfSize(14)
            detailLbl.text = "可在购买理财产品时使用"
            bgIv.addSubview(detailLbl)
        }else{
            // bgLeftIv
            let bgLeftIv = UIImageView(frame: CGRectMake(10, 10, cell.viewHeight - 20, cell.viewHeight - 20))
            bgLeftIv.image = UIImage(named: "rl_coupons_left_overdue")
            cell.contentView.addSubview(bgLeftIv)
            // bgRightIv
            let bgRightIv = UIImageView(frame: CGRectMake(bgLeftIv.viewRightX, bgLeftIv.viewY, screen_width - bgLeftIv.viewWidth - 20, cell.viewHeight - 20))
            bgRightIv.image = UIImage(named: "rl_coupons_right_bg")
            cell.contentView.addSubview(bgRightIv)
            // moneyLbl
            let moneyLbl = UILabel(frame: CGRectMake(0, 15, bgLeftIv.viewWidth, 21))
            moneyLbl.textColor = UIColor.grayColor()
            moneyLbl.textAlignment = .Center
            let str = NSMutableAttributedString(string: "¥30")
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(20), range: NSMakeRange(1, str.length - 1))
            moneyLbl.attributedText = str
            bgLeftIv.addSubview(moneyLbl)
            // detailLbl1
            let detailLbl1 = UILabel(frame: CGRectMake(0, moneyLbl.viewBottomY + 10, bgLeftIv.viewWidth, 21))
            detailLbl1.font = UIFont.systemFontOfSize(12)
            detailLbl1.textColor = UIColor.grayColor()
            detailLbl1.textAlignment = .Center
            detailLbl1.text = "满30元可用"
            bgLeftIv.addSubview(detailLbl1)
            // titleRightLbl
            let titleRightLbl = UILabel(frame: CGRectMake(15, 10, 200, 21))
            titleRightLbl.font = UIFont.systemFontOfSize(16)
            titleRightLbl.textColor = UIColor.grayColor()
            titleRightLbl.text = "全部产品"
            bgRightIv.addSubview(titleRightLbl)
            // detailRightLbl1
            let detailRightLbl1 = UILabel(frame: CGRectMake(titleRightLbl.viewX, titleRightLbl.viewBottomY, 200, 21))
            detailRightLbl1.text = "2016-2-11已过期"
            detailRightLbl1.textColor = UIColor.grayColor()
            detailRightLbl1.font = UIFont.systemFontOfSize(12)
            bgRightIv.addSubview(detailRightLbl1)
            // detailRightLbl2
            let detailRightLbl2 = UILabel(frame: CGRectMake(titleRightLbl.viewX, detailRightLbl1.viewBottomY, 200, 21))
            detailRightLbl2.text = "注册送30"
            detailRightLbl2.textColor = UIColor.grayColor()
            detailRightLbl2.font = UIFont.systemFontOfSize(12)
            bgRightIv.addSubview(detailRightLbl2)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            alertAddYouhuiquanView()
        }
    }
}
