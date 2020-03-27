//
//  Kingfisher+Extension.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/26.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import Kingfisher
import RxSwift

extension KingfisherManager: ReactiveCompatible {}

extension Reactive where Base: KingfisherManager {
    func retrieveImage(with url: URL, options: KingfisherOptionsInfo? = nil) -> Observable<UIImage?> {
        return Observable.create { observer in
            let task = self.base.retrieveImage(with: url, options: options, progressBlock: nil, completionHandler: { image, error, _, _ in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                observer.onNext(image)
                observer.onCompleted()
            })
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

