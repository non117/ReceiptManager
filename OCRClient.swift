//
//  OCRClient.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation
import Alamofire

public struct OCRClient {
    static let HOST = "https://vision.googleapis.com"
    static let ANNOTATE_API = "/v1/images:annotate"
    let apiKey: String

    init(apiKey: String){
        self.apiKey = apiKey
    }

    // MARK: - main request method
    func annotate(imageData: Data) -> AnnotatedResponse? {
        let parameters: Parameters = [
            "requests": [
                "image": [
                    "content": imageData.base64EncodedString()
                ],
                "features": [
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 2
                    ]
                ]
            ]
        ]

        // TODO: NSURLかなにかで結合する
        let url = OCRClient.HOST + OCRClient.ANNOTATE_API + "?key=" + apiKey
        //var annotatedResonse: AnnotatedResponse?
        // TODO: NSURLSessionで書き換える
        // 非同期実行される可能性があるのでコールバックで値を受け取るべき
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON {
            response in
            if let json = response.result.value {
                let annotatedResonse = try? AnnotatedResponse.decodeValue(json)
            }
        }
        return nil//annotatedResonse
    }

    // MARK: - convenience request
    func annotate(imagePath: URL) -> AnnotatedResponse? {
        let image = try! Data(contentsOf: imagePath)
        return annotate(imageData: image)
    }
}
