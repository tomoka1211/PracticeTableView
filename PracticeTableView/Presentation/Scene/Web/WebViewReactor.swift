//
//  WebViewReactor.swift
//  NoSchool
//
//  Created by hirano_tomoka on 2020/03/24.
//  Copyright © 2020 inuko. All rights reserved.
//

import RxSwift
import ReactorKit

final class WebViewReactor: Reactor {

    typealias Context = WebViewController.Context
    typealias Action = NoAction

    struct State {
        let context: Context
        let title: String
        let url: URL
    }

    // MARK: - Property
    
    let initialState: State

    // MARK: - Initializer

    init(context: Context, title: String, url: URL) {
        self.initialState = State(context: context, title: title, url: url)
        _ = self.state
    }
}
