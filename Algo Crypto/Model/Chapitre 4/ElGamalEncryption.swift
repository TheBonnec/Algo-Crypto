//
//  ElGamalEncryption.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData


@Model
class ElGamalEncryption {
    var mode: ElGamalEncryptionMode
    var message: Int?   // message à chiffrer / dechiffrer
    var n: Int?         // Z/nZ
    var g: Int?         // générateur
    var k: Int?         // nombre k aléatoire donné
    var r: Int?         // g^k
    var e: Int?         // clé publique
    var d: Int?         // clé privée
    var result: [Int]
    
    init(mode: ElGamalEncryptionMode = .encrypt, message: Int? = nil, n: Int? = nil, g: Int? = nil, k: Int? = nil, r: Int? = nil, e: Int? = nil, d: Int? = nil, result: [Int] = []) {
        self.mode = mode
        self.message = message
        self.n = n
        self.g = g
        self.k = k
        self.r = r
        self.e = e
        self.d = d
        self.result = result
    }
    
    func setEvery(mode: ElGamalEncryptionMode, message: Int?, n: Int?, g: Int?, k: Int?, r: Int?, e: Int?, d: Int?, result: [Int]) {
        self.mode = mode
        self.message = message
        self.n = n
        self.g = g
        self.k = k
        self.r = r
        self.e = e
        self.d = d
        self.result = result
    }
}



enum ElGamalEncryptionMode: Int, Codable {
    case encrypt = 0
    case decrypt = 1
}
