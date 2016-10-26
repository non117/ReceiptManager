//
//  OCRClient.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation
import Alamofire

public class OCRClient {
    let HOST = "https://vision.googleapis.com"
    let ANNOTATE_API = "/v1/images:annotate"
    var api_key: String

    init(api_key: String){
        self.api_key = api_key
    }

    // MARK: - main request method
    func request(image: Data) {
        let parameters: Parameters = [
            "requests": [
                "image": [
                    "content": image.base64EncodedString()
                ],
                "features": [
                    [
                        "type": "TEXT_DETECTION",
                        "maxResults": 2
                    ]
                ]
            ]
        ]

        let url = HOST + ANNOTATE_API + "?key=" + api_key
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON {
            response in
            if let json = response.result.value {
                print(json)
            }
        }
    }

    // MARK: - convenience request
    func request(imagePath: URL) {
        let image = try! Data.init(contentsOf: imagePath)
        request(image: image)
    }
}
