//
//  Modulo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import Foundation
import SwiftData


@Model
final class Modulo {
    var x: Int?
    var a: Int?
    var n: Int?
    var result: Int
    
    init(x: Int? = nil, a: Int? = nil, n: Int? = nil, result: Int = 0) {
        self.x = x
        self.a = a
        self.n = n
        self.result = result
    }
    
    func setEvery(x: Int?, a: Int?, n: Int?, result: Int) {
        self.x = x
        self.a = a
        self.n = n
        self.result = result
    }
}
