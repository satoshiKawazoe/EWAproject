//
//  HinshColor.swift
//  kolodaLastExperiment
//
//  Created by Satoshi Kawazoe on 2.12.2023.
//

import UIKit

class HinshiColor {
    
    let meishiColor =  #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
    let tadoshiColor =  #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
    let jidoshiColor =  #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
    let keiyoshiColor =  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    let hukushiColor =  #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    let zenchishiColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    let setsuzokushiColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    
    static func getHinshiColor(_ hinshi: String?) -> UIColor {
        switch hinshi {
        case "名詞": return #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
        case "他動詞": return #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        case "自動詞": return #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        case "形容詞": return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case "副詞": return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "前置詞": return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case "接続詞": return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        default: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
