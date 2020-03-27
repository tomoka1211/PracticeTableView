//
//  MultiSelectmageViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/19.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import TLPhotoPicker

class MultiSelectmageViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectButton.rx.tap.subscribe(onNext: {[weak self] in
            guard let `self` = self else { return }
            print("よばれたお")
            self.callPhotosSheet(delegate: self)
        }).disposed(by: disposeBag)
    }

}

extension MultiSelectmageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, TLPhotosPickerViewControllerDelegate {
    /// カメラロールで決定した場合
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[.originalImage] as? UIImage
        /// 画像URLを取得する際の処理
        let jpegImg = image?.jpegData(compressionQuality: 1)
        let params: [String: Any] = ["image": jpegImg!]
        print("選択されたimage\(params)")
        self.dismiss(animated: true, completion: nil)
    }
    
    /// カメラロールでキャンセルした場合
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // キャンセルボタンを押下時の処理
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// imageを選択した場合
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        print(withTLPHAssets)
        let images = withTLPHAssets.map{ $0.fullResolutionImage }
    }
}
