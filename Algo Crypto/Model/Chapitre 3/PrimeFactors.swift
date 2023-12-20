//
//  PrimeFactors.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 25/11/2023.
//

import Foundation
import SwiftData


@Model
final class PrimeFactors {
    var n: Int?
    var factors: [Int]
    
    init(n: Int? = nil, factors: [Int] = []) {
        self.n = n
        self.factors = factors
    }
    
    func setEvery(n: Int?, factors: [Int]) {
        self.n = n
        self.factors = factors
    }
}
