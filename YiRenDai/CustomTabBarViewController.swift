//
//  CustomTabBarViewController.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/4.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initTabBarItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setDefaultSelectTabBarItem(_:)), name: "setDefaultSelectTabBarItem", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        //控件加载前进行处理
    }
    
    func initTabBarItem(){
        //第一个tabbar面板
        let homePageVC = HomePageViewController()
        homePageVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        homePageVC.tabBarItem.image = UIImage(named: "huiseshouye")
        homePageVC.tabBarItem.selectedImage = UIImage(named: "hongseshouye")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let navHomePageVC = UINavigationController(rootViewController: homePageVC)
        navHomePageVC.navigationBar.hidden = true
        if (homePageVC.navigationController!.navigationBar.translucent) {
            homePageVC.automaticallyAdjustsScrollViewInsets = false;
        }
        
        //第二个tabbar面板
        let productListVC = ProductListViewController()
        productListVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        productListVC.tabBarItem.image = UIImage(named: "huisewoyaotouzi")
        productListVC.tabBarItem.selectedImage = UIImage(named: "hongsewoyaotouzi")
        let navProductListVC = UINavigationController(rootViewController: productListVC)
        navProductListVC.navigationBar.hidden = true
        if (productListVC.navigationController!.navigationBar.translucent) {
            productListVC.automaticallyAdjustsScrollViewInsets = false;
        }
        
        //第三个tabbar面板
        //我的财富
        let myWealthVC = MyWealthViewController()
        myWealthVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        myWealthVC.tabBarItem.image = UIImage(named: "huisewodecaifu")
        myWealthVC.tabBarItem.selectedImage = UIImage(named: "hongsewodecaifu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let navMyWealthVC = UINavigationController(rootViewController: myWealthVC)
        navMyWealthVC.navigationBar.hidden = true
        if (myWealthVC.navigationController!.navigationBar.translucent) {
            myWealthVC.automaticallyAdjustsScrollViewInsets = false;
        }
        //登陆界面
        let loginVC = LoginViewController()
        loginVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        loginVC.tabBarItem.image = UIImage(named: "huisewodecaifu")
        loginVC.tabBarItem.selectedImage = UIImage(named: "hongsewodecaifu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let navLoginVC = UINavigationController(rootViewController: loginVC)
        navLoginVC.navigationBar.hidden = true
        loginVC.targetNav = navLoginVC
        if (loginVC.navigationController!.navigationBar.translucent) {
            loginVC.automaticallyAdjustsScrollViewInsets = false;
        }
        
        //第四个tabbar面板
        let iBorrowVC = IBorrowViewController()
        iBorrowVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        iBorrowVC.tabBarItem.image = UIImage(named: "huisewoyaojiekuan")
        iBorrowVC.tabBarItem.selectedImage = UIImage(named: "hongsewoyaojiekuan")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let navIBorrowVC = UINavigationController(rootViewController: iBorrowVC)
        navIBorrowVC.navigationBar.hidden = true
        if (iBorrowVC.navigationController!.navigationBar.translucent) {
            iBorrowVC.automaticallyAdjustsScrollViewInsets = false;
        }
        
        //第五个tabbar面板
        let moreVC = MoreViewController()
        moreVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0)
        moreVC.tabBarItem.image = UIImage(named: "huisegengduo")
        moreVC.tabBarItem.selectedImage = UIImage(named: "hongsegengduo")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let navMoreVC = UINavigationController(rootViewController: moreVC)
        navMoreVC.navigationBar.hidden = true
        if (moreVC.navigationController!.navigationBar.translucent) {
            moreVC.automaticallyAdjustsScrollViewInsets = false;
        }
        
        //将view添加到tabbar
        let isLogin = ToolKit.isLogin()
        self.viewControllers = [navHomePageVC, navProductListVC, isLogin ? navMyWealthVC : navLoginVC, navIBorrowVC, navMoreVC]
        
        //设置tabbar的选中时颜色
        UITabBar.appearance().tintColor = UIColor(red:0.99, green:0.33, blue:0.04, alpha:1)
    }
    
    func setDefaultSelectTabBarItem(sender: AnyObject){
        let index = (sender.userInfo)["index"] as! Int
        self.selectedIndex = index
    }

}
