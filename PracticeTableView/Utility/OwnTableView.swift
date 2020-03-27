//
//  OwnTableView.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/26.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class OwnTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
}
