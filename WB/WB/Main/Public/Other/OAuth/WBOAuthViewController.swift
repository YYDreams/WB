//
//  WBOAuthViewController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBOAuthViewController: UIViewController {

    private lazy var webView: UIWebView = {
        
        let webview = UIWebView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        webview.delegate = self
        return webview
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           setupNav()
           setupWebView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        SVProgressHUD.dismiss()
        
    }



}

extension WBOAuthViewController{

    private func setupWebView(){
        
        view.addSubview(webView)

        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirect_uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(url: url! as URL)
        webView.loadRequest(request as URLRequest)
    }
    
    private func setupNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(dismissOnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(showOnClick))
        
    }
    
    @objc private func dismissOnClick(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func showOnClick(){
        
        print("填充账号密码")
        let js = "document.getElementById('userId').value='\(userId)';document.getElementById('passwd').value='\(passwd)';"
        webView.stringByEvaluatingJavaScript(from: js)
        
        
        
    }
    
    
}

extension  WBOAuthViewController{
    
    private func loadAccessToken(code: String){
        
        // 2.封装参数
        let params = ["client_id":appKey,
                      "client_secret":appSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":redirect_uri]
        

        NetworkTool.shareNetworkTool().post(kAccess_tokenUrl, parameters: params, progress: nil, success: { (_, json) in
            
            SVProgressHUD.dismiss()

            
            
            let account = UserAccount(dic: json! as! [String :AnyObject])
            
            print("account\(account)")
            account.loadUserInfo(finished: { (account, error) in
                
                if account != nil {
                    
                    account?.saveAccount()
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLoginSuccessNotification), object: nil)

                    self.dismissOnClick()
                    
                    
                    
                    
                }
            })

            
            
        }) { (_, error) in
        
            SVProgressHUD.show(withStatus: "网络不给力...")

            
        }
        
        
    }
    
    
    
}




extension WBOAuthViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    //返回值: true:继续加载页面  false:不会继续加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        
        
        // 1.如果不是授权回调页,就继续加载
        if !request.url!.absoluteString.hasPrefix(redirect_uri) {
            
            // 继续加载
            return true
        }
        
        // 2.判断是否授权成功
        let codeStr = "code="
        if request.url!.query!.hasPrefix(codeStr) {
            
            // 授权成功 获取授权成功的RequestToken值
            print("授权成功")
            // 1.去除已经授权成功的RequestToken
            let code = request.url!.query?.substring(from: codeStr.endIndex)
            print(code!)
            // 2.利用已经授权的RequestToken来换取AccessToken
            loadAccessToken(code: code!);
            
        }else{
            
            // 取消授权
            print("取消授权")
            dismiss(animated: true, completion: nil)
        }
        
        return false
        
        
        
    }
    
    
   
    
}

