//
//  HomePageViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/18.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import CLCircularPicture
import MJRefresh
import SwiftyJSON

class HomePageViewController: BaseViewController, CLCircularPictureDelegate {
    
    let cellIdentifier = "CellIdentifier"
    
    //view
    var tableView: UITableView!
    var cycleScrollView: CLCircularPicture!
    
    //data
    var homeData: JSON?
    var cycleImage: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, 0, screen_width, screen_height - tabBar_height))
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
        initCycleScrollView()
        homeData = []
        //刷新结束
        tableView.mj_header.endRefreshing()
        //刷新数据
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0), NSIndexPath(forRow: 2, inSection: 0),NSIndexPath(forRow: 3, inSection: 0) ,NSIndexPath(forRow: 4, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    func initCycleScrollView(){
        DataProvider.sharedInstance.getSlide("1") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.cycleImage = data["data"]["slidelist"]
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
            }else{
                LoadingAnimation.showError(self, msg: nil)
            }
        }
    }
    
    func clickEvent(target: UIButton){
        switch target.tag {
        case 1:
            let activityCenterVC = ActivityCenterViewController()
            activityCenterVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(activityCenterVC, animated: true)
        case 3:
            let saveSecurityVC = SaveSecurityViewController()
            saveSecurityVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(saveSecurityVC, animated: true)
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //先清空控件
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        switch indexPath.row {
        case 0:
            var imageArray = [String]()
            if cycleImage != nil && cycleImage?.count > 0 {
                for i in 0 ..< cycleImage!.count{
                    imageArray.append(cycleImage![i]["slide_img"].stringValue)
                }
            }
            cycleScrollView = CLCircularPicture(frame: CGRectMake(0, 0, screen_width, 200), imageArray: imageArray, placeholder: UIImage(named: "default_bgimg"))
            cycleScrollView.delegate = self
            cycleScrollView.currentPageControlColor = UIColor.blackColor()
            cycleScrollView.pageControlTintColor = UIColor.whiteColor()
            cycleScrollView.setUpCircleView()
            cell.contentView.addSubview(cycleScrollView)
        case 1:
            //imageBtn1
            let imageBtn1 = CLButton(frame: CGRectMake(0, 20, screen_width / 3, 60))
            imageBtn1.setImage(UIImage(named: "huodongzhongxin"), forState: .Normal)
            imageBtn1.setTitle("活动中心", forState: .Normal)
            imageBtn1.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn1.tag = 1
            imageBtn1.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(imageBtn1)
            
            //lineView1
            let lineView1 = UIView(frame: CGRectMake(screen_width / 3, 0, 0.25, 100))
            lineView1.backgroundColor = UIColor.getGrayColorFirst()
            cell.contentView.addSubview(lineView1)
            
            //imageBtn2
            let imageBtn2 = CLButton(frame: CGRectMake(screen_width / 3 + 0.25, 20, screen_width / 3, 60))
            imageBtn2.setImage(UIImage(named: "tuisongxianjin"), forState: .Normal)
            imageBtn2.setTitle("推荐送现金", forState: .Normal)
            imageBtn2.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn2.tag = 2
            imageBtn2.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(imageBtn2)
            
            //lineView2
            let lineView2 = UIView(frame: CGRectMake(screen_width / 3 * 2 + 0.25, 0, 0.25, 100))
            lineView2.backgroundColor = UIColor.getGrayColorFirst()
            cell.contentView.addSubview(lineView2)
            
            //imageBtn3
            let imageBtn3 = CLButton(frame: CGRectMake(screen_width / 3 * 2 + 0.5, 20, screen_width / 3, 60))
            imageBtn3.setImage(UIImage(named: "anquanbaozhang"), forState: .Normal)
            imageBtn3.setTitle("安全保障", forState: .Normal)
            imageBtn3.setTitleColor(UIColor.grayColor(), forState: .Normal)
            imageBtn3.tag = 3
            imageBtn3.addTarget(self, action: #selector(clickEvent), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(imageBtn3)
        case 2:
            cell.backgroundColor = UIColor.getGrayColorThird()
            break
        case 3:
            // leftView
            let leftView = UIView(frame: CGRectMake(0, 0, (screen_width - 0.5) / 2, cell.viewHeight))
            cell.contentView.addSubview(leftView)
            // leftDetailTitleLbl
            let leftDetailTitleLbl = UILabel(frame: CGRectMake(0, 10, leftView.viewWidth, 21))
            leftDetailTitleLbl.text = "累计成交金额(元)"
            leftDetailTitleLbl.textColor = UIColor.grayColor()
            leftDetailTitleLbl.textAlignment = .Center
            leftDetailTitleLbl.font = UIFont.systemFontOfSize(16)
            leftView.addSubview(leftDetailTitleLbl)
            // leftDetailLbl
            let leftDetailLbl = UILabel(frame: CGRectMake(0, leftDetailTitleLbl.viewBottomY + 5, leftView.viewWidth, 21))
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            leftDetailLbl.text = formatter.stringFromNumber(1234567890)
            leftDetailLbl.textColor = UIColor.getRedColorSecond()
            leftDetailLbl.textAlignment = .Center
            leftDetailLbl.font = UIFont.systemFontOfSize(19)
            leftView.addSubview(leftDetailLbl)
            // lineView
            let lineView = UIView(frame: CGRectMake(leftView.viewRightX, 10, 0.5, cell.viewHeight - 20))
            lineView.backgroundColor = UIColor.getGrayColorSecond()
            cell.contentView.addSubview(lineView)
            
            // rightView
            let rightView = UIView(frame: CGRectMake(lineView.viewRightX, 0, (screen_width - 0.5) / 2, cell.viewHeight))
            cell.contentView.addSubview(rightView)
            // rightDetailTitleLbl
            let rightDetailTitleLbl = UILabel(frame: CGRectMake(0, 10, leftView.viewWidth, 21))
            rightDetailTitleLbl.text = "累计投资人数(人)"
            rightDetailTitleLbl.textColor = UIColor.grayColor()
            rightDetailTitleLbl.textAlignment = .Center
            rightDetailTitleLbl.font = UIFont.systemFontOfSize(16)
            rightView.addSubview(rightDetailTitleLbl)
            // leftDetailLbl
            let rightDetailLbl = UILabel(frame: CGRectMake(0, rightDetailTitleLbl.viewBottomY + 5, leftView.viewWidth, 21))
            rightDetailLbl.text = formatter.stringFromNumber(1234567890)
            rightDetailLbl.textColor = UIColor.getRedColorSecond()
            rightDetailLbl.textAlignment = .Center
            rightDetailLbl.font = UIFont.systemFontOfSize(19)
            rightView.addSubview(rightDetailLbl)
        case 4:
            // leftView
            let leftView = UIView(frame: CGRectMake(10, 20 + (screen_width * 0.45 - screen_width * 0.45 * 0.75) / 2, screen_width * 0.45 * 0.75, screen_width * 0.45 * 0.75))
            leftView.layer.masksToBounds = true
            leftView.layer.cornerRadius = leftView.viewWidth / 2
            leftView.layer.borderWidth = 1
            leftView.layer.borderColor = UIColor.getRedColorSecond().CGColor
            cell.contentView.addSubview(leftView)
            // leftDetailLbl1
            let leftDetailLbl1 = UILabel(frame: CGRectMake(0, leftView.viewHeight / 2 - 21, leftView.viewWidth, 21))
            leftDetailLbl1.text = "20%"
            leftDetailLbl1.font = UIFont.systemFontOfSize(20)
            leftDetailLbl1.textAlignment = .Center
            leftDetailLbl1.textColor = UIColor.getRedColorSecond()
            leftView.addSubview(leftDetailLbl1)
            // leftDetailLbl2
            let leftDetailLbl2 = UILabel(frame: CGRectMake(0, leftDetailLbl1.viewBottomY + 5, leftView.viewWidth, 21))
            leftDetailLbl2.text = "500元起投"
            leftDetailLbl2.font = UIFont.systemFontOfSize(14)
            leftDetailLbl2.textAlignment = .Center
            leftDetailLbl2.textColor = UIColor.getRedColorSecond()
            leftView.addSubview(leftDetailLbl2)
            // rightView
            let rightView = UIView(frame: CGRectMake(screen_width - 10 - screen_width * 0.45 * 0.75, 20 + (screen_width * 0.45 - screen_width * 0.45 * 0.75) / 2, screen_width * 0.45 * 0.75, screen_width * 0.45 * 0.75))
            rightView.layer.masksToBounds = true
            rightView.layer.cornerRadius = leftView.viewWidth / 2
            rightView.layer.borderWidth = 1
            rightView.layer.borderColor = UIColor.getRedColorSecond().CGColor
            cell.contentView.addSubview(rightView)
            // rightDetailLbl1
            let rightDetailLbl1 = UILabel(frame: CGRectMake(0, leftView.viewHeight / 2 - 21, leftView.viewWidth, 21))
            rightDetailLbl1.text = "15%"
            rightDetailLbl1.font = UIFont.systemFontOfSize(20)
            rightDetailLbl1.textAlignment = .Center
            rightDetailLbl1.textColor = UIColor.getRedColorSecond()
            rightView.addSubview(rightDetailLbl1)
            // rightDetailLbl2
            let rightDetailLbl2 = UILabel(frame: CGRectMake(0, leftDetailLbl1.viewBottomY + 5, leftView.viewWidth, 21))
            rightDetailLbl2.text = "已售罄"
            rightDetailLbl2.font = UIFont.systemFontOfSize(16)
            rightDetailLbl2.textAlignment = .Center
            rightDetailLbl2.textColor = UIColor.getGrayColorFirst()
            rightView.addSubview(rightDetailLbl2)
            // centerBtn
            let centerBtn = UIButton(frame: CGRectMake(screen_width * 0.55 / 2, 20, screen_width * 0.45, screen_width * 0.45))
            centerBtn.setImage(UIImage(named: "hongyuan"), forState: .Normal)
            cell.contentView.addSubview(centerBtn)
            // centerDetail1
            let centerDetail1 = UILabel(frame: CGRectMake(0, 30, centerBtn.viewWidth, 21))
            centerDetail1.textAlignment = .Center
            centerDetail1.text = "预期年化"
            centerDetail1.font = UIFont.systemFontOfSize(16)
            centerDetail1.textColor = UIColor.grayColor()
            centerBtn.addSubview(centerDetail1)
            // centerDetail2
            let centerDetail2 = UILabel(frame: CGRectMake(0, (centerBtn.viewHeight - 21) / 2, centerBtn.viewWidth, 21))
            centerDetail2.textAlignment = .Center
            let str = NSMutableAttributedString(string: "20%")
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(30), range: NSMakeRange(0, str.length - 1))
            str.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: NSMakeRange(str.length - 1, 1))
            centerDetail2.attributedText = str
            centerDetail2.textColor = UIColor.getRedColorFirst()
            centerBtn.addSubview(centerDetail2)
            // centerDetail3
            let centerDetail3 = UILabel(frame: CGRectMake(0, centerDetail2.viewBottomY + 10, centerBtn.viewWidth, 21))
            centerDetail3.textAlignment = .Center
            centerDetail3.text = "500元起投100天"
            centerDetail3.font = UIFont.systemFontOfSize(14)
            centerDetail3.textColor = UIColor.grayColor()
            centerBtn.addSubview(centerDetail3)
            // bottomDetail
            let bottomDetail = UILabel(frame: CGRectMake(0, centerBtn.viewBottomY + 5, screen_width, 21))
            bottomDetail.textAlignment = .Center
            bottomDetail.text = "房利宝"
            cell.contentView.addSubview(bottomDetail)
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
            return 15
        case 3:
            return 70
        case 4:
            return 110 * 2
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
