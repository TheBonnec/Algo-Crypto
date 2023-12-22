//
//  OrderInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData


@Model
class OrderInZ {
    var n: Int?
    var k: Int?
    var result: Int
    
    init(n: Int? = nil, k: Int? = nil, result: Int = -1) {
        self.n = n
        self.k = k
        self.result = result
    }
    
    func setEvery(n: Int?, k: Int?, result: Int) {
        self.n = n
        self.k = k
        self.result = result
    }
}
