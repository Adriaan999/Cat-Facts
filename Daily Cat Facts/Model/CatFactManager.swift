//
//  CatFactManager.swift
//  Daily Cat Facts
//
//  Created by Adriaan on 2020/02/24.
//  Copyright © 2020 Adriaan. All rights reserved.
//

import Foundation

protocol CatFactManagerDelegate {
    func saveCatFacts(_ CatFactManager: CatFactManager, catFacts: [CatFactResponseModel])
}

class CatFactManager {
    var delegate: CatFactManagerDelegate?
    private let catFactURL = "https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=10"
    
    func performRequest() {
        if let url = URL(string: catFactURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data,
                      let catFacts: [CatFactResponseModel] = try? data.decoded() else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                self.delegate?.saveCatFacts(self, catFacts: catFacts)
            }
            task.resume()
        }
    }
}
