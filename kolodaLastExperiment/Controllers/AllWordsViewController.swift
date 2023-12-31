//
//  AllWordsListController.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2023/01/14.
//

import UIKit
import FloatingPanel
import RealmSwift

class AllWordsViewController: UIViewController {
    
    @IBOutlet weak var startLearningButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allWordsListView: UIView!
    
    let defaults = UserDefaults.standard
    let realm = try! Realm()
    var fpc = LaunchFPC()
    var launchVC: LaunchViewController!
    var cardDataAndLogic: CardDataAndLogic?  ///textSelectingViewからtextBookプロパティが埋められた状態で送られてくる
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = cardDataAndLogic?.selectedTextbook?.name
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            outputText.text = inputText.text
            self.view.endEditing(true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "wordCell", bundle: nil), forCellReuseIdentifier: "WordsCell")
        //以下は FloatingPanel に関するコード
        fpc.delegate = self
        configAppearance()
    }
    
    @IBAction func startLearningButtonPressed(_ sender: Any) {
        fpc.move(to: .half, animated: true)
    }
    
    @IBAction func settingButtonIsPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettingVC", sender: nil)
    }
}


//MARK: - FloatingPanelControllerDelegate

extension AllWordsViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FloatingPanelStocksLayout()
    }
    
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y + 6.0
            let maxY = vc.surfaceLocation(for: .tip).y - 6.0
            vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
}


//MARK: - UITableViewDataSource

extension AllWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardDataAndLogic!.allWordsInTextBook_Data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsCell", for: indexPath) as! WordCell
        cell.wordData = cardDataAndLogic!.allWordsInTextBook_Data![indexPath.row]
        return cell
    }
}


// MARK: - 外観に関するコード

extension AllWordsViewController {
    
    func configAppearance() {
        /// LaunchVCをfpcに追加する.
        launchVC = storyboard?.instantiateViewController(withIdentifier: "launch") as? LaunchViewController
        launchVC!.cardDataAndLogic = cardDataAndLogic
        fpc.set(contentViewController: launchVC) /// ここで LaunchVC のインスタンスのViewDidLoad が呼ばれる.
        fpc.addPanel(toParent: self)
        fpc.move(to: .hidden, animated: false)
        /// FloatingPannelの外観を設定する.
        fpc.configLaunchFPC(cardDataAndLogic!)
        ///「スタート」ボタンの外観を設定する.
        startLearningButton.makeStaartLearningButton()
    }
}




