//
//  OCRClient.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct OCRClient {
    static let HOST = "https://vision.googleapis.com"
    static let ANNOTATE_API = "/v1/images:annotate"
    let apiKey: String
    let session: URLSession

    init(apiKey: String){
        self.apiKey = apiKey
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }

    // MARK: - main request method
    func annotate(imageData: Data, responseHandler: @escaping (AnnotatedResponse?) -> Void) {
        let parameters: [String: Any] = [
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

        var request = URLRequest(url: url()!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        let task = session.dataTask(with: request, completionHandler: { (body: Data?, response: URLResponse?, error: Error?) in
            if let data = body {
                let jsonData = try? JSONSerialization.jsonObject(with: data)
                let annotatedResponse = try? AnnotatedResponse.decodeValue(jsonData!)
                responseHandler(annotatedResponse)
            }
            self.session.invalidateAndCancel()
        })
        task.resume()
    }

    // MARK: - convenience request
    func annotate(imagePath: URL, responseHandler: @escaping (AnnotatedResponse?) -> Void) {
        let image = try! Data(contentsOf: imagePath)
        annotate(imageData: image, responseHandler: responseHandler)
    }

    // MARK: - url generation
    private func url() -> URL? {
        let queryItem = URLQueryItem(name: "key", value: apiKey)
        var urlComponents = URLComponents(string: OCRClient.HOST + OCRClient.ANNOTATE_API)
        urlComponents?.queryItems = [queryItem]
        return urlComponents?.url
    }
}
