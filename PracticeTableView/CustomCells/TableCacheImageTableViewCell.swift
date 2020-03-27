//
//  TableCacheImageTableViewCell.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/03.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift

protocol TableCacheImageDelegate: AnyObject {
    func reloadTable(_ index: Int)
}

class TableCacheImageTableViewCell: UITableViewCell, NibRegistrable {
    
    @IBOutlet weak var tableView: OwnTableView!
    
    var delegate: TableCacheImageDelegate?
    
    var imageUrlString: [String] = []
    
    var imageLoaded = PublishSubject<Int>()
    
    var cellIndex: Int = 999

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        
    }
    
    /// 再利用時
    override func prepareForReuse() {
        super.prepareForReuse()
        tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(stringUrls: [String], index: Int){
        self.imageUrlString = stringUrls
        self.cellIndex = index
        tableView.reloadData()
    }
    
}

extension TableCacheImageTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrlString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier) as! ImageTableViewCell
        print("cellが再利用\(imageUrlString):\(indexPath.row):\(self.cellIndex)")
        if indexPath.row >= imageUrlString.count {
            return cell
        }
        cell.aspectImageView.loadImageUsingString(urlString: imageUrlString[indexPath.row], completion: {
            if indexPath.row == self.imageUrlString.count - 1 {
                self.delegate?.reloadTable(self.cellIndex)
            }
        })
        return cell
    }
    
}
