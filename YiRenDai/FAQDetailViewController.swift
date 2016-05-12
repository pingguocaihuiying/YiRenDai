//
//  FAQDetailViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class FAQDetailViewController: BaseNavigationController {

    //view
    var tableView: UITableView!
    
    //data
    var FAQDetailData = ["什么是宜定盈？","宜定盈通过智能投标、循环出借，帮助用户节约成本，增加资金利用率，从而实现预期年化收益。最低100元起投，封闭期最短1个月，预期年化收益最高可达10.2%以上","什么是宜人贷节节高？","节节高周期灵活、收益理想。用户在加入一个月之后，如不主动提出退出申请，资金将继续进行出借，收益将逐步递增，可以随时免费提现。最低1000元起投，预期年化收益率为6%~10.6%。","什么是宜定盈？","宜定盈通过智能投标、循环出借，帮助用户节约成本，增加资金利用率，从而实现预期年化收益。最低100元起投，封闭期最短1个月，预期年化收益最高可达10.2%以上","什么是宜人贷节节高？","节节高周期灵活、收益理想。用户在加入一个月之后，如不主动提出退出申请，资金将继续进行出借，收益将逐步递增，可以随时免费提现。最低1000元起投，预期年化收益率为6%~10.6%。"]
    var selectIndexPath: NSIndexPath?
    var isExtension = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        view.backgroundColor = UIColor.getColorThird()
        
        initView()
    }
    
    //MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = UIColor.getColorThird()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }

}

extension FAQDetailViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAQDetailData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return UITableViewAutomaticDimension
        }else{
            if selectIndexPath != nil && indexPath.row == selectIndexPath!.row + 1 {
                if isExtension {
                    return UITableViewAutomaticDimension
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FAQDetailTableViewCell.tableViewCellWith(tableView, indexPath: indexPath)
        if indexPath.row % 2 == 0 {
            cell.titleLbl.text = FAQDetailData[indexPath.row]
            if selectIndexPath != nil && indexPath == selectIndexPath {
                if isExtension {
                    cell.stateIv.image = UIImage(named: "pay_success_allow")
                }else{
                    cell.stateIv.image = UIImage(named: "pay_success_allow_down")
                }
            }else{
                cell.stateIv.image = UIImage(named: "pay_success_allow_down")
            }
        }else{
            cell.stateIv.hidden = true
            if selectIndexPath != nil && indexPath.row == selectIndexPath!.row + 1 {
                if isExtension {
                    cell.titleLbl.text = FAQDetailData[indexPath.row]
                }
            }
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
        if indexPath == selectIndexPath {
            isExtension = !isExtension
        }else{
            isExtension = true
        }
        selectIndexPath = indexPath
        tableView.reloadData()
    }

    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}