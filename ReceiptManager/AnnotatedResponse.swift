//
//  AnnotatedResponse.swift
//  ReceiptManager
//
//  Created by non on 2016/10/26.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation
import Himotoki

public struct Point: Decodable {
    let x, y: Int

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> Point {
        return try Point(
            x: e <| "x",
            y: e <| "y"
        )
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
    let responses: [TextAnnotations]

    // MARK: Decodable
    public static func decode(_ e: Extractor) throws -> AnnotatedResponse {
        return try AnnotatedResponse(
            responses: e <|| "responses"
        )
    }
}
