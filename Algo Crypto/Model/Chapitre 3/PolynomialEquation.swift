//
//  PolynomialEquation.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData


@Model
class PolynomialEquation {
    var mode: PolynomialMode
    var a: Int?
    var b: Int?
    var n: Int?
    var p: Int?
    var q: Int?
    var result: Int
    
    init(mode: PolynomialMode = .n, a: Int? = nil, b: Int? = nil, n: Int? = nil, p: Int? = nil, q: Int? = nil, result: Int = 0) {
        self.mode = mode
        self.a = a
        self.b = b
        self.n = n
        self.p = p
        self.q = p
        self.result = result
    }
    
    func setEvery(mode: PolynomialMode, a: Int?, b: Int?, n: Int?, p: Int?, q: Int? , result: Int) {
        self.mode = mode
        self.a = a
        self.b = b
        self.n = n
        self.p = p
        self.q = q
        self.result = result
    }
}


enum PolynomialMode: Int, Codable {
    case n = 0
    case pq = 1
}
