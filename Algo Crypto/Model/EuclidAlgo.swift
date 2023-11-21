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
    
    init() {
        self.a = nil
        self.b = nil
        self.r = 0
    }
    
    init(a: Int?, b: Int?, r: Int) {
        self.a = a
        self.b = b
        self.r = r
    }
}
