//
//  RSA.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData


@Model
class RSA {
    var mode: RSAMode
    var message: Int?
    var correctKey: Int?
    var oppositeKey: Int?
    var n: Int?
    var result: Int
    
    init(mode: RSAMode = .correctKey, message: Int? = nil, correctKey: Int? = nil, oppositeKey: Int? = nil, n: Int? = nil, result: Int = 0) {
        self.mode = mode
        self.message = message
        self.correctKey = correctKey
        self.oppositeKey = oppositeKey
        self.n = n
        self.result = result
    }
    
    func setEvery(mode: RSAMode, message: Int?, correctKey: Int?, oppositeKey: Int?, n: Int?, result: Int) {
        self.mode = mode
        self.message = message
        self.correctKey = correctKey
        self.oppositeKey = oppositeKey
        self.n = n
        self.result = result
    }
}


enum RSAMode: Int, Codable {
    case correctKey = 0
    case oppositeKey = 1
}
