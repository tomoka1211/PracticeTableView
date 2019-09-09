//
//  ValidateViewController.swift
//  PracticeTableView
//
//  Created by hirano_tomoka on 2019/09/09.
//  Copyright © 2019 hirano_tomoka. All rights reserved.
//

import UIKit
import SwiftValidator

class ValidateViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    let validator: Validator = {
        let validator = Validator()
        validator.styleTransformers(success:{ (validationRule) -> Void in
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
            } else if let textField = validationRule.field as? UITextView {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
            }
        }, error:{ (validationError) -> Void in
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            } else if let textField = validationError.field as? UITextView {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        })
        return validator
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addValidate()
        
    }
    
    func addValidate() {
        
        
        validator.registerField(self.nameTextField,errorLabel: self.nameErrorLabel, rules: [RequiredRuleJapanese()])
        
    }
    
    @IBAction func tapValidateButton(_ sender: Any) {
        self.validator.validate(self)
    }
    

}

extension ValidateViewController: ValidationDelegate {
    func validationSuccessful() {
        /// フォームに送信
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        /// field -> UITextField error -> error UILabel
        for(field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
    
}
