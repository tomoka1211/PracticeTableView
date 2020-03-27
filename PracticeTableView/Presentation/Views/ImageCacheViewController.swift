//
//  ImageCacheViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/03.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageCacheViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let host = "https://cloud.githubusercontent.com/assets"
    
    let images = [["https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg","https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg"],
                  ["https://cloud.githubusercontent.com/assets/1567433/9781833/09021316-57a1-11e5-817b-85b57a2a8a77.jpg",
        "https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg",
        "https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg"],
                  ["https://cloud.githubusercontent.com/assets/1567433/9781834/0931ad74-57a1-11e5-9080-c8f6ecea19ce.jpg"],
                  ["https://cloud.githubusercontent.com/assets/1567433/9781832/0719dd5e-57a1-11e5-9324-9764de25ed47.jpg"],
                  ["https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg"],
                ["https://cloud.githubusercontent.com/assets/1567433/9781833/09021316-57a1-11e5-817b-85b57a2a8a77.jpg"],
                ["https://cloud.githubusercontent.com/assets/1567433/9781834/0931ad74-57a1-11e5-9080-c8f6ecea19ce.jpg"],
                ["https://cloud.githubusercontent.com/assets/1567433/9781832/0719dd5e-57a1-11e5-9324-9764de25ed47.jpg"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    func configureTable() {
        tableView.register(TableCacheImageTableViewCell.nib, forCellReuseIdentifier: TableCacheImageTableViewCell.reuseIdentifier)
    }

}

extension ImageCacheViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCacheImageTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! TableCacheImageTableViewCell
        
        print("cellが再利用されました")
        cell.imageUrlString = []
        cell.bind(stringUrls: images[indexPath.row], index: indexPath.row)
        cell.imageLoaded.subscribe(onNext: { index in
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }).disposed(by: disposeBag)
        cell.delegate = self
        return cell
    }
    
    
}

extension ImageCacheViewController: TableCacheImageDelegate {
    func reloadTable(_ index: Int) {
        tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
    }
    
    
}
