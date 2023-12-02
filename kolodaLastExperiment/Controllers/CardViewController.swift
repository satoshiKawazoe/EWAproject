//
//  Container_VC.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2022/12/31.
//
import UIKit

protocol CardViewControllerDelegate {
    func showTipButtonIsTappedInCardVC()
    func showAnswerButtonIsTappedInCardVC()
    func checkAnswerIsShown() -> Bool
}

class CardViewController: UIViewController {
    
    @IBOutlet weak var wordNumberLabel: UILabel!
    @IBOutlet weak var hinshiLabel: UILabel!
    @IBOutlet weak var mainWordLabel: UILabel!
    @IBOutlet weak var initalHiraganaLabel: UILabel!
    @IBOutlet weak var subWordLabel: UILabel!
    @IBOutlet weak var tipImageView: UIImageView!
    @IBOutlet weak var seeTipButton: UIButton!
    @IBOutlet weak var cardFrameStackView: UIStackView!
    @IBOutlet weak var centerFrameView: UIView!
    
    var wordData: WordData?
    var delegate: CardViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// wordData をもとに設定するパーツ
        wordNumberLabel.text = String(wordData!.wordNumber)
        mainWordLabel.text = wordData!.english
        subWordLabel.text = wordData!.english
        initalHiraganaLabel.text = wordData!.firstHiragana
        tipImageView.image = UIImage(named: wordData!.english)
        hinshiLabel.text = wordData!.hinshi
        hinshiLabel.backgroundColor = HinshiColor.getHinshiColor(wordData?.hinshi)
        hinshiLabel.layer.cornerRadius = 5
        /// 表示 / 非表示に関するコード
        tipImageView.isHidden = true
        subWordLabel.isHidden = true
        ///枠線に関するコード
        cardFrameStackView.makeCardFrameStackView()
        seeTipButton.makeSeeTipButton()
        centerFrameView.makeCenterFrameView()
    }
   
    
    //MARK: - IBAction
    ///答えを見るためのボタンを押した時の処理
    @IBAction func seeAnswerButtonPressed(_ sender: Any) {
        if delegate?.checkAnswerIsShown() == false { ///答えがまだ表示されていない時だけ回転できるようにする. 
            UIView.transition(with: cardFrameStackView,
                                              duration: 0.2,
                                              options: [.transitionFlipFromLeft],
                                              animations: {
                self.showAnswer()
                                              },
                                              completion: nil)
            delegate?.showAnswerButtonIsTappedInCardVC()
        }
    }
    ///"ヒントを見る"ボタンが押された時の処理
    @IBAction func seeTipButtonPressed(_ sender: Any) {
        UIView.transition(with: self.cardFrameStackView,
                              duration: 0.2,
                              options: [.transitionFlipFromLeft],
                              animations: {
                self.showTipImage()
            },
                              completion: nil)
        delegate?.showTipButtonIsTappedInCardVC()
    }
    
    ///カードのインターフェイスをヒントが表示された状態にするためのコード.
    func showTipImage() {
        ///表示 / 非表示に関するコード
        seeTipButton.isHidden = true
        subWordLabel.isHidden = false
        tipImageView.isHidden = false
    }
    
    ///カードのインターフェイスを答えが表示された状態にするためのコード.
    func showAnswer() {
        /// wordData を参照して設定するパーツ
        mainWordLabel.text = wordData?.japanese
        ///表示 / 非表示に関するコード
        seeTipButton.isHidden = true
        subWordLabel.isHidden = false
        tipImageView.isHidden = false
    }
    
}



    

