//
//  CircleView.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/5.
//  Copyright © 2016年 rain. All rights reserved.
//

import UIKit
import AFImageHelper

public enum UIPageControlMode : Int {
    case Left
    case Center
    case Right
}

public protocol CLCircularPictureDelegate{
    func clickCurrentImage(currentIndex: Int)
}

public class CLCircularPicture: UIView,UIScrollViewDelegate {

    //MARK:定义属性
    //穿件scrollView
    var contentScrollView:UIScrollView!
    //当前图片
    var currentImageView:UIImageView!
    //上一张图片
    var lastImageView:UIImageView!
    //下一张图片
    var nextImageView:UIImageView!
    //页数指示器
    var pageControl:UIPageControl!
    //定时器
    var timer:NSTimer!
    //设置pageControl对齐方式(默认居中)
    public var pageControlMode:UIPageControlMode = .Center
    
    public var delegate: CLCircularPictureDelegate!
    
    var isShowPlaceholder: Bool = false
    
    var imageCount: Int = 0
    
    //MARK:初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience public init(frame: CGRect, imageArray: [String], placeholder: UIImage?){
        self.init(frame: frame)
        if imageArray.count > 0 {
            //获取图片数组
            self.imageArray = imageArray
            imageCount = imageArray.count
            isShowPlaceholder = false
            //默认显示第一张图片
            indexOfCurrentImage = 0;
        }else if placeholder != nil{
            self.placeholder = placeholder
            imageCount = 0
            isShowPlaceholder = true
        }else{
            isShowPlaceholder = false
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:scrollView delegate
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if offset == 0{
            indexOfCurrentImage = getLastImageIndex(indexOfCurrentImage: indexOfCurrentImage)
        }else if offset == screen_width * 2{
            indexOfCurrentImage = getNextImageIndex(indexOfCurrentImage: indexOfCurrentImage)
        }
        //重新布局图片
        setScrollViewOfImage()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPointMake(screen_width, 0), animated: false)
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(contentScrollView)
    }
    
    //手动滚动开始，移除定时器
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeTimer()
    }
    
    //手动滚动结束，添加定时器
    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        addTimer()
    }
    
    //MARK:设置属性
    
    //设置数组
    var imageArray:[String]!{
        //监听图片数组的变化，如果有变化立即刷新轮播图中显示的图片
        willSet(newValue){
            self.imageArray = newValue
        }
        didSet{
            switch(pageControlMode){
            case .Left:
                pageControl.frame = CGRectMake(10, contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20)
            case .Center:
                pageControl.frame = CGRectMake((screen_width - 20 * CGFloat(imageCount)) / 2, contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20)
            case .Right:
                pageControl.frame = CGRectMake(screen_width - 10 - 20 * CGFloat(imageCount), contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20)
            }
            contentScrollView.scrollEnabled = imageCount > 1
            pageControl.numberOfPages = imageCount
            //设置定时器
            if imageCount <= 1{
                removeTimer()
            }
        }
    }
    
    //设置pageControl选中的颜色
    public var currentPageControlColor: UIColor! = UIColor.redColor(){
        willSet(newValue){
            self.currentPageControlColor = newValue
        }
    }
    //设置pageControl未选中的颜色
    public var pageControlTintColor: UIColor! = UIColor.blueColor(){
        willSet(newValue){
            self.pageControlTintColor = newValue
        }
    }
    
    //当前显示图片索引
    public var indexOfCurrentImage: Int!{
        //监听当前显示的第几张图片，来更新分页指示器
        didSet{
            pageControl.currentPage = indexOfCurrentImage
        }
    }
    
    //默认图片
    private var placeholder: UIImage?{
        willSet(newValue){
            self.placeholder = newValue
        }
    }
    
    //设置定时器的时间间隔
    public var TimeInterval: Double = 3.0{
        willSet(newValue){
            self.TimeInterval = newValue
        }
    }
    
    //MARK:自定义方法
    
    //构造scrollView
    public func setUpCircleView(){
        if isShowPlaceholder == false && imageCount <= 0 {
            return
        }
        
        //创建scrollView
        //初始化scrollView
        contentScrollView = UIScrollView(frame: CGRectMake(0, 0, screen_width, self.frame.size.height))
        contentScrollView.contentSize = CGSizeMake(screen_width * 3, 0)
        contentScrollView.scrollEnabled = imageCount > 1
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.pagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(contentScrollView)
        
        //当前页
        currentImageView = UIImageView(frame: CGRectMake(screen_width, 0, screen_width, self.frame.size.height))
        currentImageView.contentMode = UIViewContentMode.ScaleToFill
        currentImageView.clipsToBounds = true
        contentScrollView.addSubview(currentImageView)
        
        //添加点击事件
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapAction(_:)))
        currentImageView.userInteractionEnabled = true
        currentImageView.addGestureRecognizer(imageTap)
        
        //上一页
        lastImageView = UIImageView(frame: CGRectMake(0, 0, screen_width, self.frame.size.height))
        lastImageView.contentMode = UIViewContentMode.ScaleToFill
        lastImageView.clipsToBounds = true
        contentScrollView.addSubview(lastImageView)
        
        //下一页
        nextImageView = UIImageView(frame: CGRectMake(screen_width * 2, 0, screen_width, self.frame.size.height))
        nextImageView.contentMode = UIViewContentMode.ScaleToFill
        nextImageView.clipsToBounds = true
        contentScrollView.addSubview(nextImageView)
        
        //图片显示布局
        setScrollViewOfImage()
        contentScrollView.setContentOffset(CGPointMake(screen_width, 0), animated: false)
        
        //设置分页指示器
        pageControl = UIPageControl()
        switch(pageControlMode){
        case .Left:
            pageControl = UIPageControl(frame: CGRectMake(10, contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20))
        case .Center:
            pageControl = UIPageControl(frame: CGRectMake((screen_width - 20 * CGFloat(imageCount)) / 2, contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20))
        case .Right:
            pageControl = UIPageControl(frame: CGRectMake(screen_width - 10 - 20 * CGFloat(imageCount), contentScrollView.frame.origin.y + contentScrollView.frame.size.height - 30, 20 * CGFloat(imageCount), 20))
        }
        pageControl.numberOfPages = imageCount;
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = pageControlTintColor
        pageControl.currentPageIndicatorTintColor = currentPageControlColor
        pageControl.enabled = true
        self.addSubview(pageControl)
        
        //设置定时器
        if imageCount > 1{
            timer = NSTimer.scheduledTimerWithTimeInterval(TimeInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        }
    }
    
    //设置图片
    private func setScrollViewOfImage(){
        if imageCount > 0 {
            currentImageView.imageFromURL(imageArray[indexOfCurrentImage], placeholder: placeholder ?? UIImage())
            lastImageView.imageFromURL(imageArray[getLastImageIndex(indexOfCurrentImage: indexOfCurrentImage)], placeholder: placeholder ?? UIImage())
            nextImageView.imageFromURL(imageArray[getNextImageIndex(indexOfCurrentImage: indexOfCurrentImage)], placeholder: placeholder ?? UIImage())
        }else{
            currentImageView.imageFromURL("", placeholder: placeholder ?? UIImage())
//            lastImageView.imageFromURL(imageArray[getLastImageIndex(indexOfCurrentImage: indexOfCurrentImage)], placeholder: placeholder ?? UIImage())
//            nextImageView.imageFromURL(imageArray[getNextImageIndex(indexOfCurrentImage: indexOfCurrentImage)], placeholder: placeholder ?? UIImage())
        }
    }
    
    //得到上一张图片的索引
    private func getLastImageIndex(indexOfCurrentImage index: Int) -> Int{
        let tempIndex = index - 1
        if tempIndex == -1{
            return imageCount - 1
        }else{
            return tempIndex
        }
    }
    
    //得到下一张图片的索引
    private func getNextImageIndex(indexOfCurrentImage index: Int) -> Int{
        let tempIndex = index + 1
        return tempIndex < imageCount ? tempIndex : 0
    }
    
    //事件触发方法
    func timerAction(){
        contentScrollView.setContentOffset(CGPointMake(screen_width * 2, 0), animated: true)
    }
    
    //添加定时器
    public func addTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(TimeInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    //取消定时器
    public func removeTimer(){
        timer.invalidate()
    }
    
    //当前页面点击事件
    func imageTapAction(tap: UITapGestureRecognizer){
        if (self.delegate != nil) {
            self.delegate.clickCurrentImage(indexOfCurrentImage)
        }
    }
}
