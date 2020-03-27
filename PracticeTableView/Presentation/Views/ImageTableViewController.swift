//
//  ImageTableViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/21.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
}

extension ImageTableViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        self.tableView?.register(ImageListTableViewCell.nib
            , forCellReuseIdentifier: ImageListTableViewCell.reuseIdentifier)
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListTableViewCell.reuseIdentifier, for: indexPath) as! ImageListTableViewCell
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .red
            cell.bindImageUrls(urls: demoPhotosURLs1)
        case 1:
            cell.backgroundColor = .yellow
            cell.bindImageUrls(urls: demoPhotosURLs2)
        case 2:
            cell.backgroundColor = .blue
            cell.bindImageUrls(urls: demoPhotosURLs3)
        default:
            cell.bindImageUrls(urls: demoPhotosURLs)
        }
        return cell
    }

}
