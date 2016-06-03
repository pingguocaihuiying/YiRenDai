//
//  IntroductionsViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/1.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class IntroductionsViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("借款说明")
        setTopViewLeftBtnImg("left")

        initView()
    }

    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }

}

extension IntroductionsViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 125
        }else if indexPath.row == 1{
            return 105
        }else{
            return 90
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        for itemView in cell.contentView.subviews {
            itemView.removeFromSuperview()
        }
        if indexPath.row == 0 {
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(20, 15, 200, 20))
            titleLbl.text = "申请条件:"
            cell.contentView.addSubview(titleLbl)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(22, titleLbl.viewBottomY, screen_width, 80))
            detailLbl.numberOfLines = 0
            detailLbl.font = UIFont.systemFontOfSize(15)
            detailLbl.textColor = UIColor.grayColor()
            detailLbl.text = "中国大陆居民（不含港澳台）\n22-60周岁\n实体店经营1年以上，网店经营3年以上\n月均营业收入大于1万元"
            cell.contentView.addSubview(detailLbl)
        }else if indexPath.row == 1{
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(20, 15, 200, 20))
            titleLbl.text = "申请资料:"
            cell.contentView.addSubview(titleLbl)
            // detailLbl
            let detailLbl = UILabel(frame: CGRectMake(22, titleLbl.viewBottomY, screen_width, 60))
            detailLbl.numberOfLines = 0
            detailLbl.font = UIFont.systemFontOfSize(15)
            detailLbl.textColor = UIColor.grayColor()
            detailLbl.text = "有效身份证明\n微信授权证明\n企业经营证明及收入证明"
            cell.contentView.addSubview(detailLbl)
        }else{
            // titleLbl
            let titleLbl = UILabel(frame: CGRectMake(20, 15, 200, 20))
            titleLbl.text = "借款流程:"
            cell.contentView.addSubview(titleLbl)
            // onlineApplyIv
            let onlineApplyIv = UIImageView(frame: CGRectMake(15, titleLbl.viewBottomY + 15, 20, 20))
            onlineApplyIv.image = UIImage(named: "zaixianshenqing")
            cell.contentView.addSubview(onlineApplyIv)
            // onlineApplyLbl
            let onlineApplyLbl = UILabel(frame: CGRectMake(onlineApplyIv.viewRightX + 2, onlineApplyIv.viewY, 50, 20))
            onlineApplyLbl.textColor = UIColor(red:0.31, green:0.43, blue:0.57, alpha:1.00)
            onlineApplyLbl.textAlignment = .Left
            onlineApplyLbl.font = UIFont.systemFontOfSize(12)
            onlineApplyLbl.text = "在线申请"
            cell.contentView.addSubview(onlineApplyLbl)
            // arrowFirstIv1
            let arrowFirstIv1 = UIImageView(frame: CGRectMake(onlineApplyLbl.viewRightX + 2, onlineApplyIv.viewY + (20 - 10) / 2, 20, 10))
            arrowFirstIv1.image = UIImage(named: "jiantou")
            cell.contentView.addSubview(arrowFirstIv1)
            // goutongIv
            let goutongIv = UIImageView(frame: CGRectMake(arrowFirstIv1.viewRightX + 5, onlineApplyIv.viewY, 20, 20))
            goutongIv.image = UIImage(named: "goutong")
            cell.contentView.addSubview(goutongIv)
            // goutongLbl
            let goutongLbl = UILabel(frame: CGRectMake(goutongIv.viewRightX + 2, onlineApplyIv.viewY, 75, 20))
            goutongLbl.textColor = UIColor(red:0.31, green:0.43, blue:0.57, alpha:1.00)
            goutongLbl.textAlignment = .Left
            goutongLbl.font = UIFont.systemFontOfSize(12)
            goutongLbl.text = "信贷经理沟通"
            cell.contentView.addSubview(goutongLbl)
            // arrowFirstIv2
            let arrowFirstIv2 = UIImageView(frame: CGRectMake(goutongLbl.viewRightX + 2, onlineApplyIv.viewY + (20 - 10) / 2, 20, 10))
            arrowFirstIv2.image = UIImage(named: "jiantou")
            cell.contentView.addSubview(arrowFirstIv2)
            // applyIv
            let applyIv = UIImageView(frame: CGRectMake(arrowFirstIv2.viewRightX + 5, onlineApplyIv.viewY, 20, 20))
            applyIv.image = UIImage(named: "zaixianshenqing")
            cell.contentView.addSubview(applyIv)
            // onlineApplyLbl
            let applyLbl = UILabel(frame: CGRectMake(applyIv.viewRightX + 2, onlineApplyIv.viewY, 80, 20))
            applyLbl.textColor = UIColor(red:0.31, green:0.43, blue:0.57, alpha:1.00)
            applyLbl.textAlignment = .Left
            applyLbl.font = UIFont.systemFontOfSize(12)
            applyLbl.text = "在线申请"
            cell.contentView.addSubview(applyLbl)
        }
        return cell
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}