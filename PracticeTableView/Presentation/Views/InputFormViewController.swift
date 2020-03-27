//
//  InputFormViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/08/30.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialInk

class InputFormViewController: UIViewController {

    
    @IBOutlet weak var materialInkView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let iv = MDCInkView()
        iv.inkColor = UIColor.red
        self.materialInkView.addSubview(iv)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
