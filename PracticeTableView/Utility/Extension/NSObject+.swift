//
//  NSObject+.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/04/11.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
