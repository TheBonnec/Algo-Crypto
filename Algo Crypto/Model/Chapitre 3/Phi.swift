//
//  Phi.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData


@Model
class Phi {
    var mode: PhiMode
    var n: Int?
    var p: Int?
    var q: Int?
    var k: Int?
    var result: Int
    
    init(mode: PhiMode = .n, n: Int? = nil, p: Int? = nil, q: Int? = nil, k: Int? = nil, result: Int = 0) {
        self.mode = mode
        self.n = n
        self.p = p
        self.q = q
        self.k = k
        self.result = result
    }
    
    func setEvery(mode: PhiMode, n: Int?, p: Int?, q: Int?, k: Int?, result: Int) {
        self.mode = mode
        self.n = n
        self.p = p
        self.q = q
        self.k = k
        self.result = result
    }
}



enum PhiMode: Int, Codable {
    case n = 0
    case pq = 1
    case nk = 2
}
