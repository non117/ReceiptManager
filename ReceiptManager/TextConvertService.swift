//
//  TextConvertService.swift
//  ReceiptManager
//
//  Created by non on 2017/04/02.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct TextConvertService {
    // フォントの高さをもとに同じ行の文字を集める処理
    public static func generateLines(texts: [RawText]) -> [RawLine] {
        var lines: [RawLine] = []
        var tmpTexts = [texts.first!]
        var prevText = texts.first!
        for text in texts.dropFirst() {
            if prevText.isSameLine(nextText: text) {
                tmpTexts.append(text)
            } else {
                let line = RawLine(texts: tmpTexts)
                lines.append(line)
                tmpTexts.removeAll()
                tmpTexts.append(text)
            }
            prevText = text
        }
        if tmpTexts.count > 0 {
            let line = RawLine(texts: tmpTexts)
            lines.append(line)
        }
        return lines
    }
}
