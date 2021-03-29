//
//  CatFactViewModel.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation

protocol CatFactViewModelDelegate {
    func didFetchFacts(withFact catFact: [CatFactResponseModel])
}

class CatFactViewModel {
    private var interactor: CatFactManagerBoundary
    private var delegate: CatFactViewModelDelegate
    
    init(interactor: CatFactManagerBoundary,
         delegate: CatFactViewModelDelegate) {
        self.interactor = interactor
        self.delegate = delegate
    }
    
    func fetchCatFacts() {
        interactor.fetchCatFacts { (response) in
            if let facts = response {
                self.delegate.didFetchFacts(withFact: facts)
            }
        } failure: { (error) in
            print("error fetching facts")
        }

    }
}
