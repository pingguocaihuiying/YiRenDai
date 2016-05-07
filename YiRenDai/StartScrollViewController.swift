//
//  StartScrollViewController.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/8.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit

class StartScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var imageArray:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:自定义方法
    private func initView(){
        imageArray = ["index1","index2","index3"]
        scrollView = UIScrollView(frame: CGRectMake(0, 0, screen_width, screen_height))
        scrollView.contentSize = CGSize(width: screen_width * CGFloat(imageArray.count), height: screen_height)
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        for i in 0 ..< imageArray.count{
            let imageView = UIImageView(frame: CGRectMake(screen_width * CGFloat(i), 0, screen_width, screen_height))
            imageView.image = UIImage(named: imageArray[i])
            scrollView.addSubview(imageView)
        }
        pageControl = UIPageControl(frame: CGRectMake((screen_width - 20 * CGFloat(imageArray.count)) / 2, screen_height - 30, 20 * CGFloat(imageArray.count), 20))
        pageControl.numberOfPages = imageArray.count
        view.addSubview(pageControl)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageIndex = fabs(scrollView.contentOffset.x) / screen_width
        pageControl.currentPage = Int(pageIndex)
        if scrollView.contentOffset.x > (screen_width * CGFloat(imageArray.count - 1) + 50){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "NoFirstLaunch")
            let customeTabBarVC = CustomTabBarViewController()
            customeTabBarVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            presentViewController(customeTabBarVC, animated: true, completion: nil)
        }
    }
}
