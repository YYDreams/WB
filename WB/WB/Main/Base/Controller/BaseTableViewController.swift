//
//  BaseTableViewController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
        

    lazy var visitorView: VisitorView = VisitorView.visitorView()
    
    var isLogin: Bool = false
    
    override func loadView() {
        
        UserAccount.userLogin() ? super.loadView() : setupVisitorView()
        
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupNav()
            
            setupTableViewInit()
        }
}

extension BaseTableViewController{
    private func setupTableViewInit(){
        
        
    }
    
}

extension BaseTableViewController{
    
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registOnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginOnClick))
    }
    
    func  setupVisitorView(){
        view = visitorView
        //动画
        visitorView.addRotationAnimation()
        visitorView.registBtn.addTarget(self, action: #selector(registOnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginOnClick), for: .touchUpInside)
        
    }
    
}

extension BaseTableViewController{
    
    @objc  func registOnClick(){
        
        print("注册")
    }
    @objc private func loginOnClick(){
        
        print("登录")
        // 弹出登录界面
        let oAuthViewController = WBOAuthViewController()
        
        let nav = UINavigationController(rootViewController: oAuthViewController)
        present(nav, animated: true, completion: nil)

        
    }
}
