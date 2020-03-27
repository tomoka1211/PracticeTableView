//
//  UIImageView+Extension.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/10/03.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingString(urlString: String, completion: (() -> ())?) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                self.image = imageToCache
                completion?()
            })
            }).resume()
    }
    
    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }
}
