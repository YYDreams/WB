//
//  DiscoverController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//
import UIKit

class DiscoverController: BaseTableViewController {
    
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            setupvisitorViewConfig()
            
            
            
            view.addSubview(UISwitch())
            
    }
    
}
extension DiscoverController{
    
    
    private func setupvisitorViewConfig(){
        visitorView.setVisitorInfo(iconImageName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }
    
    
    
    
    
}
