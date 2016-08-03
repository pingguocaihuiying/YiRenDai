//
//  IBorrowViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/31.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class IBorrowViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    
    // view
    var tableView: UITableView!
    
    // data
    var iBorrowData: JSON?
    var pagenumber = 0
    var pagesize = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("我要借款")
        
        initView()
    }

    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height - tabBar_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.lightTextColor()
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        //tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        pagenumber = 1
//        DataProvider.sharedInstance.getArticleList("1", status_code: "1", pagenumber: "\(pagenumber)", pagesize: "\(pagesize)") { (data) in
//            //刷新结束
//            self.tableView.mj_header.endRefreshing()
//            if data["status"]["succeed"].intValue == 1{
//                self.iBorrowData = data["data"]["articlelist"]
//                //刷新结束
//                self.tableView.mj_header.endRefreshing()
//                if self.iBorrowData!.count == data["data"]["page"]["total"].intValue{
//                    // 所有数据加载完毕，没有更多的数据了
//                    self.tableView.mj_footer.state = MJRefreshState.NoMoreData
//                }else{
//                    // mj_footer设置为:普通闲置状态(Idle)
//                    self.tableView.mj_footer.state = MJRefreshState.Idle
//                }
//                //刷新数据
//                self.tableView.reloadData()
//            }else{
//                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
//            }
//        }
    }
    
    func applyBorrowFunc(sender: UIButton){
        let applyBorrowVC = ApplyBorrowViewController()
        applyBorrowVC.navtitle = "上班族 - 工薪贷"
        applyBorrowVC.hidesBottomBarWhenPushed = true
        applyBorrowVC.applyType = ApplyType.Gongxindai
        navigationController?.pushViewController(applyBorrowVC, animated: true)
    }

}

