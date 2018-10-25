//
//  BaseTabBarViewController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
     // 懒加载 私有控件（发布）
    private lazy var composeBtn: UIButton = UIButton.init(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupViewControllers() //设置子控制器

        setupComposeBtn() // 设置中间加号按钮
        
        
      selectedIndex = 3

    }
}
//MARK: 设置中间 + 按钮
extension BaseTabBarViewController{
    
    
    private func setupComposeBtn(){
        tabBar.addSubview(composeBtn)
        let w = tabBar.bounds.width / CGFloat(childViewControllers.count) - 1
        // OC CGRectInset 正数向内索进 负数向外扩展 例如 中心向上凸出 -20
        //        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: -20)
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w , dy: 0)
        composeBtn.addTarget(self, action: #selector(composeOnClick), for: .touchUpInside)
    }
    /**
     事件监听本质发送消息: 将方法包装成@SEL -> 类中查找方法列表 -> 根据@SEL找到imp指针(函数指针) -> 执行函数
     pricvate 能改保存方法私有 仅被当前对象访问
     @objc 允许这个函数在允许时 通过OC的消息机制被调用
     
     */
 @objc  private func  composeOnClick(){
    
    print("composeOnClick")

    present(BaseNavViewController(rootViewController: ComposeController()), animated: true, completion: nil)

    }
}
//MARK: 设置子控制器
//  extension 中可以有计算性属性 不会占用存储空间
extension BaseTabBarViewController{
    
    private  func  setupViewControllers(){
        //0  获取沙盒json路径
        let docDic = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let jsonPath = (docDic as NSString).appendingPathComponent("TabBar.json")
        // 加载data
        var data = NSData(contentsOfFile: jsonPath)
        //判断data是否有内容，如果没有 说明本地沙盒没有文件
        if data == nil {
            //从Bundle加载data
            let path = Bundle.main.path(forResource: "TabBar.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        //data一定会有一个内容 反序列化
        //反序列化转成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : String]] else{ return}
        
        var arrayM = [UIViewController]()
        for dic in array! {
            arrayM.append(addController(dic: dic))
        }
        viewControllers = arrayM
        
    }
    //使用字段创建子控制器
    private func addController(dic:[String: String]) ->UIViewController{
        
        guard let className = dic["clsName"],
            let title = dic["title"],
            let  imageName = dic["imageName"],
            //默认情况下命名空间就是项目的名称  NSClassFromString((Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "") + "." + className)
            // as? UIViewController.Type 将上面（NSClassFromStri..+ className)） 转化为指定的类
            let  cls = NSClassFromString((Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "") + "." + className) as? UIViewController.Type else {
    
                return UIViewController()
        }
        let  vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal)        
        //字体颜色
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: .highlighted)
        //字体大小 默认是12   要选择.normal 类型
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)], for: .normal)
        let nav = BaseNavViewController(rootViewController: vc)
        return nav
    }
}
