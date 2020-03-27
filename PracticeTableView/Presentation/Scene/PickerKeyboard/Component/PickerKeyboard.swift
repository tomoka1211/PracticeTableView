//
//  PickerKeyboard.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/03/26.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift

final class PickerKeyboard: UILabel {
    
    // MARK: - Property
    
    internal var data: [(String, Int)] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selected: Observable<Int> {
        return publishSelected.asObservable()
    }
    
    private var publishSelected = PublishSubject<Int>()
    let pickerView = UIPickerView()
    
    private let accessoryView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .groupTableViewBackground
        return view
    }()
    
    private let doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("完了", for: .normal)
        doneButton.addTarget(self, action:
        #selector(didTapDone(sender:)), for: .touchUpInside)
        return doneButton
    }()
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        pickerView.delegate = self
    }
    
    // MARK: - Override
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputView: UIView? {
        let row = data.map { $0.0 }.firstIndex(of: text ?? "") ?? -1
        pickerView.selectRow(row, inComponent: 0, animated: false)
        return pickerView
    }
    
    override var inputAccessoryView: UIView? {
        accessoryView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 44)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(doneButton)
        doneButton.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -20).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor).isActive = true
        
        return accessoryView
    }
    
    override var text: String? {
        didSet {
            if let text = text {
                let row = data.map { $0.0 }.firstIndex(of: text) ?? -1
                pickerView.selectRow(row, inComponent: 0, animated: false)
                publishSelected.onNext(data[row].1)
            }
        }
    }
    
    // MARK: - Private
    
    @objc
    private func didTap(sender: PickerKeyboard) {
        becomeFirstResponder()
    }
    
    @objc
    private func didTapDone(sender: UIButton) {
        resignFirstResponder()
    }
    
    // MARK: - Public
    
    func selectedItem() {
        let row = data.map { $0.0 }.firstIndex(of: text ?? "") ?? -1
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
}

// MARK: - UIKeyInput

extension PickerKeyboard: UIKeyInput {
    
    var hasText: Bool {
        return !(text?.isEmpty ?? false)
    }
    
    func insertText(_ text: String) {
        self.text! += text
        setNeedsDisplay()
    }
    
    func deleteBackward() {
        text = String(text!.prefix(text!.count - 1))
        setNeedsDisplay()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension PickerKeyboard: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = data[row].0
        setNeedsDisplay()
    }
}