extension IBorrowViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return 2
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.section == 0 {
            // iv
            let iv = UIImageView(frame: CGRectMake(10, (cell.viewHeight - 16) / 2, 16, 16))
            iv.image = UIImage(named: "woyaojiekuan")
            cell.contentView.addSubview(iv)
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(iv.viewRightX + 2, 0, 200, cell.viewHeight))
            titleLbl.font = UIFont.systemFontOfSize(16)
            titleLbl.contentMode = .Left
            titleLbl.text = "借款的方式和流程"
            titleLbl.textColor = UIColor.grayColor()
            cell.contentView.addSubview(titleLbl)
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                let iv = UIImageView(frame: CGRectMake(0, 0, screen_width, cell.viewHeight))
                iv.image = UIImage(named: "default_bgimg")
                cell.contentView.addSubview(iv)
            }else{
                //customBtn1
                let customBtn1 = CLButton(frame: CGRectMake(0, 3, screen_width / 4, 80), imageName: "zerodistance", title: "0距离", detail: "全国超100家客户数据验证中心", detailColor: UIColor.darkGrayColor())
                cell.addSubview(customBtn1)
                //customBtn2
                let customBtn2 = CLButton(frame: CGRectMake(screen_width / 4, 3, screen_width / 4, 80), imageName: "sanbu", title: "3步", detail: "3部流程申请快", detailColor: UIColor.darkGrayColor())
                cell.addSubview(customBtn2)
                //customBtn3
                let customBtn3 = CLButton(frame: CGRectMake(screen_width / 4 * 2, 3, screen_width / 4, 80), imageName: "sikuan", title: "4款", detail: "4款可选贷得到", detailColor: UIColor.darkGrayColor())
                cell.addSubview(customBtn3)
                //customBtn4
                let customBtn4 = CLButton(frame: CGRectMake(screen_width / 4 * 3, 3, screen_width / 4, 80), imageName: "wudahang", title: "5大行", detail: "自动还款超方便", detailColor: UIColor.darkGrayColor())
                cell.addSubview(customBtn4)
                
            }
        }else{
            cell.backgroundColor = UIColor.lightTextColor()
            if indexPath.row == 0 {
                // leftBtn
                let leftBtn = UIButton(frame: CGRectMake(5, 0, (screen_width - 15) / 2, cell.viewHeight - 10))
                leftBtn.layer.masksToBounds = true
                leftBtn.layer.borderWidth = 1
                leftBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
                leftBtn.backgroundColor = UIColor.lightTextColor()
                leftBtn.tag = 1
                leftBtn.addTarget(self, action: #selector(applyBorrowFunc(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(leftBtn)
                // leftTopView
                let leftTopView = UIView(frame: CGRectMake(0, 0, leftBtn.viewWidth, 40))
                leftTopView.backgroundColor = UIColor(red:0.38, green:0.61, blue:0.91, alpha:1.00)
                leftTopView.userInteractionEnabled = false
                leftBtn.addSubview(leftTopView)
                // leftTitleLbl
                let leftTitleLbl = UILabel(frame: CGRectMake(10, 0, leftBtn.viewWidth - 10, 40))
                leftTitleLbl.text = "上班族 - 工薪贷"
                leftTitleLbl.font = UIFont.systemFontOfSize(16)
                leftTitleLbl.textAlignment = .Left
                leftTitleLbl.textColor = UIColor.whiteColor()
                leftTopView.addSubview(leftTitleLbl)
                // leftIv
                let leftIv = UIImageView(frame: CGRectMake(leftBtn.viewWidth / 2 / 2, leftTitleLbl.viewBottomY + 15, leftBtn.viewWidth / 2, leftBtn.viewWidth / 2))
                leftIv.image = UIImage(named: "default_bgimg")
                leftBtn.addSubview(leftIv)
                // leftDetailLbl
                let leftDetailLbl = UILabel(frame: CGRectMake(0, leftIv.viewBottomY + 10, leftBtn.viewWidth, 13))
                leftDetailLbl.font = UIFont.systemFontOfSize(13)
                leftDetailLbl.textColor = UIColor.grayColor()
                leftDetailLbl.textAlignment = .Center
                leftDetailLbl.text = "幸福在眼前--开始享受！"
                leftBtn.addSubview(leftDetailLbl)
                // leftApplyLbl
                let leftApplyLbl = UILabel(frame: CGRectMake((leftBtn.viewWidth - 120) / 2, leftDetailLbl.viewBottomY + 10, 120, 30))
                leftApplyLbl.backgroundColor = UIColor(red:0.14, green:0.31, blue:0.50, alpha:1.00)
                leftApplyLbl.textColor = UIColor.whiteColor()
                leftApplyLbl.textAlignment = .Center
                leftApplyLbl.text = "我要申请"
                leftBtn.addSubview(leftApplyLbl)
                
                // rightBtn
                let rightBtn = UIButton(frame: CGRectMake(leftBtn.viewRightX + 5, 0, (screen_width - 15) / 2, cell.viewHeight - 10))
                rightBtn.layer.masksToBounds = true
                rightBtn.layer.borderWidth = 1
                rightBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
                rightBtn.backgroundColor = UIColor.lightTextColor()
                rightBtn.tag = 2
                rightBtn.addTarget(self, action: #selector(applyBorrowFunc(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(rightBtn)
                // rightTopView
                let rightTopView = UIView(frame: CGRectMake(0, 0, leftBtn.viewWidth, 40))
                rightTopView.backgroundColor = UIColor(red:0.98, green:0.48, blue:0.23, alpha:1.00)
                rightTopView.userInteractionEnabled = false
                rightBtn.addSubview(rightTopView)
                // rightTitleLbl
                let rightTitleLbl = UILabel(frame: CGRectMake(10, 0, rightBtn.viewWidth - 10, 40))
                rightTitleLbl.text = "创业族 - 助业贷"
                rightTitleLbl.font = UIFont.systemFontOfSize(16)
                rightTitleLbl.textAlignment = .Left
                rightTitleLbl.textColor = UIColor.whiteColor()
                rightTopView.addSubview(rightTitleLbl)
                // rightIv
                let rightIv = UIImageView(frame: CGRectMake(rightBtn.viewWidth / 2 / 2, rightTitleLbl.viewBottomY + 15, rightBtn.viewWidth / 2, rightBtn.viewWidth / 2))
                rightIv.image = UIImage(named: "default_bgimg")
                rightBtn.addSubview(rightIv)
                // rightDetailLbl
                let rightDetailLbl = UILabel(frame: CGRectMake(0, rightIv.viewBottomY + 10, rightBtn.viewWidth, 13))
                rightDetailLbl.font = UIFont.systemFontOfSize(13)
                rightDetailLbl.textColor = UIColor.grayColor()
                rightDetailLbl.textAlignment = .Center
                rightDetailLbl.text = "幸福在眼前--开始享受！"
                rightBtn.addSubview(rightDetailLbl)
                // rightApplyLbl
                let rightApplyLbl = UILabel(frame: CGRectMake((rightBtn.viewWidth - 120) / 2, rightDetailLbl.viewBottomY + 10, 120, 30))
                rightApplyLbl.backgroundColor = UIColor(red:0.14, green:0.31, blue:0.50, alpha:1.00)
                rightApplyLbl.textColor = UIColor.whiteColor()
                rightApplyLbl.textAlignment = .Center
                rightApplyLbl.text = "我要申请"
                rightBtn.addSubview(rightApplyLbl)
            }else{
                // leftBtn
                let leftBtn = UIButton(frame: CGRectMake(5, 0, (screen_width - 15) / 2, cell.viewHeight - 10))
                leftBtn.layer.masksToBounds = true
                leftBtn.layer.borderWidth = 1
                leftBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
                leftBtn.backgroundColor = UIColor.lightTextColor()
                leftBtn.tag = 3
                leftBtn.addTarget(self, action: #selector(applyBorrowFunc(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(leftBtn)
                // leftTopView
                let leftTopView = UIView(frame: CGRectMake(0, 0, leftBtn.viewWidth, 40))
                leftTopView.backgroundColor = UIColor(red:0.13, green:0.70, blue:0.73, alpha:1.00)
                leftTopView.userInteractionEnabled = false
                leftBtn.addSubview(leftTopView)
                // leftTitleLbl
                let leftTitleLbl = UILabel(frame: CGRectMake(10, 0, leftBtn.viewWidth - 10, 40))
                leftTitleLbl.text = "有房族 - 物业贷"
                leftTitleLbl.font = UIFont.systemFontOfSize(16)
                leftTitleLbl.textAlignment = .Left
                leftTitleLbl.textColor = UIColor.whiteColor()
                leftTopView.addSubview(leftTitleLbl)
                // leftIv
                let leftIv = UIImageView(frame: CGRectMake(leftBtn.viewWidth / 2 / 2, leftTitleLbl.viewBottomY + 15, leftBtn.viewWidth / 2, leftBtn.viewWidth / 2))
                leftIv.image = UIImage(named: "default_bgimg")
                leftBtn.addSubview(leftIv)
                // leftDetailLbl
                let leftDetailLbl = UILabel(frame: CGRectMake(0, leftIv.viewBottomY + 10, leftBtn.viewWidth, 13))
                leftDetailLbl.font = UIFont.systemFontOfSize(13)
                leftDetailLbl.textColor = UIColor.grayColor()
                leftDetailLbl.textAlignment = .Center
                leftDetailLbl.text = "幸福在眼前--开始享受！"
                leftBtn.addSubview(leftDetailLbl)
                // leftApplyLbl
                let leftApplyLbl = UILabel(frame: CGRectMake((leftBtn.viewWidth - 120) / 2, leftDetailLbl.viewBottomY + 10, 120, 30))
                leftApplyLbl.backgroundColor = UIColor(red:0.14, green:0.31, blue:0.50, alpha:1.00)
                leftApplyLbl.textColor = UIColor.whiteColor()
                leftApplyLbl.textAlignment = .Center
                leftApplyLbl.text = "我要申请"
                leftBtn.addSubview(leftApplyLbl)
                
                // rightBtn
                let rightBtn = UIButton(frame: CGRectMake(leftBtn.viewRightX + 5, 0, (screen_width - 15) / 2, cell.viewHeight - 10))
                rightBtn.layer.masksToBounds = true
                rightBtn.layer.borderWidth = 1
                rightBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
                rightBtn.backgroundColor = UIColor.lightTextColor()
                rightBtn.tag = 4
                rightBtn.addTarget(self, action: #selector(applyBorrowFunc(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(rightBtn)
                // rightTopView
                let rightTopView = UIView(frame: CGRectMake(0, 0, leftBtn.viewWidth, 40))
                rightTopView.backgroundColor = UIColor(red:0.99, green:0.74, blue:0.13, alpha:1.00)
                rightTopView.userInteractionEnabled = false
                rightBtn.addSubview(rightTopView)
                // rightTitleLbl
                let rightTitleLbl = UILabel(frame: CGRectMake(10, 0, rightBtn.viewWidth - 10, 40))
                rightTitleLbl.text = "有车族 - 车主贷"
                rightTitleLbl.font = UIFont.systemFontOfSize(16)
                rightTitleLbl.textAlignment = .Left
                rightTitleLbl.textColor = UIColor.whiteColor()
                rightTopView.addSubview(rightTitleLbl)
                // rightIv
                let rightIv = UIImageView(frame: CGRectMake(rightBtn.viewWidth / 2 / 2, rightTitleLbl.viewBottomY + 15, rightBtn.viewWidth / 2, rightBtn.viewWidth / 2))
                rightIv.image = UIImage(named: "default_bgimg")
                rightBtn.addSubview(rightIv)
                // rightDetailLbl
                let rightDetailLbl = UILabel(frame: CGRectMake(0, rightIv.viewBottomY + 10, rightBtn.viewWidth, 13))
                rightDetailLbl.font = UIFont.systemFontOfSize(13)
                rightDetailLbl.textColor = UIColor.grayColor()
                rightDetailLbl.textAlignment = .Center
                rightDetailLbl.text = "幸福在眼前--开始享受！"
                rightBtn.addSubview(rightDetailLbl)
                // rightApplyLbl
                let rightApplyLbl = UILabel(frame: CGRectMake((rightBtn.viewWidth - 120) / 2, rightDetailLbl.viewBottomY + 10, 120, 30))
                rightApplyLbl.backgroundColor = UIColor(red:0.14, green:0.31, blue:0.50, alpha:1.00)
                rightApplyLbl.textColor = UIColor.whiteColor()
                rightApplyLbl.textAlignment = .Center
                rightApplyLbl.text = "我要申请"
                rightBtn.addSubview(rightApplyLbl)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 40
        case 1:
            if indexPath.row == 0 {
                return 120
            }else{
                return 86
            }
        case 2:
            return 220
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
