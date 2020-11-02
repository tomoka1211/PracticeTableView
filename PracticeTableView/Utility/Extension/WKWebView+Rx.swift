//
//  WKWebView+Rx.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/04/11.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import WebKit
import RxSwift
import RxCocoa

extension Reactive where Base: WKWebView {
    var load: Binder<URL> {
        return Binder(self.base) { webView, url in
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    var loadHTMLString: Binder<String> {
        return Binder(self.base) { webView, text in
            webView.loadHTMLString(text, baseURL: nil)
        }
    }
}
