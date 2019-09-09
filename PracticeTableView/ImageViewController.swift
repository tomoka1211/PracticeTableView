//
//  ImageViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/02.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        self.present(picker, animated: true)
        picker.delegate = self
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

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// カメラロールで決定した場合
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        /// 画像の拡張子を取得する
        var imageType: String = ""
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imageType = imageURL.pathExtension.lowercased()
        }
        let base64Img = image?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        let params: [String: Any] = ["image": "data:image/\(imageType);base64,\(base64Img)"]
        //self.imgInput.postImage(params: params) {url in
            //self.multicastDelegate.invoke(invocation: {$0.appendImgUrl(imgUrl: url, postQuestionId: postQuestionId)})
      //  self.imageArray.append(image!)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /// カメラロールでキャンセルした場合
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // キャンセルボタンを押下時の処理
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.bind(img: self.imageArray[indexPath.row])
        cell.indexPath = indexPath.row
        return cell
    }
    
    // セル数を返す(UITableViewでいうところの"tableView:numberOfRowsInSection:"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
}
