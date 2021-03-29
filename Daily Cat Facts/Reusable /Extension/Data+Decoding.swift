//
//  Data+Decoding.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/29.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import Foundation

public extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
