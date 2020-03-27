//
//  UIImage+Extension.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/16.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

extension UIImage {
    /// imageの縦横比を返す
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}
