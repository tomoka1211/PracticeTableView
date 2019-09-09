//
//  SwiftValidator+Extension.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/09.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import SwiftValidator

/// 必須バリデーション
open class RequiredRuleJapanese: Rule {

    private var message : String
    
    public init(message : String = "この項目は必須入力です"){
        self.message = message
    }
    
    open func validate(_ value: String) -> Bool {
        return !value.isEmpty
    }
    
    open func errorMessage() -> String {
        return message
    }
}

/// メールアドレスのバリデーション
public class EmailRuleJapanese: RegexRule {
    
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    public convenience init(message : String = "メールアドレスの形式が間違っています"){
        self.init(regex: EmailRuleJapanese.regex, message: message)
    }
}
