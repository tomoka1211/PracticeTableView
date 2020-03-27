//
//  LikePostQuestionViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/01.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

class LikePostQuestionViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTable()
        // Do any additional setup after loading the view.
    }

}

extension LikePostQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTable() {
        self.tableView.register(PostImageTableViewCell.nib, forCellReuseIdentifier: PostImageTableViewCell.reuseIdentifier)
        self.tableView.register(PostTextTableViewCell.nib, forCellReuseIdentifier: PostTextTableViewCell.reuseIdentifier)
        self.tableView.register(PostPickerTableViewCell.nib, forCellReuseIdentifier: PostPickerTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1,6:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostPickerTableViewCell.reuseIdentifier) as! PostPickerTableViewCell
            return cell
        case 2,3:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTextTableViewCell.reuseIdentifier) as! PostTextTableViewCell
            return cell
        case 4,5:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostImageTableViewCell.reuseIdentifier) as! PostImageTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostPickerTableViewCell.reuseIdentifier) as! PostPickerTableViewCell
            return cell

        }
    }
}
