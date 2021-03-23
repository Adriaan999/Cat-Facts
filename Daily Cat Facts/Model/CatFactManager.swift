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
    private let catFactURL = "https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=500"
    
    func performRequest() {
        if let url = URL(string: catFactURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let response = data {
                    if let catFacts = self.parseJSON(response) {
                        self.delegate?.saveCatFacts(self, catFacts: catFacts)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ catFactData: Data) -> [CatFactResponseModel]? {
        do {
            let json = try JSONSerialization.jsonObject(with: catFactData,
                                                        options: .mutableContainers)
            if let catFactLitst = json as? [[String: Any]] {
                var catFacts = [CatFactResponseModel]()
                for fact in catFactLitst {
                    catFacts.append(CatFactResponseModel(dictionary: fact))
                }
                return catFacts
            }
        } catch {
            print(error)
        }
        return nil
    }
}
