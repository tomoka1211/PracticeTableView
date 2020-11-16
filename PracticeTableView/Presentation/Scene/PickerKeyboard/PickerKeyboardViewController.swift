//
//  PickerKeyboardViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/03/26.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift

final class PickerKeyboardViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var pickerLabel: PickerKeyboard!
    @IBOutlet private weak var selectedLabel: UILabel!
    
    // MARK: - Property
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerLabel.data = [("水星", 1), ("金星", 2), ("地球", 3), ("火星", 4), ("木星", 11), ("土星", 6), ("天王星", 7), ("海王星", 8),("冥王星", 9)]
        pickerLabel.selected
            .map { "選択した値は\($0)" }
            .bind(to: selectedLabel.rx.text)
            .disposed(by: disposeBag)
        pickerLabel.text = "木星"
        print(pickerLabel.pickerView.numberOfRows(inComponent: 0))
    }
}
