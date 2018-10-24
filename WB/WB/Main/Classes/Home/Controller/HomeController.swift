//
//  HomeController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
private let HomeCellID = "HomeCellID"

class HomeController: BaseTableViewController {

    //懒加载数组
//    private lazy var statuses: [HomeStatusModel] = [HomeStatusModel]()
    private lazy var viewModel: [HomeViewModel] = [HomeViewModel]()
    private lazy var tipLabel: UILabel = UILabel() //
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        setupTableView()
    if !UserAccount.userLogin() { return}

        setupRefresh()
        
        setupTipLabel()
        
    }
}

//MARK: setupRefresh
extension HomeController{
    
    
    private func setupRefresh(){
        
        tableView.mj_header =  MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))

        tableView.mj_footer =  MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        tableView.mj_header.beginRefreshing()

    }

    @objc  func loadNewData(){
        
        print("loadNewData")
        
        loadHomeStatusFromNetwork(isNewData: true)

    }
  @objc  func loadMoreData(){
        
        print("loadMoreData")
        
        loadHomeStatusFromNetwork(isNewData: false)
        
    }
}

//MARK: setupTableView
extension HomeController{
    
    private func setupTableView(){
        
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: HomeCellID)
        //两个需要同时设置才起作用
        //如果需要手动计算则需去除底部工具条的底部约束
//        tableView.rowHeight = UITableViewAutomaticDimension  // 根据约束自动计算  如果需要手动计算 则需要去掉
        tableView.estimatedRowHeight = 200

        tableView.separatorStyle = .none
        
    }
    
    private func setupTipLabel(){
        /**
           注意： 这里的view 和tablView指向的是一个对象  为了不让他跟随tableView一起滚动的话  可以加navigationController?.navigationBar
         */
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
//        view.addSubview(tipLabel)
        tipLabel.frame = CGRect(x: 0, y: 10, width: screenW, height: 30)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.isHidden = true
        tipLabel.textAlignment = .center
        
        
        
    }
}

//MARK: setupNav
extension HomeController{
    
  private  func setupNav() {
    
    }
    
}
// MARK: loadFormNetwork
extension HomeController{
    
    private func   loadHomeStatusFromNetwork(isNewData:Bool){
        /**
         since_id    若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
         max_id  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
         */
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id =  viewModel.first?.status?.mid ?? 0
        }else{
            
            
            max_id = viewModel.last?.status?.mid ?? 0 //没有值就传0
            max_id =  max_id == 0 ? 0 : (max_id - 1)  //最后一条会重复 特殊处理一下
        }
        
 
        HomeViewModel.loadStatusFromNetwork (since_id: since_id,max_id: max_id){ (result, error) in
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
            var tempViewModel = [HomeViewModel]()
            for statusDict in resultArr{
                
                let statusModel = HomeStatusModel(dict: statusDict)
//                self.statuses.append(statusModel)
                let viewModel = HomeViewModel(status: statusModel)
                tempViewModel.append(viewModel)
                
                }
            
            if isNewData{
                self.viewModel = tempViewModel + self.viewModel

            }else{
                 self.viewModel += tempViewModel
            }
            
            // 缓存图片
            self.cacheImags(viewModel: tempViewModel) //缓存最新数据


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
          
            self.tableView.reloadData()
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

            print("刷新表格")
            self.showTipLabel(count: viewModel.count)
        
        }
    }
    
    
    private func showTipLabel(count: Int){
     
        self.tipLabel.isHidden = false
        
        self.tipLabel.text = count == 0 ? "没有新数据": "\(count)" + "新微博"
        
        UIView.animate(withDuration: 1, animations: {
            self.tipLabel.frame.origin.y = 44
        }) { (_) in
            //delay 停留1.5秒
            UIView.animate(withDuration: 1, delay: 1.5, options: [], animations: {
                
                self.tipLabel.frame.origin.y = 10

            }, completion: { (_) in
                self.tipLabel.isHidden = true

            })
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
   override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return viewModel[indexPath.row].cellHeight
        
    }

}
