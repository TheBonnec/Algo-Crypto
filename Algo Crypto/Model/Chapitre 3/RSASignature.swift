//
//  RSASignature.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData


@Model
class RSASignature {
    var mode: RSASignatureMode
    var signature: Int?
    var dA: Int?
    var dB: Int?
    var eA: Int?
    var eB: Int?
    var nA: Int?
    var nB: Int?
    var result: Int
    
    init(mode: RSASignatureMode = .encrypt, signature: Int? = nil, dA: Int? = nil, dB: Int? = nil, eA: Int? = nil, eB: Int? = nil, nA: Int? = nil, nB: Int? = nil, result: Int = 0) {
        self.mode = mode
        self.signature = signature
        self.dA = dA
        self.dB = dB
        self.eA = eA
        self.eB = eB
        self.nA = nA
        self.nB = nB
        self.result = result
    }
    
    func setEvery(mode: RSASignatureMode, signature: Int?, dA: Int?, dB: Int?, eA: Int?, eB: Int?, nA: Int?, nB: Int?, result: Int) {
        self.mode = mode
        self.signature = signature
        self.dA = dA
        self.dB = dB
        self.eA = eA
        self.eB = eB
        self.nA = nA
        self.nB = nB
        self.result = result
    }
}



enum RSASignatureMode : Int, Codable {
    case encrypt = 0
    case decrypt = 1
}
