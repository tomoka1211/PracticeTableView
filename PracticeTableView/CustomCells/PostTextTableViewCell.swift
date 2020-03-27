//
//  PostTextTableViewCell.swift
//  NoSchool
//
//  Created by hirano_tomoka on 2019/08/10.
//  Copyright © 2019 inuko. All rights reserved.
//

import UIKit
import RxSwift
import UITextView_Placeholder

/// delegate
protocol PostTextCellDelegate: AnyObject {
    func textChanged(text: String, postQuestionId: Int)
}

class PostTextTableViewCell: UITableViewCell, NibRegistrable {
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: PostTextCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var requireButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textStackView: UIStackView!
    
    fileprivate var postQuestionId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
