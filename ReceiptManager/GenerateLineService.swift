//
//  GenerateLineService.swift
//  ReceiptManager
//
//  Created by non on 2017/04/01.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct GenerateLineService {
    static public func generate(texts: [AnnotatedText]) -> [AnnotatedLine] {
        var lines: [AnnotatedLine] = []
        var tmpTexts: [AnnotatedText] = []
        var prevText = texts[0]
        for text in texts {
            if (text.isSameLine(rval: prevText)) {
                tmpTexts.append(text)
            } else {
                let line = AnnotatedLine(texts: tmpTexts)
                lines.append(line)
                tmpTexts = []
            }
            prevText = text
        }
        if (tmpTexts.count > 0) {
            let line = AnnotatedLine(texts: tmpTexts)
            lines.append(line)
        }
        return lines
    }
}
