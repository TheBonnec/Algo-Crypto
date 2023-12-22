//
//  CyclicGroup.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData


@Model
class CyclicGroup {
    var n: Int?
    var result: Bool
    
    init(n: Int? = nil, result: Bool = false) {
        self.n = n
        self.result = result
    }
    
    func setEvery(n: Int?, result: Bool) {
        self.n = n
        self.result = result
    }
}
