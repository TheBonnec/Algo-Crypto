//
//  InverseInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InverseInZ {
    var a: Int?
    var n: Int?
    var inverse: Int
    
    init(a: Int? = nil, n: Int? = nil, inverse: Int = 0) {
        self.a = a
        self.n = n
        self.inverse = inverse
    }
    
    func setEvery(a: Int?, n: Int?, inverse: Int) {
        self.a = a
        self.n = n
        self.inverse = inverse
    }
}
