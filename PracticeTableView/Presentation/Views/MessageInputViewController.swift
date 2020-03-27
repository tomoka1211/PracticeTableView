//
//  MessageInputViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/10.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class SomeContainerController: UIViewController {
        
        @IBOutlet private var containerView: UIView! // 子のviewを追加するためのview
        
        var contentViewController: UIViewController? {
            didSet {
                // 問題1の対応
                // セットされていた子を削除
                oldValue?.willMove(toParent: nil)
                oldValue?.view.removeFromSuperview()
                oldValue?.removeFromParent()
                
                // 問題2の対応 - 1
                // viewがロードされていない場合、子は追加するが子のviewの追加は行わない
                addChild(contentViewController!)  // (b)
                contentViewController?.didMove(toParent: self)
                
                guard isViewLoaded else {
                    return
                }
                setupContentView()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // 問題2の対応 - 2
            // viewがロードされた際に子のviewを containerView へ追加
            setupContentView()
        }
        
        private func setupContentView() {
            guard let contentViewController = contentViewController else {
                return
            }
            let isAlreadyAdded = (contentViewController.isViewLoaded) && containerView.subviews.contains(contentViewController.view)
            guard isAlreadyAdded == false else {
                return // 二重呼び出し防止
            }
            
            contentViewController.view.frame = containerView.bounds
            containerView.addSubview(contentViewController.view)  // (c)
        }
}
