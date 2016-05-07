//
//  HomePageViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/18.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import CLCycleScrollView
import MJRefresh

class HomePageViewController: BaseViewController, CycleScrollViewDelegate {
    
    let cellIdentifier = "CellIdentifier"
    
    //view
    var tableView: UITableView!
    var cycleScrollView: CycleScrollView!
    
    //data
    var homeData = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, 0, screen_width, screen_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        homeData = []
        //刷新结束
        tableView.mj_header.endRefreshing()
        //刷新数据
        tableView.reloadData()
    }
    
    func clickEvent(target: AnyObject){
        switch target.tag {
        case 1:
            let activityCenterVC = ActivityCenterViewController()
            activityCenterVC.navtitle = "活动中心"
            activityCenterVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(activityCenterVC, animated: true)
        default:
            break
        }
    }
    
    //MARK: - CycleScrollViewDelegate delegate
    func clickCurrentImage(currentIndex: Int) {
        print("点击页索引:\(currentIndex)")
    }

}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        switch indexPath.row {
        case 0:
            let imageArray = [UIImage(named: "image1")!,UIImage(named: "image2")!,UIImage(named: "image3")!,UIImage(named: "image4")!]
            cycleScrollView = CycleScrollView(frame: CGRectMake(0, 0, screen_width, 200), imageArray: imageArray)
            cycleScrollView.delegate = self
            cycleScrollView.currentPageControlColor = UIColor.blackColor()
            cycleScrollView.pageControlTintColor = UIColor.whiteColor()
            cycleScrollView.setUpCircleView()
            cell.addSubview(cycleScrollView)
        case 1:
            //imageBtn1
            let imageBtn1 = CLButton(frame: CGRectMake(0, 20, screen_width / 3, 60))
            imageBtn1.setImage(UIImage(named: "zhanweitu"), forState: .Normal)
            imageBtn1.setTitle("活动中心", forState: .Normal)
            imageBtn1.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn1.tag = 1
            imageBtn1.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.addSubview(imageBtn1)
            
            //lineView1
            let lineView1 = UIView(frame: CGRectMake(screen_width / 3, 0, 0.25, 100))
            lineView1.backgroundColor = UIColor.getColorSecond()
            cell.addSubview(lineView1)
            
            //imageBtn2
            let imageBtn2 = CLButton(frame: CGRectMake(screen_width / 3 + 0.25, 20, screen_width / 3, 60))
            imageBtn2.setImage(UIImage(named: "zhanweitu"), forState: .Normal)
            imageBtn2.setTitle("推荐送现金", forState: .Normal)
            imageBtn2.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn2.tag = 2
            imageBtn2.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.addSubview(imageBtn2)
            
            //lineView2
            let lineView2 = UIView(frame: CGRectMake(screen_width / 3 * 2 + 0.25, 0, 0.25, 100))
            lineView2.backgroundColor = UIColor.getColorSecond()
            cell.addSubview(lineView2)
            
            //imageBtn3
            let imageBtn3 = CLButton(frame: CGRectMake(screen_width / 3 * 2 + 0.5, 20, screen_width / 3, 60))
            imageBtn3.setImage(UIImage(named: "zhanweitu"), forState: .Normal)
            imageBtn3.setTitle("安全保障", forState: .Normal)
            imageBtn3.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn3.tag = 3
            imageBtn3.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.addSubview(imageBtn3)
        case 2:
            //先清空控件
            for itemView in cell.subviews {
                itemView.removeFromSuperview()
            }
            //mIv
            let mIv1 = UIImageView(frame: CGRectMake(0, 0, screen_width, 50))
            mIv1.image = UIImage(named: "home_product_title_no")
            cell.addSubview(mIv1)
            //qtAmount
            let qtAmount = UILabel(frame: CGRectMake(20, 80, 100, 21))
            qtAmount.font = UIFont.systemFontOfSize(20)
            qtAmount.text = "5000"
            cell.addSubview(qtAmount)
            //qtAmountTitle
            let qtAmountTitle = UILabel(frame: CGRectMake(qtAmount.viewX, qtAmount.viewBottomY + 5, 100, 21))
            qtAmountTitle.font = UIFont.systemFontOfSize(14)
            qtAmountTitle.textColor = UIColor.grayColor()
            qtAmountTitle.text = "起投金额"
            cell.addSubview(qtAmountTitle)
            //mIv2
            let mIv2 = UIImageView(frame: CGRectMake((screen_width - screen_width * 0.45) / 2, mIv1.viewBottomY - 24, screen_width * 0.45, screen_width * 0.45))
            mIv2.image = UIImage(named: "home_product_circle")
            cell.addSubview(mIv2)
            //titleLbl1
            let titleLbl1 = UILabel(frame: CGRectMake(0, mIv2.viewHeight * 0.2, mIv2.viewWidth, 14))
            titleLbl1.textAlignment = .Center
            titleLbl1.font = UIFont.systemFontOfSize(14)
            titleLbl1.text = "宜定盈S-18月期"
            mIv2.addSubview(titleLbl1)
            //titleLbl2
            let titleLbl2 = UILabel(frame: CGRectMake(0, titleLbl1.viewBottomY + 7, mIv2.viewWidth, 45))
            titleLbl2.textAlignment = .Center
            titleLbl2.font = UIFont.systemFontOfSize(45)
            titleLbl2.textColor = UIColor.redColor()
            titleLbl2.text = "8.6%"
            mIv2.addSubview(titleLbl2)
            //titleLbl3
            let titleLbl3 = UILabel(frame: CGRectMake(0, titleLbl2.viewBottomY + 9, mIv2.viewWidth, 12))
            titleLbl3.textAlignment = .Center
            titleLbl3.font = UIFont.systemFontOfSize(14)
            titleLbl3.textColor = UIColor.redColor()
            titleLbl3.text = "年化收益"
            mIv2.addSubview(titleLbl3)
            //closeDeadline
            let closeDeadline = UILabel(frame: CGRectMake(screen_width - 20 - 100, 80, 100, 21))
            closeDeadline.font = UIFont.systemFontOfSize(20)
            closeDeadline.textAlignment = .Right
            closeDeadline.text = "18个月"
            cell.addSubview(closeDeadline)
            //closeDeadlineTitle
            let closeDeadlineTitle = UILabel(frame: CGRectMake(closeDeadline.viewX, qtAmount.viewBottomY + 5, 100, 21))
            closeDeadlineTitle.font = UIFont.systemFontOfSize(14)
            closeDeadlineTitle.textColor = UIColor.grayColor()
            closeDeadlineTitle.textAlignment = .Right
            closeDeadlineTitle.text = "封闭期限"
            cell.addSubview(closeDeadlineTitle)
            //ljInvestBtn
            let ljInvestBtn = UIButton(frame: CGRectMake((screen_width - screen_width * 0.6) / 2 , mIv2.viewBottomY + 15, screen_width * 0.6 + 10, 35))
            ljInvestBtn.setBackgroundImage(UIImage(named: "bt_acc_gotobuy_press"), forState: .Normal)
            ljInvestBtn.userInteractionEnabled = false
            ljInvestBtn.setTitle("立即投资", forState: .Normal)
            cell.addSubview(ljInvestBtn)
            let mIv3 = UIImageView(frame: CGRectMake(ljInvestBtn.viewWidth - 70, 0, 70, 35))
            mIv3.image = UIImage(named: "bt_home_normal.9")
            ljInvestBtn.addSubview(mIv3)
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 100
        case 2:
            return 300
        default:
            return 0
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
        if indexPath.row == 2 {
            let ljInvestBtnVC = LjInvestBtnViewController()
            ljInvestBtnVC.navtitle = "宜定盈S-24月期"
            ljInvestBtnVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ljInvestBtnVC, animated: true)
        }
    }
}
