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
                        success: @escaping PerformRequestSuccess,
                        failure: @escaping PerformRequestFailure) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    return failure(error)
                }
                guard let responseData = data else { return }
                return success(responseData)
            }
            task.resume()
        }
    }
}
