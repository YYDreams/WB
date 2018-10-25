//
//  PhotoBrowserController.swift
//  WB
//
//  Created by flowerflower on 2018/10/25.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SVProgressHUD
class PhotoBrowserController: BaseUIViewController {

    var selectIdexPath : IndexPath
    var picUrls : [NSURL]
    init(indexPath: IndexPath,picUrls:[NSURL]) {
        
        self.selectIdexPath = indexPath
        self.picUrls = picUrls
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubView()

        collectionView.scrollToItem(at: selectIdexPath, at: .left, animated: false)

         //23  细看一遍
//        view.frame.size.width += 20
    }

    private lazy var closeBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: screenH - 80, width: 80, height: 50))
        btn.setTitle("关闭", for: .normal)
        btn.addTarget(self, action: #selector(closeBtnOnClick), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.backgroundColor = UIColor.brown
        
        return btn
        
        
    }()
    
    private lazy var  saveBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: screenW - 30 - 80, y: screenH - 80, width: 80, height: 50))
        btn.setTitle("保存", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(saveBtnOnCick), for: .touchUpInside)
        btn.backgroundColor = UIColor.brown
        
        return btn
    }()
    
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenW  , height: screenH)
        
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: "PhotoBrowserCellID")
        
        return collectionView
    }()

    
}
//MARK:  setupSubView
extension PhotoBrowserController{
    private func setupSubView(){
        
        view.addSubview(collectionView)
        
        view.addSubview(closeBtn)
        
        view.addSubview(saveBtn)

    }
    
}

//MARK:  SEL Methods
extension PhotoBrowserController{
    
    @objc  private func closeBtnOnClick(){
        
        dismiss(animated: true, completion: nil)
    }
    @objc private func saveBtnOnCick(){
        
        //等同下面
//        let cellx = collectionView.visibleCells.first as! PhotoBrowserCell
//
//        guard let image = cellx.picUrlImageView.image else {
//            return
//        }
        
        let index = collectionView.indexPathsForVisibleItems.last
        let cell = collectionView.cellForItem(at: index!) as! PhotoBrowserCell
        
        let image = cell.picUrlImageView.image
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    //(void *) -> AnyObject
    @objc func  image(image: UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject){
        
        print("error\(String(describing: error))")
        if error != nil {
            
            SVProgressHUD.showSuccess(withStatus: "保存失败")

            
        }else{
            
            SVProgressHUD.showSuccess(withStatus: "保存成功")
        }
    }
 
}

//MARK:  UICollectionViewDelegate,UICollectionViewDataSource
extension PhotoBrowserController:UICollectionViewDelegate,UICollectionViewDataSource,PhotoBrowserCellDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return picUrls.count
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoBrowserCellID", for: indexPath) as! PhotoBrowserCell
        cell.picUrl = picUrls[indexPath.item]
        cell.delegate = self
        return cell
    }
    

    func imageViewOnClick() {
        
        dismiss(animated: true, completion: nil)
        
    }

}




