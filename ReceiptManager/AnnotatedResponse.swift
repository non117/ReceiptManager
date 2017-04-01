//
//  AnnotatedResponse.swift
//  ReceiptManager
//
//  Created by non on 2016/10/26.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation
import Himotoki

// こいつらこのクラスにあっていいのか
// 1 struct 1 fileでなくてもよいのか
public struct Point: Decodable, Comparable {
    let x, y: Int

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> Point {
        return try Point(
            x: e <| "x",
            y: e <| "y"
        )
    }
    
    public static func < (lhs: Point, rhs: Point) -> Bool {
        return lhs.x < rhs.x && lhs.y < rhs.y
    }
    
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

public struct Annotation: Decodable {
    let vertices: [Point]
    let text: String

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> Annotation {
        return try Annotation(
            vertices: e <|| ["boundingPoly", "vertices"],
            text: e <| "description"
        )
    }

    public func toAnnotatedText() -> AnnotatedText {
        return AnnotatedText(rect: vertices, text: text)
    }
}

public struct TextAnnotations: Decodable {
    let annotations: [Annotation]

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> TextAnnotations {
        return try TextAnnotations(
            annotations: e <|| "textAnnotations"
        )
    }
}

public struct AnnotatedResponse: Decodable {
    let textAnnotations: [TextAnnotations]

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> AnnotatedResponse {
        return try AnnotatedResponse(
            textAnnotations: e <|| "responses"
        )
    }

    public func toAnnotatedTexts() -> [AnnotatedText] {
        return textAnnotations[0].annotations.map { $0.toAnnotatedText() }
    }
}
