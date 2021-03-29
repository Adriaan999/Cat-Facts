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
    private let networkManager = NetworkManager()
    
    func fetchCatFacts() {
        networkManager.performRequest(url: catFactURL) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                  let catFacts: [CatFactResponseModel] = try? data.decoded() else {
                print("Decoding failed")
                return
            }
            self.delegate?.saveCatFacts(self, catFacts: catFacts)
        }
    }
}
