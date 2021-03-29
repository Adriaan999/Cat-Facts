//
//  NetworkManager.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation

class NetworkManager {
    func performRequest(url: String, completion: @escaping (Data?, Error?) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    return completion(nil, error)
                }
                guard let responseData = data else { return }
                return completion(responseData, nil)
            }
            task.resume()
        }
    }
}
