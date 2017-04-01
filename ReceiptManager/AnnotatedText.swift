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
    let rect: [Point]
    let text: String
    let fontWidth, fontHeight: Int
    let horizontalPosition: Int

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
        self.fontHeight = rect[3].y - rect[0].y
        self.fontWidth = (rect[1].x - rect[0].x) / text.characters.count
        self.horizontalPosition = (self.rect[0].y + self.rect[3].y) / 2
    }
    public func isSameLine(rval: AnnotatedText) -> Bool {
        let minFontHeight = min(rval.fontHeight, self.fontHeight)
        return abs(rval.horizontalPosition - self.horizontalPosition) <= minFontHeight
    }
}
