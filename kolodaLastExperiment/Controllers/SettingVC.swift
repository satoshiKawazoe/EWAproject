//
//  SettingVC.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 30.11.2023.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var usualCardsQuantityTF: UITextField!
    @IBOutlet weak var defaultModePicker: UIPickerView!
    @IBOutlet weak var Level1ExpirationTF: UITextField!
    @IBOutlet weak var level2ExpirationTF: UITextField!
    @IBOutlet weak var perfectExpirationTF: UITextField!
    @IBOutlet weak var masterExpirationTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
