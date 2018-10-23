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

    @IBOutlet weak var toolbarBottomConst: NSLayoutConstraint!
    @IBOutlet weak var composeTextView: ComposeTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.delegate = self
        setupNav()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        composeTextView.becomeFirstResponder()
    }
}

extension ComposeController{
    
      
    
    @objc  func keyboardWillChangeFrame(note:Notification){
        
        //1获取动画执行时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        //2.获取键盘最终Y值
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
     
        let y = endFrame.origin.y
       //3.计算工具栏距离底部的间距
        let margin = screenH - y
        
        toolbarBottomConst.constant = margin
        
        UIView.animate(withDuration: duration) {
            
            self.view.layoutIfNeeded()

        }
        print(note.userInfo ?? "xx")
        
    }
    
 
}

extension ComposeController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        // hasText 如果值是 null， ""，都返回 false，否则返回true    返回为true包含文本 返回为false不包含文本。
        composeTextView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
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

