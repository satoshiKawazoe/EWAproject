//
//  LaunchFPC.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 30.11.2023.
//

import UIKit
import FloatingPanel

class LaunchFPC: FloatingPanelController {
    
    
    var launchVC : LaunchViewController!
    var cardDataAndLogic: CardDataAndLogic?
    
    
    func configLaunchFPC(_ cardDataAndLogic: CardDataAndLogic) {
        
        self.surfaceView.appearance.cornerRadius = 26.0
        self.surfaceView.appearance.shadows = []
        self.surfaceView.appearance.borderWidth = 1.0 / traitCollection.displayScale
        self.surfaceView.appearance.borderColor = UIColor.black.withAlphaComponent(0.2)
        self.surfaceView.appearance.backgroundColor = .white
        self.surfaceView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.surfaceView.layer.shadowColor = UIColor.black.cgColor
        self.surfaceView.layer.shadowOpacity = 0.6
        self.surfaceView.layer.shadowRadius = 7
    }
}


