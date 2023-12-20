//
//  EquivalenceClass.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 08/11/2023.
//

import Foundation
import SwiftData


@Model
final class EquivalenceClass {
    var a: Int?
    var n: Int?
    var equivalences: [Int]
    
    init(a: Int? = nil, n: Int? = nil, equivalences: [Int] = []) {
        self.a = a
        self.n = n
        self.equivalences = equivalences
    }
    
    func setEvery(a: Int?, n: Int?, equivalences: [Int]) {
        self.a = a
        self.n = n
        self.equivalences = equivalences
    }
}
