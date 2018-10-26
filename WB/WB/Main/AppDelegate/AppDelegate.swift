//
//  AppDelegate.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultController()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        setupAppearance() // 全局nav、tabBar 字体颜色设置
        
//    NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: kLoginSuccessNotification), object: nil)
//
        return true
    }

    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
   
}


extension AppDelegate{
    
    private func  setupAppearance(){
        
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        
    }
    
    
    @objc private func loginSuccess(notity:Notification){
        
        
        print("notity\(notity)")

        if notity.object as! Bool {
            window?.rootViewController = BaseTabBarViewController()
            
        }
//          window?.rootViewController = WBNewFeatureController()
        window?.rootViewController = WelcomeController()

        
    }
    
    
    // MARK: 用于获取根控制器
    func defaultController() -> UIViewController {
        
        if UserAccount.userLogin() {
        
            return  WelcomeController()
        }
        
        return BaseTabBarViewController()
    }
    
}


extension AppDelegate{
    
 
    // MARK: 新版的判断
    func isNewUpdateVersion() -> Bool {
        
        // 1.获取当前app的版本号，从info.plist里面拿到
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        print("当前的版本号=\(currentVersion)")
        // 2.获取以前的版本号  ?? 代表的意思是: 前面的值如果为nil - 就取后面的值 这里再说明一下，nil 和 字符串空是完全不一样的概念
        let sandBoxVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") ?? ""
        print("之前的版本号=\(sandBoxVersion)")
        // 3.比较当前的版本号和以前的版本号
        // 3.1.如果当前的版本号大于以前的版本号 就代表有新的版本
        // 2.0  -  1.0
        /*
         *  orderedDescending 降序
         *  orderedAscending  升序
         *  orderedSame       相同
         */
        if currentVersion.compare(sandBoxVersion as! String) == ComparisonResult.orderedDescending{
            
            // 有新的版本就存下新的版本号作为下一次的对比
            // iOS7 之后就不用调用同步的方法了
            UserDefaults.standard.setValue(currentVersion, forKey: "CFBundleShortVersionString")
            // 降序
            print("有版本号更新")
            return true
        }
        
        // 没有版号更新
        return false
        
    }

    
}





