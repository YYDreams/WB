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
    
    private lazy var images:[UIImage] = [UIImage]()

    @IBOutlet weak var toolbarBottomConst: NSLayoutConstraint!
    
    @IBOutlet weak var composeTextView: ComposeTextView!
    
    @IBOutlet weak var collectionView: SelectPhotoCollectionView!
    
    @IBOutlet weak var collectionViewHeightConst: NSLayoutConstraint!

    
 

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
       
        setuoNotifactionCenter()
        
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        composeTextView.becomeFirstResponder()
    }
    

    deinit {
        print("deinitdeinit")
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: setuoNotifactionCenter Method
extension ComposeController{
    
    private func setuoNotifactionCenter(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoOnClick), name: NSNotification.Name(kSelectPhotoNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(delelePhotoOnClick), name: NSNotification.Name(kDeletePhotoNotification), object: nil)

     
    }
    

    
}



//MARK: SEL Method
extension ComposeController{
    @objc  private func delelePhotoOnClick(noti: Notification){
        
        print("noti:\(String(describing: noti.object))")
        
        guard let image = noti.object as? UIImage else {
            
            return
            
        }
        
        guard let index = images.index(of: image) else {
           
            return
        }
        
        images.remove(at: index)
        
        collectionView.images = images
        
    }
    @objc  private func showPhotoOnClick(){
        print("showPhotoView")
   
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){ return}
                
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        pickerVC.delegate = self

        present(pickerVC, animated: true, completion: nil)

    }
    
    
    @objc  private func keyboardWillChangeFrame(note:Notification){
        
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
    
    @objc  private func gobackOnClick(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc  private func sendOnClick(){
        
        print("send ")
        
    }

    @IBAction func photoOnClick() {
        
        
        collectionViewHeightConst.constant = screenH * 0.65
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        composeTextView.resignFirstResponder()
        
    }
    @IBAction func emoiconBtnOnClick() {
        
        composeTextView.inputView =  (composeTextView.inputView != nil) ? nil : UISwitch()
        
        composeTextView.resignFirstResponder()
        
    }
    


}

//MARK: setupNav
extension ComposeController{
    
    private func setupNav(){
        
        self.title = "发微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(gobackOnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendOnClick))

        navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: screenW, height: 40)
        navigationItem.titleView = titleView

    }

}

//MARK: UITextViewDelegate
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

//MARK: UIImagePickerControllerDelegate,UINavigationControllerDelegate
extension  ComposeController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("info:\(info)")
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        images.append(image)
        
        collectionView.images = images
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
  
}



