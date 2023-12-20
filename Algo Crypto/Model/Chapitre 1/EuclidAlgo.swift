//
//  EuclidAlgo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftData
import Combine


@Model
final class EuclidAlgo {
    var a: Int?
    var b: Int?
    var r: Int
    
    init(a: Int? = nil, b: Int? = nil, r: Int = 0) {
        self.a = a
        self.b = b
        self.r = r
    }
    
    func setEvery(a: Int?, b: Int?, r: Int) {
        self.a = a
        self.b = b
        self.r = r
    }
}
