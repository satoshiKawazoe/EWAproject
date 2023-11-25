//
//  LaunchBrain.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 25.11.2023.
//

import Foundation

struct LaunchBrain {
    
//    init(l: Int?, m: Int?, u:Int?, s:Int?, ml: Int) {
//        self.l = l
//        self.m = m
//        self.u = u
//        self.s = s
//        self.ml = ml
//    }
    
    var i: Int? // initalCardNumber
    var l: Int? // lastCardNumber
    var m: Int? // maxReterunCardsQuantity
    var u: Int? // usualLearningCardsQuantity
    var s: Int? // selectedLevelNumber
    var ml: Int // lastCardNumber の最大値
    var initalCardNumberIsCorrect = false
    var lastCardNumberIsCorrect = false
    var maxReterunCardsQuantityIsCorrect = false
    
    mutating func alartInitalCardNumberTextFieild() -> String {
        if i == nil {
            return "1〜\(ml)"
        } else if i! < 1 {
            return "1〜\(ml)"
        } else if i! > 1 && i! > ml {
            return "1~\(ml)"
        } else if i! > 1 && i! > l ?? ml {
            return "1~\(l ?? ml)"
        } else {
            initalCardNumberIsCorrect = true
            return ""
        }
    }
    
    mutating func alartLastCardNumberTextField() -> String {
        if l == nil {
            return "1〜\(ml)"
        } else if l! < 1 {
            return "1〜\(ml)"
        } else if l! > 1 && l! > ml {
            return "1〜\(ml)"
        } else if l! > 1 && l! < i ?? 1 {
            return "\(i ?? 1)〜\(ml)"
        } else {
            lastCardNumberIsCorrect = true
            return ""
        }
    }
    
    mutating func alartMaxReturnCardsQuantityTextField() -> String {
        if m == nil {
            return "1〜"
        } else if m! < 1 {
            return "1〜"
        } else {
            maxReterunCardsQuantityIsCorrect = true
            return ""
        }
    }
    
    func alartUsualLearningCardsQuantityTextField() -> String {
        if u == nil {
            return "この機能は無効化されています"
        } else if u! < 1 {
            return "この機能は無効化されています"
        } else {
            return ""
        }
    }
    
    func canStartLearning() -> Bool {
        if initalCardNumberIsCorrect == true && lastCardNumberIsCorrect == true && maxReterunCardsQuantityIsCorrect == true {
            return true
        } else {
            return false
        }
    }
}
