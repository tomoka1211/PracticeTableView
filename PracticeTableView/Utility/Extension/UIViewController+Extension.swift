//
//  UIViewController+Extension.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/10.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//
import UIKit
import TLPhotoPicker

extension UIViewController {
    /// keyboardを隠すタップイベントを追加
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func callPhotosSheet(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate & TLPhotosPickerViewControllerDelegate ) {
        
        let multiPicker = TLPhotosPickerViewController()
        var configure = TLPhotosPickerConfigure()
        configure.allowedVideo = false
        multiPicker.configure = configure
        multiPicker.delegate = delegate
    
        let picker = UIImagePickerController()
        picker.delegate = delegate
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "カメラ", style: .default, handler: {
            action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "アルバム", style: .default, handler: {
            action in
            self.present(multiPicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
