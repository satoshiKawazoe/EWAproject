//
//  LaunchBrain.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 25.11.2023.
//

import Foundation

struct LaunchBrain {
    
    let defaults = UserDefaults.standard
    
    var i: Int? // initalCardNumber
    var l: Int? // lastCardNumber
    var m: Int? // maxReterunCardsQuantity
    var u: Int? // usualLearningCardsQuantity
    var s: Int? // selectedLevelNumber
    var ml: Int // lastCardNumber の最大値
    var alartToInitialCardNumber = ""
    var alartToLastCardNumber = ""
    var alartToMaxCardNumber = ""
    
    
    func alartUsualLearningCardsQuantityTextField() -> String {
        if u == nil {
            return "この機能は無効化されています"
        } else if u! < 1 {
            return "この機能は無効化されています"
        } else {
            defaults.set(u, forKey: "usualLearningCardsQuantity")
            return ""
        }
    }
    
    
    // i が正しく入力されると、いつも〜まい学習する、の値 (u) を使ってLastCardNumberを計算し、
    // 1. l に代入し、2. LaunchVC に結果を渡す
    mutating func calculLastCardNum() -> Int {
        if i != nil && i! >= 1 && i! <= ml && u != nil && u! > 1{
            let cl = i! + u! - 1
            if cl > ml {
                l = ml
            } else {
                l = cl
            }
            return l!  //2.
        } else {
            return ml  //2.
        }
    }
    
    
    mutating func canStartLearning() -> Bool {
        if checkIandL() == true && checkM() == true {
            return true
        } else {
            return false
        }
    }
    
    mutating func checkIandL() -> Bool {
        if i != nil && l != nil {
            let ML = ml + 1
            switch (i!, l!) {
            case (1...ml, 1...ml):
                if i! <= l! {
                    alartToInitialCardNumber = ""
                    alartToLastCardNumber = ""
                    print("A")
                    return true
                } else {
                    alartToInitialCardNumber = "正しく値を入力"
                    alartToLastCardNumber = "正しく値を入力"
                    print("B")
                    return false
                }
            
            case(1...ml, ..<1):
                alartToInitialCardNumber = ""
                alartToLastCardNumber = "1〜\(ml)"
                print("C")
                return false
                
            case (1...ml, ML...):
                alartToInitialCardNumber = ""
                alartToLastCardNumber = "1〜\(ml)"
                print("D")
                return false
            case(ML..., 1...ml):
                alartToInitialCardNumber = "1〜\(ml)"
                alartToLastCardNumber = ""
                print("E")
                return false
            case(ML..., 1...ml):
                alartToInitialCardNumber = "1〜\(ml)"
                alartToLastCardNumber = ""
                print("F")
                return false
            default:
                alartToInitialCardNumber = "1〜\(ml)"
                alartToLastCardNumber = "1〜\(ml)"
                print("G")
                return false
            }
        } else {
            
            if i == nil {
                alartToInitialCardNumber = "1〜\(ml)"
                print("H")
            } else {
                alartToInitialCardNumber = ""
                print("I")
            }
            
            if l == nil {
                alartToLastCardNumber = "1〜\(ml)"
                print("J")
            } else {
                alartToLastCardNumber = ""
                print("K")
            }
            return false
        }
    }
    
    mutating func checkM() -> Bool {
        if m == nil {
            alartToMaxCardNumber = "1〜"
            print("L")
            return false
        } else if m! < 1 {
            alartToMaxCardNumber = "1〜"
            print("M")
            return false
        } else {
            alartToMaxCardNumber = ""
            print("N")
            return true
        }
    }
}
