//
//  CatFactModel.swift
//  Daily Cat Facts
//
//  Created by Adriaan on 2020/02/24.
//  Copyright © 2020 Adriaan. All rights reserved.
//

import Foundation

struct CatFactResponseModel {
    private(set) var fact: String?
    init(dictionary: [AnyHashable : Any]) {
        if let factText = dictionary["text"] as? String {
            self.fact = factText
        }
    }
}

