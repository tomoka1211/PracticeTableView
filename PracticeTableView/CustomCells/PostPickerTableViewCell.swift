//
//  PostPickerTableViewCell.swift
//  NoSchool
//
//  Created by hirano_tomoka on 2019/08/02.
//  Copyright © 2019 inuko. All rights reserved.
//

import UIKit
import RxSwift

/// delegate
protocol PostPickerCellDelegate: AnyObject {
    func pickerBtnTapped(key: Int, postQuestionId: Int)
}

final class PostPickerTableViewCell: UITableViewCell, NibRegistrable {
    
    weak var delegate: PostPickerCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var requireButton: UIButton!
    @IBOutlet weak var pickerTextView: UITextView!
    
    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var arrowGreenButton: UIImageView!
    
    
    fileprivate var postQuestionId: Int?
    
    /// Picker View
    private var picker = UIPickerView()
    private let disposeBag = DisposeBag()
    private var array: [String] = []
    private var dict: [Int: String] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.delegate = self
        picker.dataSource = self
        pickerTextView.isEditable = false
        pickerTextView.inputView = self.picker
        pickerTextView.inputAccessoryView = getToolbar()
        pickerTextView.textColor = .gray
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
    }
    
    /// ピッカーツールバー取得　メソッド
    ///
    /// - Parameters: なし
    /// - Returns:
    ///    - UIToolbar: ツールバー
    fileprivate func getToolbar() -> UIToolbar {
        //ハーフモーダルの設定
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "決定", style: .plain, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spacelItem, doneItem], animated: true)
        return toolbar
    }
    
    /// 完了ボタンメソッド
    ///
    /// - Parameters: なし
    /// - Returns: なし
    @objc func done() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        //選択した項目を指定
        let selectedItem = self.array[row]
        //textを指定
        self.pickerTextView.text = selectedItem
        self.pickerTextView.textColor = .black
        //選択した項目のkeyを指定
        let sortKey = dict.filter {$0.value == selectedItem}.keys.first
        //delegate経由で並び替えの処理を実行
        self.delegate?.pickerBtnTapped(key: sortKey!, postQuestionId: postQuestionId!)
        //キーボードを隠す
        self.pickerTextView.resignFirstResponder()
        self.endEditing(true)
    }
    
    /// キャンセルボタンメソッド
    ///
    /// - Parameters: なし
    /// - Returns: なし
    @objc func cancel() {
        //キーボードを隠す
        self.pickerTextView.resignFirstResponder()
        self.endEditing(true)
    }
    
}

extension PostPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    /// pickerViewの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// pickerViewの配列
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: pickerView.frame.size.height))
        label.numberOfLines = 0 //改行数無制限
        label.text = array[row]
        label.textAlignment = .center
        return label
    }
    
}
