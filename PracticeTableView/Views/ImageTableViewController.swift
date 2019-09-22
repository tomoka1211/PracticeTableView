//
//  ImageTableViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/21.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import Nuke

class ImageTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos: [URL]!
    
    let pipeline = Nuke.ImagePipeline.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// ロードするURLを取得
        photos = demoPhotosURLs

        configureTableView()
    }
}

extension ImageTableViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        cell.backgroundColor = UIColor(white: 235.0 / 255.0, alpha: 1.0)
        
        let imageView = imageViewForCell(cell)
        let request = makeRequest(with: photos[indexPath.row], imageView: imageView)
        var options = makeImageLoadingOptions()
        options.pipeline = self.pipeline
        loadImage(with: request, options: options, into: imageView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func imageViewForCell(_ cell: UITableViewCell) -> UIImageView {
        var imageView: UIImageView! = cell.viewWithTag(15) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(frame: cell.bounds)
            imageView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
            imageView.tag = 15
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            cell.addSubview(imageView!)
        }
        return imageView!
    }
    
    func makeRequest(with url: URL, imageView: UIImageView) -> ImageRequest {
        return ImageRequest(url: url)
    }
    
    func makeImageLoadingOptions() -> ImageLoadingOptions {
        return ImageLoadingOptions(transition: .fadeIn(duration: 0.25))
    }

}
