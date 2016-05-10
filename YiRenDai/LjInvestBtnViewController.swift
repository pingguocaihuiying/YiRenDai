//
//  LjInvestBtnViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/25.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class LjInvestBtnViewController: BaseNavigationController {

    var productID: String!
    
    //view
    var tableView: UITableView!
    var reduceBtn: UIButton!
    var addBtn: UIButton!
    var amountNumTxt: UITextField!
    
    //data
    var productData: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopViewLeftBtnImg("left")
        setTopViewRightBtnImg("home_share_click")
        
        initView()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.getColorThird()
        let footerView = UIView(frame: CGRectMake(0, 0, screen_width, 50))
        let ljBuyBtn = UIButton(frame: CGRectMake(14, 15, screen_width - 14 * 2, 46))
        ljBuyBtn.setTitle("立即购买", forState: .Normal)
        ljBuyBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ljBuyBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
        footerView.addSubview(ljBuyBtn)
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
        tableView.mj_header.beginRefreshing()
    }
    
    func refreshData(){
        DataProvider.sharedInstance.getProductDetail(productID) { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.productData = data["data"]["productlist"][0]
                //刷新结束
                self.tableView.mj_header.endRefreshing()
                //刷新数据
                self.tableView.reloadData()
            }else{
                self.view.viewAlert(self, title: "提示", msg: data["status"]["message"].stringValue, cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            }
        }
        return
    }
    
    func clickEvent(target: AnyObject) {
        let minAmount = productData!["min_amount"].intValue
        let maxAmount = productData!["max_amount"].intValue
        switch target.tag {
        case 1:
            if amountNumTxt.text == "\(minAmount)" {
                return
            }else if amountNumTxt.text == "\(minAmount + 1000)" {
                reduceBtn.setImage(UIImage(named: "product_rb_minus_disabled"), forState: .Normal)
                amountNumTxt.text = "\(Int(amountNumTxt.text!)! - 1000)"
            }else{
                amountNumTxt.text = "\(Int(amountNumTxt.text!)! - 1000)"
                reduceBtn.setImage(UIImage(named: "product_rb_minus_normal"), forState: .Normal)
                addBtn.setImage(UIImage(named: "product_rb_plus_normal"), forState: .Normal)
            }
        case 2:
            if amountNumTxt.text == "\(maxAmount)" {
                return
            }else if Int(amountNumTxt.text!)! >= minAmount && Int(amountNumTxt.text!)! < maxAmount - 1000 {
                reduceBtn.setImage(UIImage(named: "product_rb_minus_normal"), forState: .Normal)
                addBtn.setImage(UIImage(named: "product_rb_plus_normal"), forState: .Normal)
                amountNumTxt.text = "\(Int(amountNumTxt.text!)! + 1000)"
            }else{
                addBtn.setImage(UIImage(named: "product_rb_plus_disabled"), forState: .Normal)
                amountNumTxt.text = "\(Int(amountNumTxt.text!)! + 1000)"
            }
        default:
            break
        }
    }

}

