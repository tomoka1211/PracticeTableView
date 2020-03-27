//
//  InputTextFormViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/10.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import UITextView_Placeholder

class InputTextFormViewController: UIViewController {
    
    @IBOutlet weak var messageInputView: UIView!
    @IBOutlet weak var messageInputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageInputViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputFormViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var selectedImageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    /// 定数の定義
    private enum LocalConst {
        static let defaultFont = UIFont.boldSystemFont(ofSize: 16)
        static let boldFont = UIFont.boldSystemFont(ofSize: 14)
        static let baseColor = UIColor(hex: "239348")
        static let gray = UIColor(hex: "CCCCCC")
        static let cancelTextColor = UIColor(hex: "999999")
        static let placeholderText = "を記入"
        static let cancelText = "キャンセル"
        static let doneText = "する"
        static let iconSize: CGSize = CGSize(width: 24, height: 24)
    }
    
    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupMessageInputView()
        commonInit()
        configureCollectionView()
    }
    
    private func setupMessageInputView() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyBoardHeight in
                self?.messageInputViewBottomConstraint.constant = +keyBoardHeight
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        let inputTextViewMaxHeight: CGFloat = 120.0
        let inputTextViewVerticalMargin: CGFloat = 12.0
        inputTextView.rx.text
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let height = self?.inputTextView.contentSize.height else { return }
                
                let inputTextViewHeight = height + inputTextViewVerticalMargin
                if inputTextViewMaxHeight > inputTextViewHeight {
                    self?.inputFormViewHeightConstraint.constant = inputTextViewHeight
                }
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        self.inputTextView.rx.text.map { $0 }.subscribe(onNext: { [weak self] text in
            guard let `self` = self else { return }
            guard let `text` = text else { return }
            if !text.isEmpty {
                self.doneButton.backgroundColor = Const.baseColor
                self.doneButton.isEnabled = false
            } else {
                self.doneButton.backgroundColor = UIColor(hex: "CCCCCC")
                self.doneButton.isEnabled = true
            }
        }).disposed(by: disposeBag)
    }
    
    func commonInit() {
        // placeHolder
        inputTextView.placeholder = "回答を記入"
        // 影の設定
        self.messageInputView.layer.shadowOpacity = 0.5
        self.messageInputView.layer.shadowRadius = 12
        self.messageInputView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        // ボタンの設定
        cancelButton.setTitleColor(LocalConst.cancelTextColor, for: .normal)
        cancelButton.titleLabel?.font = LocalConst.boldFont
        cancelButton.layer.borderColor = LocalConst.cancelTextColor.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = Const.colors["silver"]
        doneButton.titleLabel?.font = LocalConst.boldFont
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.borderColor = LocalConst.gray.cgColor
        doneButton.layer.borderWidth = 1
        doneButton.layer.cornerRadius = 5
        doneButton.layer.masksToBounds = true
        
        self.closeButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.messageInputView.fadeOut()
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        self.doneButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.messageInputView.fadeOut()
            }).disposed(by: disposeBag)
        self.selectedImageButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                let picker = UIImagePickerController()
                self.present(picker, animated: true, completion: nil)
                picker.delegate = self
            }).disposed(by: disposeBag)
    }

}

extension InputTextFormViewController {
    /// collectionViewの設定
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout.invalidateLayout()
        // Self-Sizingの有効化
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}

extension InputTextFormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let image = images[indexPath.row]
        cell.deleteButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton?.addTarget(self, action: #selector(deleteImage(sender:)), for: UIControl.Event.touchUpInside)
        let aspect = image.size.width / image.size.height
        cell.aspectConstraint = NSLayoutConstraint(item: cell.imageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.imageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        cell.bindImage(img: image)
        cell.layoutIfNeeded()
        return cell
    }
    
    /// 指定した画像を削除する
    @objc func deleteImage(sender: UIButton) {
        let index = sender.layer.value(forKey: "index") as! Int
        images.remove(at: index)
        collectionView.reloadData()
    }
    
    /// セル間の間隔を開ける
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension InputTextFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// カメラロールで決定した場合
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[.originalImage] as? UIImage
        /// 画像の拡張子を取得する
        var imageType: String = ""
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imageType = imageURL.pathExtension.lowercased()
        }
        /* 画像URLを取得する際の処理
        let base64Img = image?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        let params: [String: Any] = ["image": "data:image/\(imageType);base64,\(base64Img)"]
        self.imgInput.postImage(params: params) {url in
            self.imageUrl.append(url)
            self.images.append(image!)
            self.collectionView.reloadData()
        }
         */
        self.images.append(image!)
        self.dismiss(animated: true, completion: nil)
    }
    
    /// カメラロールでキャンセルした場合
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // キャンセルボタンを押下時の処理
        picker.dismiss(animated: true, completion: nil)
    }
}

