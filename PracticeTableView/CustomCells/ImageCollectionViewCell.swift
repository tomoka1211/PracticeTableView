//
//  ImageCollectionViewCell.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/02.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import Kingfisher

protocol TapImageDelegate: AnyObject {
    func deleteImage(id: Int)
}

class ImageCollectionViewCell: UICollectionViewCell, NibRegistrable {
    
    weak var delegate: TapImageDelegate?
    
    var indexPath: Int?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// AutoLayoutが設定できるようにする
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        /// bounds内を描画するか
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
        let rightConstraint = self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        let topConstraint = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
    
    /// 削除ボタン押下時
    @IBAction func tapDeleteButton(_ sender: Any) {
        guard let indexPath = self.indexPath else {
            return
        }
        delegate?.deleteImage(id: indexPath)
    }
    
    func bindImage(img: UIImage){
        imageView.image = img
    }
    
    /// imageの制約を設定する
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imageView.removeConstraints(imageView.constraints)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
                imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
                imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
                imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                imageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    func bind(imgUrl: URL){
        imageView.kf.setImage(with: imgUrl)
    }
    
}
