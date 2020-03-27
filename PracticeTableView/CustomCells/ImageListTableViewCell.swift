//
//  ImageListTableViewCell.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/23.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SDWebImage
import MaterialComponents.MaterialInk

class ImageListTableViewCell: UITableViewCell, NibRegistrable {
    
    @IBOutlet weak var tableView: OwnTableView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    var imageBinded = PublishSubject<Void>()
    var imageLoaded = PublishSubject<Void>()
    
    var loaded = false
    
    let disposeBag = DisposeBag()
    
    var images: [UIImage] = []
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ImageListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier) as! ImageTableViewCell
        cell.aspectImageView.image = images[indexPath.row]
        cell.layoutIfNeeded()
        self.ripple(view: cell)
        //cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func ripple(view:UIView){
        let ripple = CATransition()
        ripple.type = CATransitionType(rawValue: "rippleEffect")
        ripple.duration = 0.5
        view.layer.add(ripple, forKey: nil)
    }
    
    func bindImageUrls(urls: [URL]) {
        if self.loaded {
            return
        } else {
            self.loaded.toggle()
        }
        ///Todo: URL to UIImageにするメソッドを考える
        print(urls.count)
        self.imageLoaded.subscribe(onNext: {[weak self] in
            self?.bindImage(self?.images ?? [])
        }).disposed(by: disposeBag)
        loadImage(urls: urls)
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
    }
    
    /// imagesの設定とtableViewのリロード
    func bindImage(_ images: [UIImage]) {
        UIView.animate(withDuration: 0.0, animations:{
            self.tableHeight.constant = CGFloat(images.count * 110)
            print(self.tableView.contentSize.height)
            self.tableView.reloadData()
        }, completion:{ [weak self] finished in
            if (finished) {
                self?.imageBinded.onNext(())
            }
        });
    }
    
    func loadImage(urls: [URL]) {
        DispatchQueue.main.async {
            if urls.count <= 9 {
                Observable.zip(
                    urls.map { KingfisherManager.shared.rx.retrieveImage(with: $0, options: [
                        .processor(DownsamplingImageProcessor(size: UIScreen.main.bounds.size)),
                        .scaleFactor(UIScreen.main.scale),
                        .targetCache(ImageCache.default)
                        ]) }
                    ).subscribe(onNext: {[weak self] images in
                        self?.images = images.compactMap { $0 }
                        /// 画像ロードしたことを通知
                        self?.imageLoaded.onNext(())
                    }).disposed(by: self.disposeBag)
            } else {
                self.syncImage(urls: urls)
            }
        }
    }
    
    /// urlを受け取って画像を追加する
    func syncImage(urls: [URL]) {
        for url in urls {
            KingfisherManager.shared.retrieveImage(with: url, options: [
                .targetCache(ImageCache.default)
            ]) { result in
                // Do something with `result`
                switch result {
                case .success(let value):
                    self.images.append(value.image)
                case .failure(let error):
                    print(error)
                }
                if self.images.count == urls.count {
                    self.imageLoaded.onNext(())
                }
            }
        }
    }
    
    /// imageCellの大きさを可変に
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
