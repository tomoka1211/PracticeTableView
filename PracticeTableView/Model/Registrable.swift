//
//  Registrable.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/10.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit

protocol Registrable: class {
    static var reuseIdentifier: String { get }
}

extension Registrable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol ClassRegistrable: Registrable {
}

protocol NibRegistrable: Registrable {
    static var nib: UINib { get }
}

extension NibRegistrable {
    static var nib: UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
