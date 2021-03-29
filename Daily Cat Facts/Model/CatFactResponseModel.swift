//
//  CatFactModel.swift
//  Daily Cat Facts
//
//  Created by Adriaan on 2020/02/24.
//  Copyright © 2020 Adriaan. All rights reserved.
//

import Foundation

struct CatFactResponseModel: Decodable {
    var factID: String
    var catFact: String
    
    enum CodingKeys: String, CodingKey {
        case factID = "_id"
        case catFact = "text"
    }
}
