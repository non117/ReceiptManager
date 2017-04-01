//
//  AnnotatedText.swift
//  ReceiptManager
//
//  Created by non on 2016/11/23.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

// なまえをかえたいRawTextとかに
public struct AnnotatedText {
    let rect: [Point] // いるんか？
    let text: String
    let fontWidth, fontHeight: Int
    let head, tail, horizontalPosition: Int

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
        self.fontHeight = rect[3].y - rect[0].y
        self.fontWidth = (rect[1].x - rect[0].x) / text.characters.count
        self.horizontalPosition = (self.rect[0].y + self.rect[3].y) / 2
        self.head = self.rect[0].x
        self.tail = self.rect[1].x
    }
    public func isSameLine(nextText: AnnotatedText) -> Bool {
        let minFontHeight = min(nextText.fontHeight, self.fontHeight)
        return abs(nextText.horizontalPosition - self.horizontalPosition) <= minFontHeight
    }
    public func isSequential(nextText: AnnotatedText) -> Bool {
        let maxFontWidth = max(nextText.fontWidth, self.fontWidth)
        let spaceCount = (nextText.head - self.tail) / maxFontWidth
        return spaceCount < 0
    }
}
