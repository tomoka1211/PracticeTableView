//
//  ImagePickerViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/28.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTable()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
}

extension ImagePickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTable() {
        self.tableView.register(PostImageTableViewCell.nib, forCellReuseIdentifier: PostImageTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.reuseIdentifier) as! PostImageTableViewCell
        print("比較：\(indexPath.row):\(cell.getIndex())")
        if indexPath.row != cell.getIndex() {
            cell.images = []
            cell.collectionView.reloadData()
        } else {
            print("比較をリセットしませんでした")
        }
        cell.bind(vc: self, indexPath: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension ImagePickerViewController: PostImageCellDelegate {
    func imageArrayRefresh(postQuestionId: Int) {
        // self.tableView.reloadRows(at: [IndexPath(row: postQuestionId, section: 0)], with: .automatic)
        self.tableView.reloadData()
        print("reloadしました")
    }
}
