//
//  AppDelegate.swift
//  YiRenDai
//
//  Created by Rain on 16/4/18.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: - 系统代理
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //初始化第三方配置
        initConfiguration()
        
        //判断是否首次登陆
        if NSUserDefaults.standardUserDefaults().boolForKey("NoFirstLaunch"){
            let customTabBarVC = CustomTabBarViewController()
            window?.rootViewController = customTabBarVC
        }else{
            let startScrollVC = StartScrollViewController();
            window?.rootViewController = startScrollVC
        }
        window?.makeKeyAndVisible()
        
        // 只能竖屏显示
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        return true
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        //禁止横屏
        return UIInterfaceOrientationMask.Portrait
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: - 自定义方法
    func initConfiguration(){
        //SMSSDK
        SMSSDK.registerApp(SMSSDK_AppKey, withSecret: SMSSDK_Secret)
        SMSSDK.enableAppContactFriends(false)
        
        // ShareSDK
        ShareSDK.registerApp(ShareSDK_AppKey, activePlatforms: [
            SSDKPlatformType.TypeSinaWeibo.rawValue,
            SSDKPlatformType.TypeTencentWeibo.rawValue,
            SSDKPlatformType.TypeWechat.rawValue,
            SSDKPlatformType.TypeQQ.rawValue], onImport: { (platform) in
                switch platform{
                    
                case SSDKPlatformType.TypeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    
                case SSDKPlatformType.TypeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
        }) { (platform, appInfo) in
            switch(platform){
            case SSDKPlatformType.TypeWechat:
                appInfo.SSDKSetupWeChatByAppId("wxb1fb6e1f1f47c07f", appSecret: "0b98bac8fdab547ca0351edc5f28c09c")
            case SSDKPlatformType.TypeQQ:
                appInfo.SSDKSetupQQByAppId("1105020970", appKey: "QfVL5BJzt8hpGCN9", authType: SSDKAuthTypeBoth)
            default:
                break
            }
        }
    }

}

