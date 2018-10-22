//
//  PicCollectionView.swift
//  WB
//
//  Created by flowerflower on 2018/10/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
private let PicCellID = "PicCellID"

class PicCollectionView: UICollectionView {
    
    //定义属性
    var picUrls : [NSURL] = [NSURL](){
        didSet{
            
          self.reloadData()
            
        }
        
    }
    override func awakeFromNib() {
        super .awakeFromNib()
        
        setupCollectionView()

    }

}

extension PicCollectionView {
    private func  setupCollectionView(){
        
        dataSource = self

        register(UINib(nibName: "PicCell", bundle: nil), forCellWithReuseIdentifier: PicCellID)
        
    }

}
//MARK: UICollectionViewDataSource
extension PicCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return picUrls.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         // as! PicCell  将cell 转成 PicCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCellID, for: indexPath) as! PicCell
         cell.picUrl = picUrls[indexPath.item]
        return cell
    }
    

}