//MARK: - extension
extension LjInvestBtnViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData == nil ? 0 : 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRectMake(0, 0, screen_width, 0))
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.row == 0 {
            //topBgIv
            let topBgIv = UIImageView(frame: CGRectMake(0, 0, screen_width, 70))
            topBgIv.image = UIImage(named: "bg_product_details_shield")
            cell.addSubview(topBgIv)
            //detailLbl1
            let detailLbl1 = UILabel(frame: CGRectMake(14, (70 - 45) / 2, 70, 45))
            detailLbl1.textAlignment = .Center
            detailLbl1.textColor = UIColor.whiteColor()
            detailLbl1.font = UIFont.systemFontOfSize(45)
            detailLbl1.text = productData!["interest_rate"].stringValue
            cell.addSubview(detailLbl1)
            //detailLbl2
            let detailLbl2 = UILabel(frame: CGRectMake(detailLbl1.viewRightX + 1, detailLbl1.viewY + 5, 120, 12))
            detailLbl2.text = "预期年化收益"
            detailLbl2.textColor = UIColor.whiteColor()
            detailLbl2.font = UIFont.systemFontOfSize(12)
            cell.addSubview(detailLbl2)
            //detailLbl2
            let detailLbl3 = UILabel(frame: CGRectMake(detailLbl2.viewX, detailLbl2.viewY + 15, 20, 20))
            detailLbl3.text = "%"
            detailLbl3.textColor = UIColor(red:0.99, green:0.70, blue:0.65, alpha:1.00)
            detailLbl3.font = UIFont.systemFontOfSize(20)
            cell.addSubview(detailLbl3)
            let view = UIView(frame: CGRectMake(0, 70, screen_width, 40))
            view.backgroundColor = UIColor(red:0.95, green:0.27, blue:0.25, alpha:1.00)
            cell.addSubview(view)
            //detailLbl4
            let detailLbl4 = UILabel(frame: CGRectMake(20, 0, 200, 40))
            detailLbl4.textColor = UIColor.whiteColor()
            detailLbl4.textAlignment = .Left
            detailLbl4.font = UIFont.systemFontOfSize(14)
            detailLbl4.text = "\(productData!["duration_type"].stringValue)封闭期"
            view.addSubview(detailLbl4)
            //detailLbl5
            let detailLbl5 = UILabel(frame: CGRectMake(screen_width - 14 - 100, 0, 100, 40))
            detailLbl5.textColor = UIColor.whiteColor()
            detailLbl5.textAlignment = .Right
            detailLbl5.font = UIFont.systemFontOfSize(14)
            detailLbl5.text = "\(productData!["min_amount"].stringValue)元起投"
            view.addSubview(detailLbl5)
            
        }else if indexPath.row == 1{
            //detailLbl1
            let detailLbl1 = UILabel(frame: CGRectMake(14, 0, 100, 50))
            detailLbl1.textColor = UIColor.grayColor()
            detailLbl1.textAlignment = .Left
            detailLbl1.font = UIFont.systemFontOfSize(14)
            detailLbl1.text = "产品详情"
            cell.addSubview(detailLbl1)
            //detailLbl2
            let detailLbl2 = UILabel(frame: CGRectMake(screen_width - 14 - 200, 0, 200, 50))
            detailLbl2.textColor = UIColor.lightGrayColor()
            detailLbl2.textAlignment = .Right
            detailLbl2.font = UIFont.systemFontOfSize(14)
            detailLbl2.text = "单笔最高可投\(productData!["min_amount"].intValue / 10000)万元"
            cell.addSubview(detailLbl2)
        }else if indexPath.row == 2{
            //detailLbl1
            let detailLbl1 = UILabel(frame: CGRectMake(14, 0, 100, 50))
            detailLbl1.textColor = UIColor.grayColor()
            detailLbl1.textAlignment = .Left
            detailLbl1.font = UIFont.systemFontOfSize(14)
            detailLbl1.text = "安全保障"
            cell.addSubview(detailLbl1)
            //detailLbl2
            let detailLbl2 = UILabel(frame: CGRectMake(screen_width - 14 - 200, 0, 200, 50))
            detailLbl2.textColor = UIColor.lightGrayColor()
            detailLbl2.textAlignment = .Right
            detailLbl2.font = UIFont.systemFontOfSize(14)
            detailLbl2.text = "分现金保障"
            cell.addSubview(detailLbl2)
        }else if indexPath.row == 3{
            cell.backgroundColor = UIColor.getColorThird()
        }else{
            //view1
            let view1 = UIView(frame: CGRectMake(0, 0, screen_width, 70))
            cell.addSubview(view1)
            //detail1
            let detail1 = UILabel(frame: CGRectMake(20, 20, 120, 14))
            detail1.font = UIFont.systemFontOfSize(14)
            detail1.textColor = UIColor.lightGrayColor()
            detail1.text = "剩余可投(元)"
            view1.addSubview(detail1)
            //detail2
            let detail2 = UILabel(frame: CGRectMake(20, detail1.viewBottomY + 10, 120, 14))
            detail2.font = UIFont.systemFontOfSize(14)
            detail2.textColor = UIColor.grayColor()
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            detail2.text = "\(formatter.stringFromNumber(productData!["remaining_amount"].intValue)!)元"
            view1.addSubview(detail2)
            //lineView
            let lineView = UIView(frame: CGRectMake(screen_width / 2, 15, 0.5, 70 - 30))
            lineView.backgroundColor = UIColor.lightGrayColor()
            view1.addSubview(lineView)
            //detail3
            let detail3 = UILabel(frame: CGRectMake(screen_width - 100 - 20, detail1.viewY, 100, 14))
            detail3.font = UIFont.systemFontOfSize(14)
            detail3.textColor = UIColor.lightGrayColor()
            detail3.textAlignment = .Right
            detail3.text = "预计收益(元)"
            view1.addSubview(detail3)
            //detail4
            let detail4 = UILabel(frame: CGRectMake(screen_width - 100 - 20, detail2.viewY, 100, 14))
            detail4.font = UIFont.systemFontOfSize(14)
            detail4.textColor = UIColor.lightGrayColor()
            detail4.textAlignment = .Right
            detail4.textColor = UIColor.getColorFourth()
            detail4.text = NSString(format: "%.2f", productData!["min_amount"].floatValue * productData!["interest_rate"].floatValue / 100 / 12) as String
            view1.addSubview(detail4)
            
            //view2
            let view2 = UIView(frame: CGRectMake(40, view1.viewBottomY + 5, screen_width - 80, 35))
            cell.addSubview(view2)
            //减Btn
            reduceBtn = UIButton(frame: CGRectMake(0, 0, 35, 35))
            reduceBtn.tag = 1
            reduceBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
            reduceBtn.setImage(UIImage(named: "product_rb_minus_disabled"), forState: .Normal)
            view2.addSubview(reduceBtn)
            //amountNum
            amountNumTxt = UITextField(frame: CGRectMake((view2.viewWidth - 150) / 2, 0, 150, 35))
            amountNumTxt.font = UIFont.systemFontOfSize(20)
            amountNumTxt.textAlignment = .Center
            amountNumTxt.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            amountNumTxt.layer.borderWidth = 1
            amountNumTxt.layer.borderColor = UIColor.getColorThird().CGColor
            amountNumTxt.text = "\(productData!["min_amount"].stringValue)"
            view2.addSubview(amountNumTxt)
            //加Btn
            addBtn = UIButton(frame: CGRectMake(view2.viewWidth - 35, 0, 35, 35))
            addBtn.tag = 2
            addBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
            addBtn.setImage(UIImage(named: "product_rb_plus_normal"), forState: .Normal)
            view2.addSubview(addBtn)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 110
        }else if indexPath.row == 1 || indexPath.row == 2{
            return 50
        }else if indexPath.row == 3{
            return 20
        }else{
            return 140;
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
    
}
