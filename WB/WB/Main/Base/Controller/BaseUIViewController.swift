//
//  BaseUIViewController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit


class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
    }
    
        
        
    @objc private func loginSuccess(noity:Notification){

        print("noity\(noity)")

        self.navigationItem.leftBarButtonItem = nil
        
        //需要重新设置View
        //在访问View的getter时 如果view == nil 会调用 loadView ->ViewDidLoad
        view  = nil
        //注销通知 -> 重新执行VeiwDidLoad时会重新再次注册 避免通知被重复调用
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
}
