//
//  RawText.swift
//  ReceiptManager
//
//  Created by non on 2016/11/23.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct RawText {
    let text: String
    let fontWidth, fontHeight: Int
    let head, tail, horizontalPosition: Int

    init(rect: [Point], text: String) {
        self.text = text
        self.fontHeight = rect[3].y - rect[0].y
        self.fontWidth = (rect[1].x - rect[0].x) / text.characters.count
        self.horizontalPosition = (rect[0].y + rect[3].y) / 2
        self.head = rect[0].x
        self.tail = rect[1].x
    }
    public func isSameLine(nextText: RawText) -> Bool {
        let minFontHeight = min(nextText.fontHeight, self.fontHeight)
        return abs(nextText.horizontalPosition - self.horizontalPosition) <= minFontHeight
    }
    public func isSequential(nextText: RawText) -> Bool {
        let maxFontWidth = max(nextText.fontWidth, self.fontWidth)
        let spaceCount = (nextText.head - self.tail) / maxFontWidth
        return spaceCount < 0
    }
}
