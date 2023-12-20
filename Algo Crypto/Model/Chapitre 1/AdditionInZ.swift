//
//  AdditionInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 08/11/2023.
//

import Foundation
import SwiftData


@Model
final class AdditionInZ {
    var a: Int?
    var b: Int?
    var n: Int?
    var result: Int
    
    init(a: Int? = nil, b: Int? = nil, n: Int? = nil, result: Int = 0) {
        self.a = a
        self.b = b
        self.n = n
        self.result = result
    }
    
    func setEvery(a: Int?, b: Int?, n: Int?, result: Int) {
        self.a = a
        self.b = b
        self.n = n
        self.result = result
    }
}
