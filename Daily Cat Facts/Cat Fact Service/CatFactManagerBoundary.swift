//
//  CatFactManagerBoundary.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation

typealias FetchCatFactsSuccess = ([CatFactResponseModel]?) -> Void
typealias FetchCatFactsFailure = (Error) -> Void

protocol CatFactManagerBoundary {
    func fetchCatFacts(success: @escaping FetchCatFactsSuccess,
                       failure: @escaping FetchCatFactsFailure)
}
