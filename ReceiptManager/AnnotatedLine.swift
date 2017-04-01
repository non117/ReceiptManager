//
//  AnnotatedLine.swift
//  ReceiptManager
//
//  Created by non on 2016/12/18.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

// RawLineとかにかえたい
public class AnnotatedLine : NSObject {
    let texts: [AnnotatedText]
    
    init(texts: [AnnotatedText]) {
        self.texts = texts
    }
}
