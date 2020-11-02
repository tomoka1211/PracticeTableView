//
//  StoryboardInstantiatable.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2020/04/11.
//  Copyright © 2020 hirano_tomoka. All rights reserved.
//

import Instantiate
import UIKit

typealias StoryboardInstantiatable = Instantiate.StoryboardInstantiatable
typealias InstantiateSource = Instantiate.InstantiateSource
typealias StoryboardName = Instantiate.StoryboardName

extension StoryboardInstantiatable where Self: UIViewController {
    static var storyboardName: StoryboardName {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }
}
