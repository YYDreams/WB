//
//  HomeController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SDWebImage
private let HomeCellID = "HomeCellID"

class HomeController: BaseTableViewController {

    //懒加载数组
//    private lazy var statuses: [HomeStatusModel] = [HomeStatusModel]()
    private lazy var viewModel: [HomeViewModel] = [HomeViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        setupTableView()
    if !UserAccount.userLogin() { return}
        
       loadHomeStatusFromNetwork() //
        
        
        
    }
}


//MARK: setupTableView
extension HomeController{
    
    private func setupTableView(){
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: HomeCellID)
        //两个需要同时设置才起作用
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        
//        //取消分割线
        tableView.separatorStyle = .none
        
    }
}

//MARK: setupNav
extension HomeController{
    
  private  func setupNav() {
    
    }
    
}
// MARK: loadFormNetwork
extension HomeController{
    
    private func   loadHomeStatusFromNetwork(){
        HomeViewModel.loadStatusFromNetwork { (result, error) in
            //1.错误校验
            if error != nil {
                print("error:\(String(describing: error))")
                return
            }
            //2. 获取可选类型中的数据
            //            print("result:\(result!)")
            //[[String :AnyObject]]? 可选类型不能直接遍历，只能遍历一个确定的数组类型
            guard let resultArr  = result else{
                return
            }
            //3.遍历对应的字典
            for statusDict in resultArr{
                
                let statusModel = HomeStatusModel(dict: statusDict)
//                self.statuses.append(statusModel)
                let viewModel = HomeViewModel(status: statusModel)
                self.viewModel.append(viewModel)
                
                }
            
            //缓存图片
            self.cacheImags(viewModel: self.viewModel)

//            //4.刷新表格
//          self.tableView.reloadData()
        
        }
    }
    
    
    private func cacheImags(viewModel: [HomeViewModel]){
        /**
          此处注意:
         需下载完图片之后再刷新表格
         */
        // 缓存图片
        
        let group = DispatchGroup()
        for vm in viewModel {

            for picUrl in vm.pirUrls {
                //进入组队列
                group.enter()
                SDWebImageManager.shared().loadImage(with: picUrl as URL, options: [], progress: nil) { (_, _, _, _, _, _) in
                    print("下载了一张图片")
                //离开组队列
                group.leave()
                    
                }
            }
        }

        group.notify(queue:DispatchQueue.main) {
            
            //4.刷新表格
            self.tableView.reloadData()
            print("刷新表格")
        
        }
    }
    
}

//MARK: - <UITableViewDataSource>
extension HomeController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellID) as! HomeCell
     cell.viewModel = viewModel[indexPath.row]
    return cell
        
        
    }

}
