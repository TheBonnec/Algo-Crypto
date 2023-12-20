//
//  Congruence.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import Foundation
import SwiftData


@Model
final class Congruence {
    var a: Int?
    var p: Int?
    var b: Int?
    var q: Int?
    var n: Int?
    var result: Int
    
    
    init(a: Int? = nil, p: Int? = nil, b: Int? = nil, q: Int? = nil, n: Int? = nil, result: Int = 0) {
        self.a = a
        self.p = p
        self.b = b
        self.q = q
        self.n = n
        self.result = result
    }
    
    func setEvery(a: Int?, p: Int?, b: Int?, q: Int?, n: Int?, result: Int) {
        self.a = a
        self.p = p
        self.b = b
        self.q = q
        self.n = n
        self.result = result
    }
}
