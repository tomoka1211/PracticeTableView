//
//  File.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/08/30.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class SampleView: UIView {
    
//    override func draw(_ rect: CGRect) {
//        // Draw
//        let height: CGFloat = 200
//        let width: CGFloat = 200
//        self.frame.size.height = height
//        self.frame.size.width = width
//
//        let superScreen: CGRect = (self.window?.screen.bounds)!
//
//        self.frame.origin.x = (superScreen.width/2) - (width/2)
//        self.frame.origin.y = (superScreen.height/2) - (height/2)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib.init(nibName: "SampleView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
    }
}

