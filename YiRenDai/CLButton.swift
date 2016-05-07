//
//  ImageBtn.swift
//  YiRenDai
//
//  Created by Rain on 16/4/18.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class CLButton: UIButton {
    
    private let imageRatio :CGFloat = 0.7  // 图片占整个按钮高度的比例
    private let titleRatio:CGFloat = 13   // 设置按钮标题字体默认的大小
    
    //MARK:初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    init(frame: CGRect, imageName: String, title: String, detail: String){
        super.init(frame: frame)
        //mImageView
        let mImageView = UIImageView(frame: CGRectMake((frame.size.width - 30) / 2, 5, frame.size.width * 0.3, frame.size.height * 0.35))
        mImageView.image = UIImage(named: imageName)
        self.addSubview(mImageView)
        //mTitleLbl
        let mTitleLbl = UILabel(frame: CGRectMake((frame.size.width - 60) / 2, mImageView.viewBottomY + 5, 60, 12))
        mTitleLbl.font = UIFont.systemFontOfSize(12)
        mTitleLbl.textColor = UIColor.darkGrayColor()
        mTitleLbl.textAlignment = .Center
        mTitleLbl.text = title
        self.addSubview(mTitleLbl)
        let mRightIv = UIImageView(frame: CGRectMake(mTitleLbl.viewRightX + 2, mTitleLbl.viewY, 10, 10))
        mRightIv.image = UIImage(named: "whitenext")
        self.addSubview(mRightIv)
        //mDetailLbl
        let mDetailLbl = UILabel(frame: CGRectMake(7, mTitleLbl.viewBottomY + 2, frame.size.width - 14, 30))
        mDetailLbl.font = UIFont.systemFontOfSize(11)
        mDetailLbl.numberOfLines = 0
        mDetailLbl.textAlignment = .Center
        mDetailLbl.textColor = UIColor.getColorSecond()
        mDetailLbl.text = detail
        self.addSubview(mDetailLbl)
    }
    
    init(frame: CGRect, imageName:String, title: String) {
        super.init(frame: frame)
        //mImageView
        let mImageView = UIImageView(frame: CGRectMake(0, (frame.size.height - 20) / 2, 20, 20))
        mImageView.image = UIImage(named: imageName)
        self.addSubview(mImageView)
        //mTitleLbl
        let mTitleLbl = UILabel(frame: CGRectMake(mImageView.viewRightX + 8, 0, 200, frame.size.height))
        mTitleLbl.textAlignment = .Left
        mTitleLbl.font = UIFont.systemFontOfSize(14)
        mTitleLbl.textColor = UIColor.darkGrayColor()
        mTitleLbl.text = title
        self.addSubview(mTitleLbl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.imageView?.contentMode = .Center
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.font = UIFont.systemFontOfSize(14)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageX:CGFloat = 0
        let imageY:CGFloat = 0
        let imageW:CGFloat = self.viewWidth
        let imageH:CGFloat = self.viewHeight * imageRatio
        return CGRectMake(imageX, imageY, imageW, imageH)
        
        
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleX:CGFloat = 0
        let titleY:CGFloat = self.viewHeight * imageRatio
        let titleW:CGFloat = self.viewWidth
        let titleH:CGFloat = self.viewHeight * (1.0 - imageRatio)
        return CGRectMake(titleX, titleY, titleW, titleH)
        
    }
}