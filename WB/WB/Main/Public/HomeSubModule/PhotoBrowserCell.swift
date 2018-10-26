//
//  PhotoBrowserCell.swift
//  WB
//
//  Created by flowerflower on 2018/10/25.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

import SDWebImage

protocol PhotoBrowserCellDelegate:NSObjectProtocol {
    
    func imageViewOnClick()
    
}


class PhotoBrowserCell: UICollectionViewCell {
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    lazy var picUrlImageView: UIImageView = UIImageView()
    private lazy var progressView:Progress = Progress()

    
    
    var delegate: PhotoBrowserCellDelegate?
    
    var picUrl:NSURL?{
        
        didSet{
            setContent(picUrl: picUrl)
            
        }
        
    }
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
        
        
        
        
        setupSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func  setupSubView(){
        
        addSubview(scrollView)
        
        addSubview(picUrlImageView)
        addSubview(progressView)
        scrollView.frame = contentView.bounds
        
        scrollView.bounds.size.width -= 20  //
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: screenW * 0.5 , y: screenH * 0.5)
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.clear
        picUrlImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageCloseOnClick))
        
        picUrlImageView.addGestureRecognizer(tap)
    }
    
    
  @objc  func imageCloseOnClick(){
    
    
    
        delegate?.imageViewOnClick()
    
    
    }
    
    private func setContent(picUrl: NSURL?){
        
        guard let picUrls = picUrl else {
            return
        }
        
        let  image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picUrls.absoluteString)
        
       
        let height  = screenW / image!.size.width * image!.size.height
        var y = CGFloat(0)
        
        if height > screenH {
            
            y = 0
            
        }else{
            
            y = (screenH - height) * 0.5
        }
        
        picUrlImageView.image = image
        
        picUrlImageView.frame = CGRect(x: 0, y: y, width: screenW, height: height)
        progressView.isHidden = false
        picUrlImageView.sd_setImage(with: getBigUrl(smallUrl: picUrls) as URL, placeholderImage: image, options: [], progress: { (current, total, _) in
            
//            self.progressView.progress = CGFloat(current) / CGFloat(total)
            
            
        }) { (_, _, _, _) in
            
            self.progressView.isHidden = true
            
        }
        
        scrollView.contentSize = CGSize(width: 0, height: height)

    }
    

    func getBigUrl(smallUrl:NSURL) -> NSURL {
        
        
        let smallStr = smallUrl.absoluteString
        
        let bigUrl = smallStr?.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        
        
        return NSURL(string: bigUrl!)!
        
    }
    

    
    

}
