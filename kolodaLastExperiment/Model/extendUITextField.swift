//
//  extendUITextField.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 1.12.2023.
//

import UIKit

extension UITextField {
    func configTextField() {
        self.keyboardType = UIKeyboardType.numberPad
        self.layer.borderWidth = 1.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 7.5
    }
}