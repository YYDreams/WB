//
//  MineController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class MineController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupvisitorViewConfig()
    }
}
extension MineController{
        
    private func setupvisitorViewConfig(){
    visitorView.setVisitorInfo(iconImageName: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给人家看")
    }
    
}





