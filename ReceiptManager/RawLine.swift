//
//  RawLine.swift
//  ReceiptManager
//
//  Created by non on 2016/12/18.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct RawLine {
    let texts: [RawText]
    let lineText: String
    let words: [String]
    private let priceSymbols = ["円", "￥"]
    private let datePattern = "(20\\d\\d-\\d\\d?-\\d\\d?)|(20\\d\\d年\\d\\d?月\\d\\d?日)"
    private let dateFormats = ["yyyy-MM-dd", "yyyy年MM月dd日"]
    
    init(texts: [RawText]) {
        self.texts = texts
        self.lineText = texts.map{ $0.text }.joined()
        self.words = TextConvertService.splitToWords(texts: texts)
    }
    
    var product: Product? {
        get {
            if self.includesPrice() {
                // お値段ぽいなら最後の塊が値段なはず
                // replaceできたらwords.lastが変わっているはず
                let lastWord = words.last!
                let priceString = priceSymbols.map { lastWord.replacingOccurrences(of: $0, with: "") }.filter { $0 != lastWord }.first!
                if let price = Int(priceString) {
                    // 最後以外を商品名とする
                    let name = words.dropLast().joined()
                    return Product(price: price, name: name)
                }
            }
            return nil
        }
    }
    var date: Date? {
        get {
            let regex = try! NSRegularExpression(pattern: datePattern)
            let range = NSRange(location: 0, length: lineText.characters.count)
            if let match = regex.matches(in: lineText, range: range).first {
                let dateString = (lineText as NSString).substring(with: match.range)
                return parseDateString(dateString: dateString)
                
            }
            return nil
        }
    }
    
    // ￥か円で分割されたテキストの最後の塊が数字っぽければtrue
    private func includesPrice() -> Bool {
        for symbol in priceSymbols {
            let splits = lineText.components(separatedBy: symbol)
            // symbolで分割できたら処理される
            if let lastSplit = splits.last {
                let numCount = lastSplit.characters.filter{ $0 >= "0" && $0 <= "9" }.count
                if numCount > 0 {
                    return true
                }
            }
        }
        return false
    }
    private func parseDateString(dateString: String) -> Date? {
        for format in dateFormats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            // パースできたほうのフォーマットで即時にDateがかえる
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        return nil
    }
    // そのうち店の名前判定を辞書をもとにおこないたい
}
