//
//  PostImageTableViewCell.swift
//  NoSchool
//
//  Created by hirano_tomoka on 2019/08/02.
//  Copyright © 2019 inuko. All rights reserved.
//

import UIKit
import RxSwift

/// delegate
protocol PostImageCellDelegate: AnyObject {
    func imageArrayRefresh(postQuestionId: Int)
}

class PostImageTableViewCell: UITableViewCell, NibRegistrable {
    
    weak var delegate: PostImageCellDelegate?
    
    let disposeBag = DisposeBag()
    
    fileprivate var imageUrlArray: [String] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var requireButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var postQuestionId: Int?
    
    var vc: UIViewController?
    
    var images: [UIImage] = []
    
    private enum Const {
    static let maxImgCnt = 5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PostImageTableViewCell {
    
    /// 初期設定
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.titleLabel.numberOfLines = 0
        
        /// セルの選択状態の色を変化させない
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.imageButton.addTarget(self, action: #selector(tapImageButton(_:)), for: .touchUpInside)
        collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }
    
    @objc func tapImageButton(_ selector: UIButton) {
        let picker = UIImagePickerController()
        vc?.present(picker, animated: true)
        picker.delegate = self
    }
    
    /// セルに値をbind
    func bind(vc: UIViewController, indexPath: Int) {
        self.titleLabel.text = "Cell内からPickerを呼出"
        self.postQuestionId = indexPath
        self.vc = vc
    }
    
    func getIndex() -> Int {
        return self.postQuestionId ?? 0
    }
    
}

extension PostImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// セルの高さ設定
        let height = collectionView.layer.bounds.height - 20
        let width = UIScreen.main.bounds.width / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.bindImage(img: images[indexPath.row])
        cell.deleteButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton?.addTarget(self, action: #selector(deleteImage(sender:)), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    /// 指定した画像を削除する
    @objc func deleteImage(sender: UIButton) {
        let index = sender.layer.value(forKey: "index") as! Int
        images.remove(at: index)
        collectionView.reloadData()
        guard let postQuestionId = self.postQuestionId else { return }
        delegate?.imageArrayRefresh(postQuestionId: postQuestionId)
    }
    
    /// セル間の間隔を開ける
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

/// カメラのdelegate
extension PostImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// カメラロールで決定した場合
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.images.append(image!)
        self.collectionView.reloadData()
        self.delegate?.imageArrayRefresh(postQuestionId: self.postQuestionId ?? 0)
        vc?.dismiss(animated: true, completion: nil)
    }
    
    /// カメラロールでキャンセルした場合
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // キャンセルボタンを押下時の処理
        picker.dismiss(animated: true, completion: nil)
    }
}
