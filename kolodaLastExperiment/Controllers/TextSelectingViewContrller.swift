//
//  TextSelectingViewContrller.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2023/02/21.
//

import UIKit
import RealmSwift


class TextSelectingViewController: UIViewController {
    
    
    @IBOutlet weak var textScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
   
    
    lazy var realm = try! Realm()
    var textbook : Results<Textbook>?
    var wordsDataInRealm : Results<WordData>?
    let defaults = UserDefaults.standard
    var cardDataAndLogic : CardDataAndLogic?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textbook = realm.objects(Textbook.self).sorted(byKeyPath: "textNumber")
        
        textScrollView.delegate = self
        configPageControle()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:  "戻る", style:  .plain, target: nil, action: nil) /// 次の画面のBackボタンを"戻る"に変更
        cardDataAndLogic = CardDataAndLogic()
        
    }
    
    @IBAction func B1B2isSelected(_ sender: Any) {
        print("\(textbook)")
        cardDataAndLogic!.selectedTextbook = textbook![0]
        performSegue(withIdentifier: "goToAllWordsVC", sender: nil)
    }
    @IBAction func A2B1isSelected(_ sender: Any) {
        cardDataAndLogic!.selectedTextbook = textbook![1]
        performSegue(withIdentifier: "goToAllWordsVC", sender: nil)
    }
    @IBAction func A1A2isSelected(_ sender: Any) {
        cardDataAndLogic!.selectedTextbook = textbook![2]
        performSegue(withIdentifier: "goToAllWordsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAllWordsVC" {
            let destinationVC = segue.destination as! AllWordsViewController
            destinationVC.cardDataAndLogic = cardDataAndLogic
        }
    }
}


//MARK: - UIScrollViewDelegate

extension TextSelectingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    //configure Page Controle
    func configPageControle() {
        //色
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        //ページ
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
    }
}


