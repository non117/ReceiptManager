//
//  RawLine.swift
//  ReceiptManager
//
//  Created by non on 2016/12/18.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct RawLine {
    let lineText: String
    private let pricePattern = "([\\d+,]+円)|(￥[\\d+,]+)"
    private let priceReplaceSymbols = ["円", "￥", ","]
    private let datePattern = "(20\\d\\d-\\d\\d?-\\d\\d?)|(20\\d\\d年\\d\\d?月\\d\\d?日)"
    private let dateFormats = ["yyyy-MM-dd", "yyyy年MM月dd日"]
    
    init(texts: [RawText]) {
        self.lineText = texts.map{ $0.text }.joined()
    }
    
    var product: Product? {
        get {
            let regex = try! NSRegularExpression(pattern: pricePattern)
            let range = NSRange(location: 0, length: lineText.characters.count)
            if let match = regex.matches(in: lineText, range: range).first {
                let priceString = (lineText as NSString).substring(with: match.range)
                let restString = lineText.replacingOccurrences(of: priceString, with: "")
                return parsePriceString(priceString: priceString).map { Product(price: $0, name: restString) }

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
    
    private func parsePriceString(priceString: String) -> Int? {
        let cleanString = priceReplaceSymbols.reduce(priceString, {(reducedString, symbol) in
            reducedString.replacingOccurrences(of: symbol, with: "")
        })
        return Int(cleanString)
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
