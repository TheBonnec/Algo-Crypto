//
//  ExtendedEuclidAlgo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftData


@Model
final class ExtendedEuclidAlgo {
    var a: Int?
    var b: Int?
    var u: Int
    var v: Int
    var r: Int?
    var q: Int?
    
    init() {
        self.a = nil
        self.b = nil
        self.u = 1
        self.v = 0
        self.r = nil
        self.q = nil
    }
    
    
    init(a: Int?, b: Int?, u: Int, v: Int, r: Int?, q: Int?) {
        self.a = a
        self.b = b
        self.u = u
        self.v = v
        self.r = r
        self.q = q
    }
}
