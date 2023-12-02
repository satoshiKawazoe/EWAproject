//
//  GetSavedVariables.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2.12.2023.
//

import Foundation

struct GetSavedVariables {
    
    let defaults = UserDefaults.standard

    func getSavedSelectedLvNum() -> Int {
        var s = 0
        if let safeSavedS = defaults.value(forKey: "defaultModeNumber") as? Int {
            s = safeSavedS
        } else {
            s = 0
        }
        return s
    }
    
    func getSavedMRCQ() -> Int {
        var m = 0
        if let safeSavedM = defaults.value(forKey: "maxReturnCardQuantity") as? Int {
            m = safeSavedM
        } else {
            m = 5
        }
        return m
    }
    
    func getSavedULCQ() -> Int? {
        var u: Int? = 0
        if let safeSavedU = defaults.value(forKey: "usualLearningCardsQuantity") as? Int {
            if safeSavedU != 0 {
                u = safeSavedU
            } else {
                u = 0
            }
        } else { /// userDefaults にデータが入っていないとき
            u = 50
        }
        return u
    }
    
}
