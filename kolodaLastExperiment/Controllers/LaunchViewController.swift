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
    @IBOutlet weak var helpButton_modeSelectingView: UIButton!
    @IBOutlet weak var helpButton_maxReturnCardNumberSettingView: UIButton!
    @IBOutlet weak var helpButton_defaultModeSettingView: UIButton!
    @IBOutlet var borderLabels: [UILabel]!
    
    
    let defaults = UserDefaults.standard
    var getSavedVariables = GetSavedVariables() /// UserDefaultからデータを取得する関数が入った構造体
    var cardDataAndLogic: CardDataAndLogic? ///ほかのViewControllerから送られてくる.
    var launchBrain: LaunchBrain? ///"学習をスタートする"ボタンが押されたとき, 許可を出す構造体
    var maxLastCardNumber: Int? ///
    var savedSelectedLevelNumber: Int?
    var savedMaxReturnCardsQuantity: Int?
    var savedUsualLearningCardsQuantity: Int?
    var lastCardNumIsEdited = false ///いつも〜枚学習するの数値は, lastCardNumberTextField が未編集のとき, のみ initalCardNumberTextField の数値から lastCardNumber を計算しlastCardNumberTextField の数値を書き換える. 「学習を開始する」ボタンが押されてから lastCabrdNumberTextField が未編集のときこの変数は true になる.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            outputText.text = inputText.text
            self.view.endEditing(true)
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
                
        maxLastCardNumber = cardDataAndLogic!.allWordsInTextBook_Data!.count
        /// userDafault に保存されているデータを取得
        savedSelectedLevelNumber = getSavedVariables.getSavedSelectedLvNum()
        savedMaxReturnCardsQuantity = getSavedVariables.getSavedMRCQ()
        savedUsualLearningCardsQuantity = getSavedVariables.getSavedULCQ()
        /// LaunchBrain構造体を作成
        /// LaunchBrain構造体は学習スタートの許可や入力されていない値を入力するように促すラベルの表示を統括
        launchBrain = LaunchBrain(i: 1, l: maxLastCardNumber, m: savedMaxReturnCardsQuantity, u: savedUsualLearningCardsQuantity, s: savedSelectedLevelNumber!,ml: maxLastCardNumber!)
        
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
        initalCardNumberTextFieild.text = String(1)
        lastCardNumberTextField.text = String(maxLastCardNumber!)
        modePicker.selectRow(savedSelectedLevelNumber!, inComponent: 0, animated: false)
        defaultModePicker.selectRow(savedSelectedLevelNumber!, inComponent: 0, animated: false)
        maxReturnCardsQuantityTextField.text = String(savedMaxReturnCardsQuantity!)
        usualLearningCardsQuantityTextField.text = String(savedUsualLearningCardsQuantity!)
        //枠線を設定
        makeInitialInterface()
    }
    
}

//MARK: - TextFiewldDelegate

extension LaunchViewController: UITextFieldDelegate {
    /// textfieldがタップされてfirstresponderになる前にこのメソッドを呼び出す。trueを返すと編集ができるようになる
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    /// ユーザーがclearボタンを押したときにこのメソッドを呼び出す。trueを返すと textfield内のテキストを全て消去する
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
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
    
    /// ユーザーが TextField に変更を加えるたびに発動される。
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        /// 1. 編集中の textField の値は LaunchBrain に nil として登録する
        /// ※ 編集中に スタートボタンを押されても 学習が開始されないようにするため。
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
        /// 1. textField の値を LaunchBrain に渡す
        /// 2. 何も入力されていないか範囲外の値の値である場合警告を出す。
        switch textField {
        case initalCardNumberTextFieild:
            launchBrain!.i = Int(initalCardNumberTextFieild.text!)
            ///もし LastCardNum が未編集で、InitialCardNum が正しく入力された場合、usualLearningCardQuantity の値を使って LastCardNum を計算し自動で LastCardNumTextField に入力する
            if lastCardNumIsEdited == false {
                lastCardNumberTextField.text = String(launchBrain!.calculLastCardNum())
            }
            /// initialCardNumberTextField_NoteLabel.text = これは スタートボタンが押されたときに決定する
        case lastCardNumberTextField:
            launchBrain!.l = Int(lastCardNumberTextField.text!)
            lastCardNumIsEdited = true  ///LastCardNum が未編集でないことを記録する
            /// lastCardNumberTextField_NoteLabel.text = これは スタートボタンが押されたときに決定する
        case maxReturnCardsQuantityTextField:
            let m = Int(maxReturnCardsQuantityTextField.text!)
            launchBrain!.m = m
            defaults.set(m, forKey: "maxReturnCardQuantity") //これはスタートボタンが押されたときに実行すべきかも
            ///maxReturnCardsQuantityTextField_NoteLabel.text = これは スタートボタンが押されたときに決定する
        case usualLearningCardsQuantityTextField:
            let u = Int(usualLearningCardsQuantityTextField.text!)
            launchBrain!.u = u
            defaults.set(u, forKey: "usualLearningCardsQuantity")
            usualLearningCardQuantityTextField_NoteLabel.text = launchBrain!.alartUsualLearningCardsQuantityTextField()
        default:
            print("Error")
        }
        
        return true
    }
        
}


// MARK: - PickerViewDataSource

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


//MARK: - PickerViewDelegate
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


//MARK: - 枠線に関する関数

extension LaunchViewController {
    
    func makeInitialInterface() {
        /// TextField のキーボードを設定.
        initalCardNumberTextFieild.configTextField()
        lastCardNumberTextField.configTextField()
        maxReturnCardsQuantityTextField.configTextField()
        usualLearningCardsQuantityTextField.configTextField()
        startButton.makeLaunchButton()
        for i in 0...2 {
            borderLabels[i].addBorders(edges: [.bottom, .top], color:  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), thickness: 0.7)
        }
    }
}
    
// MARK: - IBAction
extension LaunchViewController {
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
        if launchBrain?.canStartLearning() == true {
            cardDataAndLogic!.initialCardNumber = Int(initalCardNumberTextFieild.text!)
            cardDataAndLogic!.lastCardNumber = Int(lastCardNumberTextField.text!)
            cardDataAndLogic!.maxReturnCardsQuantity = Int(maxReturnCardsQuantityTextField.text!)
            cardDataAndLogic!.selectedLevelNumber = modePicker.selectedRow(inComponent: 0)
//            initalCardNumberTextField_NoteLabel.text = ""
//            lastCardNumberTextField_NoteLabel.text = ""
//            maxReturnCardsQuantityTextField_NoteLabel.text = ""
            performSegue(withIdentifier: "goToLearningField", sender: nil)
            print("LaunchVC, StartButtonPressed")
        } else {
            initalCardNumberTextField_NoteLabel.text = launchBrain?.alartToInitialCardNumber
            lastCardNumberTextField_NoteLabel.text = launchBrain?.alartToLastCardNumber
            maxReturnCardsQuantityTextField_NoteLabel.text = launchBrain?.alartToMaxCardNumber
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLearningField" {
            let destinationVC = segue.destination as! LearningFieldViewController
            destinationVC.cardDataAndLogic = cardDataAndLogic
        }
    }
}
    
    
//MARK: - CertificateVC が "あなたがワンタップで学習に入れるように" LaunchVC の interface を作成する時に呼び出す変数.

extension LaunchViewController {
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

