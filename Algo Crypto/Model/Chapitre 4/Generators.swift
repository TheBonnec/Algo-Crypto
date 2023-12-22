//
//  Generators.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData


@Model
class Generators {
    var n: Int?
    var result: [Int]
    
    init(n: Int? = nil, result: [Int] = []) {
        self.n = n
        self.result = result
    }
    
    func setEvery(n: Int?, result: [Int]) {
        self.n = n
        self.result = result
    }
}
