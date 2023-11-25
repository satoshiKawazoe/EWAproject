//
//  LaunchViewController.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2023/01/13.
//
//

import UIKit
import RealmSwift
import IQKeyboardManager

class LaunchViewController: UIViewController {
    
    @IBAction func helpButton_modeSettingViewPressed(_ sender: Any) {
        let overLayer = OverlayoutPopUpViewController()
        overLayer.appear(sender: self)
        overLayer.LevelInstructionLabel.isHidden = false
        overLayer.maxReturnCardsQuantityInstructionLabel.isHidden = true
        overLayer.defaultLevelInstructionLabel.isHidden = true
        overLayer.usualCardQuantityInstructionLabel.isHidden = true
    }
    
    @IBAction func helpButton_maxReturnCardsQuantityPressed(_ sender: Any) {
        let overLayer = OverlayoutPopUpViewController()
        overLayer.appear(sender: self)
        overLayer.LevelInstructionLabel.isHidden = true
        overLayer.maxReturnCardsQuantityInstructionLabel.isHidden = false
        overLayer.defaultLevelInstructionLabel.isHidden = true
        overLayer.usualCardQuantityInstructionLabel.isHidden = true
    }
    
    @IBAction func helpButton_defaultModeSettingViewPressed(_ sender: Any) {
        let overLayer = OverlayoutPopUpViewController()
        overLayer.appear(sender: self)
        overLayer.LevelInstructionLabel.isHidden = true
        overLayer.maxReturnCardsQuantityInstructionLabel.isHidden = true
        overLayer.defaultLevelInstructionLabel.isHidden = false
        overLayer.usualCardQuantityInstructionLabel.isHidden = true
    }
    
