//
//  UIViewController+Rx.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/04/11.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var dismiss: Binder<Void> {
        return Binder(self.base) { viewController, _ in
            viewController.dismiss(animated: true)
        }
    }
}
