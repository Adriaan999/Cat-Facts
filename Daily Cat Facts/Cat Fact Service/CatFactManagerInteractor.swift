//
//  CatFactManagerInteractor.swift
//  Daily Cat Facts
//
//  Created by Adriaan on 2020/02/24.
//  Copyright © 2020 Adriaan. All rights reserved.
//

import Foundation


class CatFactManagerInteractor: CatFactManagerBoundary {
    
    private let catFactURL = "https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=10"
    private let networkManager = NetworkManager()
    
    func fetchCatFacts(success: @escaping FetchCatFactsSuccess,
                       failure: @escaping FetchCatFactsFailure) {
        networkManager.performRequest(url: catFactURL, successBlock: { (data) in
            guard let catFacts: [CatFactResponseModel] = try? data.decoded() else {
                //TODO: - Refactor error handeling
                let errorDescription = "A localized description of an error"
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                failure(error)
                return
            }
            success(catFacts)
        }, failureBlock: { (error) in
            print(error.localizedDescription)
            return
        })
    }
}