    @IBAction func helpButton_usualLearningCardQuantityPressed(_ sender: Any) {
        let overLayer = OverlayoutPopUpViewController()
        overLayer.appear(sender: self)
        overLayer.LevelInstructionLabel.isHidden = true
        overLayer.maxReturnCardsQuantityInstructionLabel.isHidden = true
        overLayer.defaultLevelInstructionLabel.isHidden = true
        overLayer.usualCardQuantityInstructionLabel.isHidden = false
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        ///「スタート」ボタンを押された時の動作. 注意書きのラベルが全て消えているのを確認して画面遷移.
        ///注意書きのラベルが全て消えていることは 3 つの textField が正しく入力されていることを保証する.
        if initalCardNumberTextField_NoteLabel.isHidden == true && lastCardNumberTextField_NoteLabel.isHidden == true && maxReturnCardsQuantityTextField_NoteLabel.isHidden == true {
            cardDataAndLogic!.initialCardNumber = Int(initalCardNumberTextFieild.text!)
            cardDataAndLogic!.lastCardNumber = Int(lastCardNumberTextField.text!)
            cardDataAndLogic!.maxReturnCardsQuantity = Int(maxReturnCardsQuantityTextField.text!)
            cardDataAndLogic!.selectedLevelNumber = modePicker.selectedRow(inComponent: 0)
            performSegue(withIdentifier: "goToLearningField", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLearningField" {
            let destinationVC = segue.destination as! LearningFieldViewController
            destinationVC.cardDataAndLogic = cardDataAndLogic
        }
    }
    
    
    
    @IBOutlet weak var startButton: UIButton! ///「学習を開始」するのボタン
    @IBOutlet weak var initalCardNumberTextFieild: UITextField! ///「番から」の前のテキストフィールド
    @IBOutlet weak var lastCardNumberTextField: UITextField! ///「番まで」の前のテキストフィールド
    @IBOutlet weak var maxReturnCardsQuantityTextField: UITextField! ///「枚で復習モードに入る」の前のテキストフィールド
    @IBOutlet weak var usualLearningCardsQuantityTextField: UITextField!
    @IBOutlet weak var modePicker: UIPickerView! ///開始する学習のレベルを設定するピッカー
    @IBOutlet weak var defaultModePicker: UIPickerView! ///「デフォルトを 〜 モードに」の「〜」部分のピッカー
    @IBOutlet weak var initalCardNumberTextField_NoteLabel: UILabel!
    @IBOutlet weak var maxReturnCardsQuantityTextField_NoteLabel: UILabel!
    @IBOutlet weak var lastCardNumberTextField_NoteLabel: UILabel!
    @IBOutlet weak var usualLearningCardQuantityTextField_NoteLabel: UILabel!
    @IBOutlet weak var alertLabel_startButton_top: UILabel!
    @IBOutlet weak var alertLabel_startButton_bottom: UILabel!
    
    @IBOutlet weak var bankaraButton: UIButton! ///「番から」の文字の下のボタン
    @IBOutlet weak var banmadeButton: UIButton! ///「番まで」の文字の下のボタン
    @IBOutlet weak var helpButton_rangeView: UIButton!
    @IBOutlet weak var helpButton_modeSelectingView: UIButton!
    @IBOutlet weak var helpButton_maxReturnCardNumberSettingView: UIButton!
    @IBOutlet weak var helpButton_defaultModeSettingView: UIButton!
    @IBOutlet var borderLabels: [UILabel]!
    
    let defaults = UserDefaults.standard
    var cardDataAndLogic: CardDataAndLogic? ///ほかのViewControllerから送られてくる.
    var launchBrain: LaunchBrain?
    var maxLastCardNumber: Int?
    var savedSelectedLevelNumber: Int?
    var savedMaxReturnCardsQuantity: Int?
    var savedUsualLearningCardsQuantity: Int?
    var lastCardNumberHasBeenNeverEditted = true ///いつも〜枚学習するの数値は, lastCardNumberTextField が未編集のとき, のみ initalCardNumberTextField の数値から lastCardNumber を計算しlastCardNumberTextField の数値を書き換える. 「学習を開始する」ボタンが押されてから lastCabrdNumberTextField が未編集のときこの変数は true になる.
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            outputText.text = inputText.text
            self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxLastCardNumber = cardDataAndLogic!.allWordsInTextBook_Data!.count
        if let safeSavedS = defaults.value(forKey: "defaultModeNumber") as? Int {
            savedSelectedLevelNumber = safeSavedS
        } else {
            savedSelectedLevelNumber = 0
        }
        if let safeSavedM = defaults.value(forKey: "maxReturnCardQuantity") as? Int {
            savedMaxReturnCardsQuantity = safeSavedM
        } else {
            savedMaxReturnCardsQuantity = 5
        }
        if let x = defaults.value(forKey: "usualLearningCardsQuantity") as? Int {
            if x != 0 {
                savedUsualLearningCardsQuantity = x
            } else {
                savedUsualLearningCardsQuantity = 0
            }
        } else { /// userDefaults にデータが入っていないとき
            savedUsualLearningCardsQuantity = 50
        }
        
        // LaunchBrain構造体を作成
        // LaunchBrain構造体は学習スタートの許可や入力されていない値を入力するように促すラベルの表示を統括
        launchBrain = LaunchBrain(ml: maxLastCardNumber!)
        launchBrain!.i = 1
        launchBrain!.l = maxLastCardNumber
        launchBrain!.m = savedMaxReturnCardsQuantity
        launchBrain!.s = savedSelectedLevelNumber
        launchBrain!.u = savedUsualLearningCardsQuantity
        ///picker の delegate, dataSource を設定
        modePicker.delegate = self
        modePicker.dataSource = self
        defaultModePicker.delegate = self
        defaultModePicker.dataSource = self
        ///textField の delegate を設定
        initalCardNumberTextFieild.delegate = self
        lastCardNumberTextField.delegate = self
        maxReturnCardsQuantityTextField.delegate = self
        usualLearningCardsQuantityTextField.delegate = self
        //デフォルト値をもとにtextFieldやpickerを初期状態にする
        modePicker.selectRow(savedSelectedLevelNumber!, inComponent: 0, animated: false)
        defaultModePicker.selectRow(savedSelectedLevelNumber!, inComponent: 0, animated: false)
        maxReturnCardsQuantityTextField.text = String(savedMaxReturnCardsQuantity!)
        usualLearningCardsQuantityTextField.text = String(savedUsualLearningCardsQuantity!)
        //外観を設定
        makeInitialInterface()
        keyboardBar() ///キーボードの toolBar を作成する.
    }
    
}

//MARK: - UITextFiewldDelegate

extension LaunchViewController: UITextFieldDelegate {
    /// textfieldがタップされてfirstresponderになる前にこのメソッドを呼び出す。trueを返すと編集ができるようになる
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    /// ユーザーがclearボタンを押したときにこのメソッドを呼び出す。trueを返すと textfield内のテキストを全て消去する
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        //編集中の textField の値は LaunchBrain に nil として登録する
        switch textField {
        case initalCardNumberTextFieild:
            launchBrain!.i = nil
        case lastCardNumberTextField:
            launchBrain!.l = nil
        case maxReturnCardsQuantityTextField:
            launchBrain!.m = nil
        case usualLearningCardsQuantityTextField:
            launchBrain!.u = nil
        default:
            print("error")
        }
        return true
    }
    
    /// textfield が firstresponder の役割を終える直前にこのメソッドを呼び出す。trueを返すと役割を終える。
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        // textField の値を LaunchBrain に渡す
        switch textField {
        case initalCardNumberTextFieild:
            launchBrain!.i = Int(initalCardNumberTextFieild.text!)
            initalCardNumberTextField_NoteLabel.text = launchBrain!.alartInitalCardNumberTextFieild()
        case lastCardNumberTextField:
            launchBrain!.l = Int(lastCardNumberTextField.text!)
        case maxReturnCardsQuantityTextField:
            launchBrain!.m = Int(maxReturnCardsQuantityTextField.text!)
        case usualLearningCardsQuantityTextField:
            launchBrain!.u = Int(usualLearningCardsQuantityTextField.text!)
        default:
            print("Error")
        }
        return true
    }
        
}


