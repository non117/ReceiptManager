//
//  TextConvertService.swift
//  ReceiptManager
//
//  Created by non on 2017/04/02.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct TextConvertService {
    public static func generateLines(texts: [AnnotatedText]) -> [AnnotatedLine] {
        var lines: [AnnotatedLine] = []
        var tmpTexts = [texts.first!]
        var prevText = texts.first!
        for text in texts.dropFirst() {
            if (prevText.isSameLine(nextText: text)) {
                tmpTexts.append(text)
            } else {
                let line = AnnotatedLine(texts: tmpTexts)
                lines.append(line)
                tmpTexts.removeAll()
            }
            prevText = text
        }
        if (tmpTexts.count > 0) {
            let line = AnnotatedLine(texts: tmpTexts)
            lines.append(line)
        }
        return lines
    }

    public static func splitToWords(texts: [AnnotatedText]) -> [String] {
        var words: [String] = []
        var prevText = texts.first!
        var sequenceTexts = [texts.first!]
        for text in texts.dropFirst() {
            if (prevText.isSequential(nextText: text)) {
                sequenceTexts.append(text)
            } else {
                let word = sequenceTexts.map { $0.text }.joined()
                words.append(word)
                sequenceTexts.removeAll()
            }
            prevText = text
        }
        if (sequenceTexts.count > 0) {
            let word = sequenceTexts.map { $0.text }.joined()
            words.append(word)
        }
        return words
    }
}
