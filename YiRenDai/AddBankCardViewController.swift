//
//  AddBankCardViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/13.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class AddBankCardViewController: n {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        initView()
    }
    
    // MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        view.addSubview(tableView)
    }

}
