//
//  NetworkManager.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation

typealias PerformRequestSuccess = (Data) -> Void
typealias PerformRequestFailure = (Error) -> Void

class NetworkManager {
    func performRequest(url: String,
                        successBlock: @escaping PerformRequestSuccess,
                        failureBlock: @escaping PerformRequestFailure) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    return failureBlock(error)
                }
                guard let responseData = data else { return }
                return successBlock(responseData)
            }
            task.resume()
        }
    }
}
