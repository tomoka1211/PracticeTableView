//
//  ContainerFormViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/10.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class ContainerFormViewController: UIViewController {
    
    @IBOutlet weak var messageInputView: UIView!
    @IBOutlet weak var messageInputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageInputViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var inputTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageInputView()
        // Do any additional setup after loading the view.
    }
    
    let disposeBag = DisposeBag()
    
    private func setupMessageInputView() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyBoardHeight in
                self?.messageInputViewBottomConstraint.constant = -keyBoardHeight
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        let inputTextViewMaxHeight: CGFloat = 100.0
        let inputTextViewVerticalMargin: CGFloat = 12.0
        inputTextView.rx.text
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let height = self?.inputTextView.contentSize.height else { return }
                let inputTextViewHeight = height + inputTextViewVerticalMargin
                if inputTextViewMaxHeight > inputTextViewHeight {
                    self?.messageInputViewHeightConstraint.constant = inputTextViewHeight
                }
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
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
