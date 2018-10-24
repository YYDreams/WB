//
//  SelectPhotoCollectionView.swift
//  WB
//
//  Created by flowerflower on 2018/10/24.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

private let SelectPhotoCellID = "SelectPhotoCellID"
private let edgeMargin:CGFloat = 15


class SelectPhotoCollectionView: UICollectionView {
    
    var images:[UIImage] = [UIImage](){
        didSet{
            reloadData()
        }
        
    }
//  var slectItem
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
         setupCollectionView()
        

        
    }

    
    
}
//MARK:  setupCollectionView
extension SelectPhotoCollectionView{
    
    private func setupCollectionView(){
        dataSource = self
        delegate = self
        register(UINib(nibName: "SelectPhotoCell", bundle: nil), forCellWithReuseIdentifier: SelectPhotoCellID)
        
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (screenW - 4 * edgeMargin)/3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = edgeMargin
        layout.minimumInteritemSpacing = edgeMargin
        
        contentInset  = UIEdgeInsetsMake(edgeMargin, edgeMargin, 0, edgeMargin)

        
    }
}

//MARK:  UICollectionViewDataSource
extension SelectPhotoCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPhotoCellID , for: indexPath) as! SelectPhotoCell

        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        return cell
   
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("didSelectItemAt didSelectItemAt")
    }
    
    
    
}
