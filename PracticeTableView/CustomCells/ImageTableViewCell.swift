//
//  ImageTableViewCell.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/23.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import Kingfisher
import MaterialComponents.MaterialList

class ImageTableViewCell: UITableViewCell, NibRegistrable {
    
    
    @IBOutlet weak var aspectImageView: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aspectImageView.contentMode = .scaleAspectFit
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(imgUrl: URL){
        aspectImageView.kf.setImage(with: imgUrl)
        
    }
    
}
