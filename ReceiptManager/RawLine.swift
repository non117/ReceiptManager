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
                let lastWord = words.last!
                let priceStrings = priceSymbols.filter(lastWord.contains).map { lastWord.replacingOccurrences(of: $0, with: "") }
                // 最後以外を商品名とする
                return priceStrings.flatMap{ Int($0) }.map { Product(price: $0, name: words.dropLast().joined()) }.first

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
        let separatedLasts = priceSymbols.map { lineText.components(separatedBy: $0) }.filter { $0.count > 1 }.flatMap { $0.last }
        return separatedLasts.map { $0.characters.filter { $0 >= "0" && $0 <= "9" }.count > 0 }.contains(true)
    }

    private func parseDateString(dateString: String) -> Date? {
        return dateFormats.map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }.flatMap { $0.date(from: dateString) }.first
    }
    // そのうち店の名前判定を辞書をもとにおこないたい
}
