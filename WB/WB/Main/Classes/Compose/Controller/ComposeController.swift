//
//  ComposeController.swift
//  WB
//
//  Created by flowerflower on 2018/10/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class ComposeController: UIViewController {

    private lazy var  titleView:ComposeNavTitleView = ComposeNavTitleView()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupNav()
        
    }


}


extension ComposeController{
    
    private func setupNav(){
        
        self.title = "发微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(gobackOnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendOnClick))

        navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: screenW, height: 40)
        navigationItem.titleView = titleView
        
      
    }
    
    
    @objc  private func gobackOnClick(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc  private func sendOnClick(){
        
        print("send ")
        
    }
    
}
