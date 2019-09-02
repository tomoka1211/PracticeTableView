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

class ImageCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: TapImageDelegate?
    
    var indexPath: Int?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleToFill
    }
    
    /// 削除ボタン押下時
    @IBAction func tapDeleteButton(_ sender: Any) {
        guard let indexPath = self.indexPath else {
            return
        }
        delegate?.deleteImage(id: indexPath)
    }
    
    func bind(img: UIImage){
        imageView.image = img
    }
    
}