//MARK: - UIPickerViewDataSource
extension LaunchViewController: UIPickerViewDataSource {
    
    ///pickerView に表示するデータの列の数を与える.
    func numberOfComponents(in pickerView: UIPickerView)
    -> Int {
        return 1
    }
    
    ///pickerView に表示するデータの行の数を与える.
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int)
    -> Int {
        return 3
    }
}


//MARK: - UIPickerViewDelegate
extension LaunchViewController: UIPickerViewDelegate {
    ///pickerに表示するデータを与える
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int)
    -> String? {
        let data = ["Level.1", "Level.2", "Perfect"]
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == defaultModePicker {
            /// picker が操作された時に defaultModeNumber を userDefault に保存する.
            defaults.set(row, forKey: "defaultModeNumber")
        }
    }
}

//MARK: - キーボードの toolBar を作成する関数

extension LaunchViewController {
    // Make a bar on the keyboard.
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
        lastCardNumberTextField.inputAccessoryView = toolBar
        initalCardNumberTextFieild.inputAccessoryView = toolBar
        maxReturnCardsQuantityTextField.inputAccessoryView = toolBar
        usualLearningCardsQuantityTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapOkButton(_ sender: UIButton){
           // キーボードを閉じる
           self.view.endEditing(true)
       }
       @objc func tapCancelButton(_ sender: UIButton){
           // テキストフィールドを空にする
           
       }


}

//MARK: - IBAction と最初のインターフェイスに関する関数

extension LaunchViewController {
    
    func makeInitialInterface() {
        /// TextField のキーボードを設定.
        initalCardNumberTextFieild.keyboardType = UIKeyboardType.numberPad
        lastCardNumberTextField.keyboardType = UIKeyboardType.numberPad
        maxReturnCardsQuantityTextField.keyboardType = UIKeyboardType.numberPad
        usualLearningCardsQuantityTextField.keyboardType = UIKeyboardType.numberPad
        /// 枠線を描く.
        initalCardNumberTextFieild.layer.borderWidth = 1.5
        initalCardNumberTextFieild.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        initalCardNumberTextFieild.layer.cornerRadius = 7.5
        lastCardNumberTextField.layer.borderWidth = 1.5
        lastCardNumberTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lastCardNumberTextField.layer.cornerRadius = 7.5
        maxReturnCardsQuantityTextField.layer.borderWidth = 1.5
        maxReturnCardsQuantityTextField.layer.borderColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        maxReturnCardsQuantityTextField.layer.cornerRadius = 7.5
        usualLearningCardsQuantityTextField.layer.borderWidth = 1.5
        usualLearningCardsQuantityTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        usualLearningCardsQuantityTextField.layer.cornerRadius = 7.5
        startButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        startButton.layer.borderWidth = 1.5
        startButton.layer.cornerRadius = 20
        borderLabels[0].addBorders(edges: [.bottom, .top], color:  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), thickness: 0.7)
        borderLabels[1].addBorders(edges: [.bottom, .top], color:  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), thickness: 0.7)
        borderLabels[2].addBorders(edges: [.bottom], color:  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), thickness: 0.7)
    }
    
    
//MARK: - CertificateVC が "あなたがワンタップで学習に入れるように" LaunchVC の interface を作成する時に呼び出す変数.
/// CertificateVC が "あなたがワンタップで学習に入れるように" LaunchVC の interface を作成する時に呼び出す変数.
    func certificateVCMakeInitialInterface(_ nextLearningModeNumber: Int,
                                           _ initalCardNumber: Int,
                                           _ lastCardNumber: Int) {
        /// モードピッカーを nextLearningMode に設定
        modePicker.selectRow(nextLearningModeNumber, inComponent: 0, animated: false)
        /// defaultModePicker の初期状態を設定
        if let safeDefaultModeNumber = defaults.value(forKey: "defaultModeNumber") as? Int {
            defaultModePicker.selectRow(safeDefaultModeNumber, inComponent: 0, animated: false)
        } else {
            defaultModePicker.selectRow(0, inComponent: 0, animated: false) ///Level.1に設定
        }
        ///「〜番から」の前の textField に初期値を書き込む
        initalCardNumberTextFieild.text = String(initalCardNumber)
        lastCardNumberTextField.text = String(lastCardNumber)
    }

}
