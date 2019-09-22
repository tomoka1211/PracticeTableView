//
//  File.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/04.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

extension UIButton {
    /// TouchFeedBack
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /// FeedBackとして表示するView
        let tapEffectView: UIView = {
            let tapEffectView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            // 円を描画
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.gray.cgColor
            shapeLayer.path = UIBezierPath(ovalIn: tapEffectView.bounds).cgPath
            tapEffectView.layer.addSublayer(shapeLayer)
            tapEffectView.isHidden = true
            return tapEffectView
        } ()
        addSubview(tapEffectView)
        if let point  = touches.first?.location(in: self) {
            tapEffectView.frame.origin = point
            tapEffectView.alpha = 0.3
            tapEffectView.isHidden = false
            tapEffectView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            UIView.animate(withDuration: 0.5,
                           animations: {
                            tapEffectView.alpha = 0
                            tapEffectView.transform = CGAffineTransform(scaleX: 200.0, y: 200.0)
            }) { finished in
                tapEffectView.isHidden = true
                tapEffectView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}

