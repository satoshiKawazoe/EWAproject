//
//  extendUITextField.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 1.12.2023.
//

import UIKit

extension UITextField {
    func configTextField() {
        /// TextField の キーボードを作成
        self.keyboardType = UIKeyboardType.numberPad
        keyboardBar()
        /// 枠線を作成
        self.layer.borderWidth = 1.5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 7.5
    }
    
    
    func keyboardBar() {
        // ツールバーのインスタンスを作成
        let toolBar = UIToolbar()

        // ツールバーに配置するアイテムのインスタンスを作成
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapOkButton(_:)))
        okButton.width = 100
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "CANCEL", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapCancelButton(_:)))

            // アイテムを配置
//                toolBar.setItems([flexibleItem, okButton, flexibleItem, cancelButton, flexibleItem], animated: true)
        toolBar.setItems([flexibleItem, okButton, flexibleItem], animated: true)

                // ツールバーのサイズを指定
                toolBar.sizeToFit()

        // テキストフィールドにツールバーを設定
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapOkButton(_ sender: UIButton){
           // キーボードを閉じる
           self.endEditing(true)
       }
    @objc func tapCancelButton(_ sender: UIButton){
           // テキストフィールドを空にする
           
       }

}
