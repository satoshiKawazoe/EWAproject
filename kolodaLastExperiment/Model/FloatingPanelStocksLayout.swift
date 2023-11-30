//
//  FloatingPanel.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2023/04/05.
//

import UIKit
import FloatingPanel

/// anchorsプロパティでFloatingPanelがどれくらい移動するかを指定する。例えば、.full: FloatingPanelLayoutAnchor(absoluteInset: UIScreen.main.bounds.size.height * 0.25 / 1, edge: .top, referenceGuide: .safeArea) の height * の後ろの数値
///LaunchViewControllerでつかうFloatingPanelの位置を決定する.  FloatingPanelControllerDelegate の func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout の返り値に使う.
///
class FloatingPanelStocksLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    //以下の変数anchorsを用いてfloatingPanelが作られる
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 540, edge: .bottom, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 285, edge: .bottom, referenceGuide: .safeArea),
             /* Visible + ToolView */
        .tip: FloatingPanelLayoutAnchor(absoluteInset: -5, edge: .bottom, referenceGuide: .superview),
        ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}


