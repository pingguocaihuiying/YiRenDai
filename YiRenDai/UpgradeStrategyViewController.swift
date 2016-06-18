//
//  UpgradeStrategyViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/2.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON

enum UpgradeStrategyType{
    case UpgradeStrategy
    case Youhuiquan
}

class UpgradeStrategyViewController: BaseNavigationController {
    
    let cellIdentifierNib = "CellIdentifierNib"
    
    // view
    var tableView: UITableView!
    var upgradeStrategyType: UpgradeStrategyType!
    
    // data
    var showData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if upgradeStrategyType == .UpgradeStrategy {
            setTopViewTitle("升级攻略")
        }else{
            setTopViewTitle("优惠券使用说明")
        }
        
        setTopViewLeftBtnImg("left")

        initData()
    }
    
    // 自定义方法
    func initData(){
        if upgradeStrategyType == .UpgradeStrategy {
            let item1 = JSON(dictionaryLiteral: ("title", "问：什么是优惠券"), ("detail", "答：优惠券是宜人贷平台通过买赠"))
            showData.append(item1)
            let item2 = JSON(dictionaryLiteral: ("title", "问：会员等级有哪些"), ("detail", "答：会员等级从V0到V21，除注册会员外每三个等级对应一个称号。会员称号包括注册会员、理财童生、理财秀才、理财举人、理财贡士、理财进士、理财探花、理财榜眼等。会员等级由用户的财富值决定。"))
            showData.append(item2)
        }else{
            let item1 = JSON(dictionaryLiteral: ("title", "问：如何成为会员"), ("detail", "答：成功注册，即可开启会员升级之路。成为注册会员V0后，购买新手专享产品或其他产品，即可从注册会员V0成功升级为理财童生V1等级"))
            showData.append(item1)
            let item2 = JSON(dictionaryLiteral: ("title", "问：会员等级有哪些"), ("detail", "答：会员等级从V0到V21，除注册会员外每三个等级对应一个称号。会员称号包括注册会员、理财童生、理财秀才、理财举人、理财贡士、理财进士、理财探花、理财榜眼等。会员等级由用户的财富值决定。"))
            showData.append(item2)
        }
        initView()
    }
    
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: "UpgradeStrategyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierNib)
        view.addSubview(tableView)
    }

}

extension UpgradeStrategyViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierNib, forIndexPath: indexPath) as! UpgradeStrategyTableViewCell
        cell.titleLbl.text = showData[indexPath.row]["title"].stringValue
        cell.detailLbl.text = showData[indexPath.row]["detail"].stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
