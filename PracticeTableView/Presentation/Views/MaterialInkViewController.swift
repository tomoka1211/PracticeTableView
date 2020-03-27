//
//  MaterialInkViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/01.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialInk
import MaterialComponents.MaterialRipple

class MaterialInkViewController: UIViewController, CAAnimationDelegate {
    
    let statefulRippleView = MDCStatefulRippleView()
    
    @IBOutlet weak var materialInkView: UIView!
    @IBOutlet weak var materialInkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statefulRippleView.setRippleColor(.blue, for: .selected)
        materialInkView.addSubview(statefulRippleView)
        
    }
}
