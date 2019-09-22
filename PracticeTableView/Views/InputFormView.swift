//
//  InputFormView.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/08/30.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import Cartography
import RxSwift

final class InputFormView: UIView {
    /// 定数の定義
    private enum Const {
        static let defaultFont = UIFont.boldSystemFont(ofSize: 16)
        static let boldFont = UIFont.boldSystemFont(ofSize: 14)
        static let baseColor = UIColor(hex: "239348")
        static let gray = UIColor(hex: "CCCCCC")
        static let cancelTextColor = UIColor(hex: "999999")
        static let placeholderText = "を記入"
        static let cancelText = "キャンセル"
        static let doneText = "する"
        static let iconSize: CGSize = CGSize(width: 24, height: 24)
        static let typeDict: [[Any]] = [["質問に回答する", "回答"], ["回答へのコメント", "コメント"]]
    }
    
    /// 投稿のタイプ
    var typeId: Int?
    let disposeBag = DisposeBag()
    
    /// 部品の定義
    public let closeButton = UIButton()
    fileprivate let titleLabel = UILabel()
    fileprivate let customInputView = UIView()
    fileprivate let textView = UITextView()
    fileprivate let setImageButton = UIButton()
    fileprivate let border = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 1))
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        /// auto sizingをオフにする
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier:  "")
        return cv
    }
    fileprivate let cancelButton = UIButton()
    fileprivate let doneButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        self.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        constrain(self) { view in
            view.width == 100
            view.height == 100
            
        }
        
        /// ここにAutoLayout(pin)の設定
        constrain(self.closeButton) { closeButton in
            guard let superview = closeButton.superview else {
                return
            }
            closeButton.width == 24
            closeButton.height == 24
            closeButton.top == superview.top - 4
            closeButton.left == superview.left - 4
            
        }
    }
}

/// collectionViewの設定
extension InputFormView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        /// Todo: Imageを使用する
        return cell
    }
    
}
